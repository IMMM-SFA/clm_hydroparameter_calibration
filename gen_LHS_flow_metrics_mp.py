# --------------------------------------------------------------------------------------------------------------
# Note: python3 version is Anaconda
# Python package: https://salib.readthedocs.io/en/latest/index.html



# --------------------------------------------------------------------------------------------------------------
import numpy as np
# import pandas as pd
import os
# import SALib.sample.morris
# import SALib.analyze.morris
from joblib import Parallel, delayed  
import multiprocessing
import shutil
import copy


#---------------------------------------------------------------------------------------------------------------
def npnan(x,y):
	# this function creates the np.nan 2d-array (np.nan should be float)
	array_2d = np.zeros((x,y), float) 
	array_2d[:] = np.nan
	return array_2d


#---------------------------------------------------------------------------------------------------------------
def npnan3(x,y,z):
	# this function creates the np.nan 2d-array (np.nan should be float)
	array_3d = np.zeros((x,y,z), float) 
	array_3d[:] = np.nan
	return array_3d


#--------------------------------------------------------------------------------------------------------------
def ecdf(sample):
	# convert sample to a numpy array, if it isn't already
	sample = np.atleast_1d(sample)
	# find the unique values and their corresponding counts
	quantiles, counts = np.unique(sample, return_counts=True)
	# take the cumulative sum of the counts and divide by the sample size to
	# get the cumulative probabilities between 0 and 1
	cumprob = np.cumsum(counts).astype(np.double) / (sample.size+1)
	return quantiles, cumprob



#--------------------------------------------------------------------------------------------------------------
def finddate(year,month,day,var):
	#given year month day and find the index number in the var array
	#if the year/month/day is not in the var, return error
	#input year/month/day: int
	var = var[:,:3]        #only contains the date
	var = var.astype(int)  #float to int
	date = np.array([year,month,day])
	temp = np.where(np.all(var==date, axis=1))  #return a tuple
	try:
		m = int(temp[0])
	except:
		m = -9999   # cannot find the index
	return m







def flow_E50(sim, obs):
	# sim, obs is a numpy array [time, 1] 
	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new
	sim = sim_new
	SE = np.sum((sim-obs)**2)
	SE_series = (sim-obs)**2
	SE_sort = np.sort(SE_series)[::-1]

	for i in range(len(SE_sort)-1):
		if np.sum(SE_sort[0:i])<(SE/2) and np.sum(SE_sort[0:(i+1)])>=(SE/2):
			out = i+1
	return out





#---------------------------------------------------------------------------------------------------------------
# whole time series, can be in daily scale or monthly scale
def flow_RMSE(sim, obs):
	# sim, obs is a numpy array [time, 1] 
	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new
	sim = sim_new
	out = (np.sum((sim-obs)**2)/len(obs))**0.5
	return out

def flow_TRMSE(sim, obs):
	# sim, obs is a numpy array [time, 1] 
	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new
	sim = sim_new

	lmada = 0.3
	obs_t = ((1+obs)**(lmada)-1)/lmada
	sim_t = ((1+sim)**(lmada)-1)/lmada

	out = (np.sum((sim_t-obs_t)**2)/len(obs_t))**0.5
	return out




def flow_MAE(sim, obs):
	# sim, obs is a numpy array [time, 1] 
	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new
	sim = sim_new
	out = np.mean(abs(sim-obs))
	return out

def flow_KGE(sim,obs):

	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new
	sim = sim_new

	if np.mean(obs)==0 or np.std(obs)==0 or np.mean(sim)==0 or np.std(sim)==0:
		KGE = -9999
	else:
		R = np.corrcoef(sim, obs)
		r = R[0,1]   # correlation
		alpha = np.std(sim)/np.std(obs)
		beta = np.mean(sim)/np.mean(obs)		
		KGE = 1 - ((r-1)**2 + (alpha-1)**2 + (beta-1)**2)**0.5
	return KGE


def flow_NSE(sim, obs):
	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new
	sim = sim_new	
	if np.mean(obs)==0:
		NSE = -9999
	else:
		NSE = 1 -  sum((sim-obs)**2)/sum((obs -np.mean(obs))**2)
	return NSE



#---------------------------------------------------------------------------------------------------------------
def flow_volume_bias(sim, obs):  # represent error in water balance (2013 Herman et al). beta in KGE
	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new
	sim = sim_new
	if np.sum(obs)==0:
		beta = np.nan
	else:
		beta = (np.sum(sim)-np.sum(obs))/np.sum(obs)*100		
	return beta


def flow_variance_bias(sim, obs):  # alpha in KGE
	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new
	sim = sim_new
	if np.var(obs)==0:
		alpha = np.nan
	else:
		alpha = (np.var(sim)-np.var(obs))/np.var(obs)*100
	return alpha




def flow_FDC_slope_bias(sim, obs):   

	# remove -9999/nan values in obs
	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new; del obs_new
	sim = sim_new; del sim_new

	obs25 = np.nan; obs75 = np.nan
	sim25 = np.nan; sim75 = np.nan
	slope_bias = np.nan

	qe, pe = ecdf(obs)   # quantiles: small -> large; non-exceedance probability: 0 -> 1
	for j in range(len(pe)-1):
		if pe[j]<0.25 and  (pe[j+1]>=0.25 and pe[j+1]<=0.26):
			obs25 = qe[j+1]; break;

	for j in range(len(pe)-1):
		if pe[j]<0.75 and  (pe[j+1]>=0.75 and pe[j+1]<=0.76):
			obs75 = qe[j+1]; break;


	qe, pe = ecdf(sim)   # quantiles: small -> large; non-exceedance probability: 0 -> 1
	for j in range(len(pe)-1):
		if pe[j]<0.25 and  (pe[j+1]>=0.25 and pe[j+1]<=0.26):
			sim25 = qe[j+1]; break;

	for j in range(len(pe)-1):
		if pe[j]<0.75 and  (pe[j+1]>=0.75 and pe[j+1]<=0.76):
			sim75 = qe[j+1]; break;




	if np.isnan(obs25)!=1 and np.isnan(obs75)!=1 and np.isnan(sim25)!=1 and np.isnan(sim75)!=1:
		slope_obs = (obs75 - obs25)/(0.75-0.25)
		slope_sim = (sim75 - sim25)/(0.75-0.25)

		if slope_obs==0:
			slope_bias = np.nan
		else:
			slope_bias = (slope_sim-slope_obs)/slope_obs*100

	return slope_bias








#---------------------------------------------------------------------------------------------------------------
def divide_flow_range(sim,obs):   # sim and obs can be in daily or monthly; divide using obs only 

	# remove -9999/nan values in obs
	obs_new = obs[obs>=0]
	sim_new = sim[obs>=0]
	obs = obs_new; del obs_new
	sim = sim_new; del sim_new

	qe, pe = ecdf(obs)   # quantiles: small -> large; non-exceedance probability: 0 -> 1
	reorder_pe = npnan(len(obs),1)  # reorder probability, assoicated with the original obs
	for i in range(len(obs)):
		index = np.where(qe == obs[i])
		assert(len(index)==1)
		reorder_pe[i,0] = pe[index]




	if pe[0]<=0.1:

		index = reorder_pe[:,0]<=0.1; assert(len(index)>=1)
		sim1 = sim[index]; obs1 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.1, reorder_pe[:,0]<=0.25); assert(len(index)>=1)
		sim2 = sim[index]; obs2 = obs[index]; 		

		index = np.logical_and(reorder_pe[:,0]>0.25, reorder_pe[:,0]<=0.5); assert(len(index)>=1)
		sim3 = sim[index]; obs3 = obs[index]; 	

		index = np.logical_and(reorder_pe[:,0]>0.5, reorder_pe[:,0]<=0.75); assert(len(index)>=1)
		sim4 = sim[index]; obs4 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.75, reorder_pe[:,0]<=0.9); assert(len(index)>=1)
		sim5 = sim[index]; obs5 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.9, reorder_pe[:,0]<=1); assert(len(index)>=1)
		sim6 = sim[index]; obs6 = obs[index]; 
	
	
	if pe[0]>0.1 and pe[0]<=0.25:

		sim1 = []; obs1 = []

		index = np.logical_and(reorder_pe[:,0]>0.1, reorder_pe[:,0]<=0.25); assert(len(index)>=1)
		sim2 = sim[index]; obs2 = obs[index]; 		

		index = np.logical_and(reorder_pe[:,0]>0.25, reorder_pe[:,0]<=0.5); assert(len(index)>=1)
		sim3 = sim[index]; obs3 = obs[index]; 	

		index = np.logical_and(reorder_pe[:,0]>0.5, reorder_pe[:,0]<=0.75); assert(len(index)>=1)
		sim4 = sim[index]; obs4 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.75, reorder_pe[:,0]<=0.9); assert(len(index)>=1)
		sim5 = sim[index]; obs5 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.9, reorder_pe[:,0]<=1); assert(len(index)>=1)
		sim6 = sim[index]; obs6 = obs[index]; 




	if pe[0]>0.25 and pe[0]<=0.5:

		sim1 = []; obs1 = []
		sim2 = []; obs2 = []

		index = np.logical_and(reorder_pe[:,0]>0.25, reorder_pe[:,0]<=0.5); assert(len(index)>=1)
		sim3 = sim[index]; obs3 = obs[index]; 	

		index = np.logical_and(reorder_pe[:,0]>0.5, reorder_pe[:,0]<=0.75); assert(len(index)>=1)
		sim4 = sim[index]; obs4 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.75, reorder_pe[:,0]<=0.9); assert(len(index)>=1)
		sim5 = sim[index]; obs5 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.9, reorder_pe[:,0]<=1); assert(len(index)>=1)
		sim6 = sim[index]; obs6 = obs[index]; 		



	if pe[0]>0.5 and pe[0]<=0.75:

		sim1 = []; obs1 = []
		sim2 = []; obs2 = []
		sim3 = []; obs3 = []

		index = np.logical_and(reorder_pe[:,0]>0.5, reorder_pe[:,0]<=0.75); assert(len(index)>=1)
		sim4 = sim[index]; obs4 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.75, reorder_pe[:,0]<=0.9); assert(len(index)>=1)
		sim5 = sim[index]; obs5 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.9, reorder_pe[:,0]<=1); assert(len(index)>=1)
		sim6 = sim[index]; obs6 = obs[index]; 	



	if pe[0]>0.75 and pe[0]<=0.9:

		sim1 = []; obs1 = []
		sim2 = []; obs2 = []
		sim3 = []; obs3 = []
		sim4 = []; obs4 = []

		index = np.logical_and(reorder_pe[:,0]>0.75, reorder_pe[:,0]<=0.9); assert(len(index)>=1)
		sim5 = sim[index]; obs5 = obs[index]; 

		index = np.logical_and(reorder_pe[:,0]>0.9, reorder_pe[:,0]<=1); assert(len(index)>=1)
		sim6 = sim[index]; obs6 = obs[index]; 	



	if pe[0]>0.9:

		sim1 = []; obs1 = []
		sim2 = []; obs2 = []
		sim3 = []; obs3 = []
		sim4 = []; obs4 = []
		sim5 = []; obs5 = []

		index = np.logical_and(reorder_pe[:,0]>0.9, reorder_pe[:,0]<=1); assert(len(index)>=1)
		sim6 = sim[index]; obs6 = obs[index]; 	


	return sim1, obs1, sim2, obs2, sim3, obs3, sim4, obs4, sim5, obs5, sim6, obs6
	












#---------------------------------------------------------------------------------------------------------------













# 10%, 25%, 50%, 75%, 90%



#---------------------------------------------------------------------------------------------------------------
def annual_flow_MAE(sim, obs, date_file):
	# sim, obs is a numpy array [time, 1] in daily scale
	# date_file is [timestep, 3] in year, mon, day

	obs_annual = []
	sim_annual = []

	obs = obs[obs>=0]
	sim = sim[obs>=0]
	date_file = date_file[obs>=0,:]

	s_yr = int(date_file[0, 0])
	e_yr = int(date_file[-1, 0])

	for yr in range(s_yr, e_yr+1):
		index = date_file[:,0]==yr
		if np.sum(index) >= (365-30):
			obs_annual.append(np.mean(obs[index]))
			sim_annual.append(np.mean(sim[index]))

	obs_annual = np.array(obs_annual)
	sim_annual = np.array(sim_annual)
	out = np.mean(abs(sim_annual-obs_annual))
	return out







#---------------------------------------------------------------------------------------------------------------
def monthly_flow_MAE(sim, obs, date_file, month):
	# sim, obs is a numpy array [time, 1] in daily scale
	# date_file is [timestep, 3] in year, mon, day
	# month: int from 1 to 12

	obs_month = []
	sim_month = []

	obs = obs[obs>=0]
	sim = sim[obs>=0]
	date_file = date_file[obs>=0,:]

	s_yr = int(date_file[0, 0])
	e_yr = int(date_file[-1, 0])

	for yr in range(s_yr, e_yr+1):
		index = np.logical_and(date_file[:,0]==yr, date_file[:,1]==month)
		if np.sum(index) >= 20:
			obs_month.append(np.mean(obs[index]))
			sim_month.append(np.mean(sim[index]))

	obs_month = np.array(obs_month)
	sim_month = np.array(sim_month)
	out = np.mean(abs(sim_month-obs_month))
	return out


#---------------------------------------------------------------------------------------------------------------
def seven_day_peak_flow_MAE(sim, obs, date_file):
	# sim, obs is a numpy array [time, 1] in daily scale
	# date_file is [timestep, 3] in year, mon, day

	obs_annual = []
	sim_annual = []

	obs = obs[obs>=0]
	sim = sim[obs>=0]
	date_file = date_file[obs>=0,:]

	s_yr = int(date_file[0, 0])
	e_yr = int(date_file[-1, 0])

	for yr in range(s_yr, e_yr+1):
		index = date_file[:,0]==yr
		if np.sum(index) >= (365-30):
			temp_obs = obs[index]
			temp_sim = sim[index]

			obs_7day_in_year =[]
			sim_7day_in_year =[]

			for i in range(len(temp_obs)-7+1):
				obs_7day_in_year.append(np.mean(temp_obs[i:i+7]))
				sim_7day_in_year.append(np.mean(temp_sim[i:i+7]))

			obs_annual.append(np.max(obs_7day_in_year))
			index = np.argmax(obs_7day_in_year)
			sim_annual.append(sim_7day_in_year[index])




	obs_annual = np.array(obs_annual)
	sim_annual = np.array(sim_annual)

	out = np.mean(abs(sim_annual-obs_annual))
	return out













# --------------------------------------------------------------------------------------------------------------
ensemble = 1333
nbasin = 464
OUT = npnan3(nbasin, ensemble+4, 100)  # 0-ID, 1-lat, 2-lon, 3-cluster, others - ensemble value;  3rd dimension, number of metrics
s_year = 2005
e_year = 2014
num_yr = e_year - s_year + 1

# load the basin ID and lat, lon
file = './basin_index_areaKM2.txt'
lines = [line.rstrip('\n') for line in open(file)]
count = 0
for line in lines:
	item = line.split()	
	OUT[count, 0, :] = float(item[0])  # 0-ID
	OUT[count, 1, :] = float(item[1])  # 1-lat
	OUT[count, 2, :] = float(item[2])  # 2-lon
	count+=1

# load the clustering ID
file = './camel_clustering_id.csv'
lines = [line.rstrip('\n') for line in open(file)]
lines = lines[1:]
count = 0
for line in lines:
	item = line.split(',')	
	lat = float(item[2])
	lon = float(item[3])
	for i in range(nbasin):
		if OUT[i,1,0]==lat and OUT[i,2,0]==lon:
			OUT[i,3,:] = float(item[4])  
			break

# load the successful par id number
par_id = []
file = './sucessful_par_id'
lines = [line.rstrip('\n') for line in open(file)]
for line in lines:
	par_id.append(float(line))









# --------------------------------------------------------------------------------------------------------------
# loop the ensembles
def gen(j, OUT, par_id):


	out = npnan(ensemble, 100)
	for i in range(ensemble):

		file = './daily_streamflow/par_%03d/basin_%08d' %(par_id[i], OUT[j,0,0])
		lines = [line.rstrip('\n') for line in open(file)]	
		data = npnan(num_yr*366, 5)   #0-year, 1-mon, 2-day, 3-sim, 4-obs in m3/s
		count = 0
		for line in lines:
			item = line.split()	
			data[count, 0] = float(item[0])  #year
			data[count, 1] = float(item[1])  #month
			data[count, 2] = float(item[2])  #day
			data[count, 3] = float(item[5])  #sim (m3/s)
			data[count, 4] = float(item[6])  #obs (m3/s)
			count += 1	
		index1 = finddate(s_year,1, 1, data)
		index2 = finddate(e_year,12,31,data)+1
		data_daily = data[index1:index2, :]     #0-year, 1-mon, 2-day, 3-sim, 4-obs in m3/s







		# agg into monthly
		data_monthly = npnan(num_yr*12, 4)      #0-year, 1-mon,  2-sim, 3-obs in m3/s
		count = 0
		for yr in range(s_year, e_year+1):
			temp1 = data_daily[data_daily[:,0]==yr,:]
			for mon in range(1,13):
				temp2 = temp1[temp1[:,1]==mon,:]
				data_monthly[count,0] = yr
				data_monthly[count,1] = mon
				data_monthly[count,2] = np.mean(temp2[:,3])
				if np.sum(temp2[:,4]>=0)==len(temp2[:,4]):
					data_monthly[count,3] = np.mean(temp2[:,4])
				else:
					data_monthly[count,3] = -9999
				count += 1


		# agg into weekly
		data_weekly = npnan(int(len(data_daily[:,0])/7), 5)  #0-year, 1-mon, 2-day, 3-sim, 4-obs in m3/s
		count = 0
		for k in range(int(len(data_daily[:,0])/7)):
			temp1 = data_daily[k*7:(k+1)*7,:]
			data_weekly[k, 0:3] = temp1[-1, 0:3]
			data_weekly[k, 3]   = np.mean(temp1[:,3])
			if np.sum(temp1[:,4]>=0)==len(temp1[:,4]):
				data_weekly[k, 4] = np.mean(temp1[:,4])
			else:
				data_weekly[k, 4] = -9999


		# agg into annually
		data_annually = npnan(num_yr, 3)  #0-year,  1-sim, 2-obs in m3/s
		count = 0
		for yr in range(s_year, e_year+1):
			data_annually[count,0] = yr
			temp1 = data_daily[data_daily[:,0]==yr,:]
			data_annually[count,1] = np.mean(temp1[:,3])
			if np.sum(temp1[:,4]>=0)==len(temp1[:,4]):
				data_annually[count,2] = np.mean(temp1[:,4])
			else:
				data_annually[count,2] = -9999
			count+=1


		if i ==0:
			ensemble_daily    = npnan(len(data_daily[:,0]), 1500)
			ensemble_weekly   = npnan(len(data_weekly[:,0]), 1500)
			ensemble_monthly  = npnan(len(data_monthly[:,0]), 1500)
			ensemble_annually = npnan(len(data_annually[:,0]), 1500)

		ensemble_daily[:,i]  = data_daily[:,3]
		ensemble_weekly[:,i] = data_weekly[:,3]
		ensemble_monthly[:,i] = data_monthly[:,2]
		ensemble_annually[:,i] = data_annually[:,1]










		# estimate the metric




		out[i,0] = flow_volume_bias(data_daily[:,3],   data_daily[:,4]);  
		out[i,1] = flow_volume_bias(data_weekly[:,3],  data_weekly[:,4]);  
		out[i,2] = flow_volume_bias(data_monthly[:,2], data_monthly[:,3]);  

		out[i,3] = flow_variance_bias(data_daily[:,3],   data_daily[:,4]);  
		out[i,4] = flow_variance_bias(data_weekly[:,3],  data_weekly[:,4]);  
		out[i,5] = flow_variance_bias(data_monthly[:,2], data_monthly[:,3]);  




		# divide flow into regime (some values maybe []): daily scale
		sim1, obs1, sim2, obs2, sim3, obs3, sim4, obs4, sim5, obs5, sim6, obs6  = divide_flow_range(data_daily[:,3],  data_daily[:,4])
		if len(obs1)>0:
			sim = sim1; obs = obs1; out[i,6] = flow_volume_bias(sim,obs); out[i,7] = flow_variance_bias(sim,obs); 
		if len(obs2)>0:
			sim = sim2; obs = obs2; out[i,8] = flow_volume_bias(sim,obs); out[i,9] = flow_variance_bias(sim,obs); 
		if len(obs3)>0:
			sim = sim3; obs = obs3; out[i,10] = flow_volume_bias(sim,obs); out[i,11] = flow_variance_bias(sim,obs); 
		if len(obs4)>0:
			sim = sim4; obs = obs4; out[i,12] = flow_volume_bias(sim,obs); out[i,13] = flow_variance_bias(sim,obs); 		
		if len(obs5)>0:
			sim = sim5; obs = obs5; out[i,14] = flow_volume_bias(sim,obs); out[i,15] = flow_variance_bias(sim,obs); 		
		if len(obs6)>0:
			sim = sim6; obs = obs6; out[i,16] = flow_volume_bias(sim,obs); out[i,17] = flow_variance_bias(sim,obs); 	
					
					
		# divide flow into regime (some values maybe []): weekly 
		sim1, obs1, sim2, obs2, sim3, obs3, sim4, obs4, sim5, obs5, sim6, obs6  = divide_flow_range(data_weekly[:,3],  data_weekly[:,4])
		if len(obs1)>0:
			sim = sim1; obs = obs1; out[i,18] = flow_volume_bias(sim,obs); out[i,19] = flow_variance_bias(sim,obs); 
		if len(obs2)>0:
			sim = sim2; obs = obs2; out[i,20] = flow_volume_bias(sim,obs); out[i,21] = flow_variance_bias(sim,obs); 
		if len(obs3)>0:
			sim = sim3; obs = obs3; out[i,22] = flow_volume_bias(sim,obs); out[i,23] = flow_variance_bias(sim,obs); 
		if len(obs4)>0:
			sim = sim4; obs = obs4; out[i,24] = flow_volume_bias(sim,obs); out[i,25] = flow_variance_bias(sim,obs); 		
		if len(obs5)>0:
			sim = sim5; obs = obs5; out[i,26] = flow_volume_bias(sim,obs); out[i,27] = flow_variance_bias(sim,obs); 		
		if len(obs6)>0:
			sim = sim6; obs = obs6; out[i,28] = flow_volume_bias(sim,obs); out[i,29] = flow_variance_bias(sim,obs); 	


		# divide flow into regime (some values maybe []): monthly
		sim1, obs1, sim2, obs2, sim3, obs3, sim4, obs4, sim5, obs5, sim6, obs6  = divide_flow_range(data_monthly[:,2],  data_monthly[:,3])
		if len(obs1)>0:
			sim = sim1; obs = obs1; out[i,30] = flow_volume_bias(sim,obs); out[i,31] = flow_variance_bias(sim,obs); 
		if len(obs2)>0:
			sim = sim2; obs = obs2; out[i,32] = flow_volume_bias(sim,obs); out[i,33] = flow_variance_bias(sim,obs); 
		if len(obs3)>0:
			sim = sim3; obs = obs3; out[i,34] = flow_volume_bias(sim,obs); out[i,35] = flow_variance_bias(sim,obs); 
		if len(obs4)>0:
			sim = sim4; obs = obs4; out[i,36] = flow_volume_bias(sim,obs); out[i,37] = flow_variance_bias(sim,obs); 		
		if len(obs5)>0:
			sim = sim5; obs = obs5; out[i,38] = flow_volume_bias(sim,obs); out[i,39] = flow_variance_bias(sim,obs); 		
		if len(obs6)>0:
			sim = sim6; obs = obs6; out[i,40] = flow_volume_bias(sim,obs); out[i,41] = flow_variance_bias(sim,obs); 	




		index = np.logical_or(np.logical_or(data_daily[:,1]==12, data_daily[:,1]==1), data_daily[:,1]==2)  # winter
		out[i,42] = flow_volume_bias(data_daily[index,3], data_daily[index,4])
		index = np.logical_or(np.logical_or(data_daily[:,1]==3, data_daily[:,1]==4), data_daily[:,1]==5)   # spring
		out[i,43] = flow_volume_bias(data_daily[index,3], data_daily[index,4])
		index = np.logical_or(np.logical_or(data_daily[:,1]==6, data_daily[:,1]==7), data_daily[:,1]==8)   # summer
		out[i,44] = flow_volume_bias(data_daily[index,3], data_daily[index,4])
		index = np.logical_or(np.logical_or(data_daily[:,1]==9, data_daily[:,1]==10), data_daily[:,1]==11) # fall
		out[i,45] = flow_volume_bias(data_daily[index,3], data_daily[index,4])

		index = np.logical_or(np.logical_or(data_weekly[:,1]==12, data_weekly[:,1]==1), data_weekly[:,1]==2)  # winter
		out[i,46] = flow_volume_bias(data_weekly[index,3], data_weekly[index,4])
		index = np.logical_or(np.logical_or(data_weekly[:,1]==3, data_weekly[:,1]==4), data_weekly[:,1]==5)   # spring
		out[i,47] = flow_volume_bias(data_weekly[index,3], data_weekly[index,4])
		index = np.logical_or(np.logical_or(data_weekly[:,1]==6, data_weekly[:,1]==7), data_weekly[:,1]==8)   # summer
		out[i,48] = flow_volume_bias(data_weekly[index,3], data_weekly[index,4])
		index = np.logical_or(np.logical_or(data_weekly[:,1]==9, data_weekly[:,1]==10), data_weekly[:,1]==11) # fall
		out[i,49] = flow_volume_bias(data_weekly[index,3], data_weekly[index,4])

		index = np.logical_or(np.logical_or(data_monthly[:,1]==12, data_monthly[:,1]==1), data_monthly[:,1]==2)  # winter
		out[i,50] = flow_volume_bias(data_monthly[index,2], data_monthly[index,3])
		index = np.logical_or(np.logical_or(data_monthly[:,1]==3, data_monthly[:,1]==4), data_monthly[:,1]==5)   # spring
		out[i,51] = flow_volume_bias(data_monthly[index,2], data_monthly[index,3])
		index = np.logical_or(np.logical_or(data_monthly[:,1]==6, data_monthly[:,1]==7), data_monthly[:,1]==8)   # summer
		out[i,52] = flow_volume_bias(data_monthly[index,2], data_monthly[index,3])
		index = np.logical_or(np.logical_or(data_monthly[:,1]==9, data_monthly[:,1]==10), data_monthly[:,1]==11) # fall
		out[i,53] = flow_volume_bias(data_monthly[index,2], data_monthly[index,3])


		out[i,54] = flow_FDC_slope_bias(data_daily[:,3], data_daily[:,4])
		out[i,55] = flow_E50(data_daily[:,3], data_daily[:,4])

		out[i,56] = flow_FDC_slope_bias(data_weekly[:,3], data_weekly[:,4])
		out[i,57] = flow_E50(data_weekly[:,3], data_weekly[:,4])

		out[i,58] = flow_FDC_slope_bias(data_monthly[:,2], data_monthly[:,3])
		out[i,59] = flow_E50(data_monthly[:,2], data_monthly[:,3])





		out[i,60] = flow_KGE(data_daily[:,3], data_daily[:,4])
		out[i,61] = flow_NSE(data_daily[:,3], data_daily[:,4])
		out[i,62] = flow_RMSE(data_daily[:,3], data_daily[:,4])
		out[i,63] = flow_TRMSE(data_daily[:,3], data_daily[:,4])
		out[i,64] = flow_MAE(data_daily[:,3], data_daily[:,4])


		out[i,65] = flow_KGE(data_monthly[:,2], data_monthly[:,3])
		out[i,66] = flow_NSE(data_monthly[:,2], data_monthly[:,3])
		out[i,67] = flow_RMSE(data_monthly[:,2], data_monthly[:,3])
		out[i,68] = flow_TRMSE(data_monthly[:,2], data_monthly[:,3])
		out[i,69] = flow_MAE(data_monthly[:,2], data_monthly[:,3])







		print(par_id[i], OUT[j,0,0])



	ensemble_daily    = ensemble_daily[:,~np.isnan(ensemble_daily[0,:])]
	ensemble_weekly   = ensemble_weekly[:,~np.isnan(ensemble_weekly[0,:])]
	ensemble_monthly  = ensemble_monthly[:,~np.isnan(ensemble_monthly[0,:])]
	ensemble_annually = ensemble_annually[:,~np.isnan(ensemble_annually[0,:])]

	# if OUT[j,0,0] == 2198100 or OUT[j,0,0] == 9065500:

	# 	np.savetxt('./flow_metrics/%08d_daily_ensemble'   %(OUT[j,0,0],),    ensemble_daily,   fmt='%6.5f '*ensemble)
	# 	np.savetxt('./flow_metrics/%08d_weekly_ensemble'  %(OUT[j,0,0],),    ensemble_weekly,   fmt='%6.5f '*ensemble)
	# 	np.savetxt('./flow_metrics/%08d_monthly_ensemble' %(OUT[j,0,0],),    ensemble_monthly,   fmt='%6.5f '*ensemble)
	# 	np.savetxt('./flow_metrics/%08d_annually_ensemble' %(OUT[j,0,0],),   ensemble_annually,   fmt='%6.5f '*ensemble)



	# save to the temporal file
	if not os.path.isdir('./temp'):
		os.mkdir('./temp')

	np.savetxt('./temp/out_basin_%08d' %(OUT[j,0,0],), out,  fmt='%6.5f '*(len(out[0,:])))





# --------------------------------------------------------------------------------------------------------------
# load the LHS ensembles
num_cores = multiprocessing.cpu_count()
num_cores = 48
Parallel(n_jobs=num_cores)(delayed(gen)(j, OUT, par_id) for j in range(nbasin))







out_header = ['daily_volume_bias', 'weekly_volume_bias', 'monthly_volume_bias', 'daily_variance_bias', 'weekly_variance_bias', 'monthly_variance_bias',
              'daily_q0_10_volume_bias', 'daily_q0_10_variance_bias','daily_q10_25_volume_bias', 'daily_q10_25_variance_bias', 'daily_q25_50_volume_bias', 'daily_q25_50_variance_bias',
              'daily_q50_75_volume_bias', 'daily_q50_75_variance_bias', 'daily_q75_90_volume_bias', 'daily_q75_90_variance_bias', 'daily_q90_100_volume_bias', 'daily_q90_100_variance_bias',
              'weekly_q0_10_volume_bias', 'weekly_q0_10_variance_bias','weekly_q10_25_volume_bias', 'weekly_q10_25_variance_bias', 'weekly_q25_50_volume_bias', 'weekly_q25_50_variance_bias',
              'weekly_q50_75_volume_bias', 'weekly_q50_75_variance_bias', 'weekly_q75_90_volume_bias', 'weekly_q75_90_variance_bias', 'weekly_q90_100_volume_bias', 'weekly_q90_100_variance_bias',
              'monthly_q0_10_volume_bias', 'monthly_q0_10_variance_bias','monthly_q10_25_volume_bias', 'monthly_q10_25_variance_bias', 'monthly_q25_50_volume_bias', 'monthly_q25_50_variance_bias',
              'monthly_q50_75_volume_bias', 'monthly_q50_75_variance_bias', 'monthly_q75_90_volume_bias', 'monthly_q75_90_variance_bias', 'monthly_q90_100_volume_bias', 'monthly_q90_100_variance_bias',
              'daily_winter_volume_bias', 'daily_spring_volume_bias', 'daily_summer_volume_bias', 'daily_fall_volume_bias',
              'weekly_winter_volume_bias', 'weekly_spring_volume_bias', 'weekly_summer_volume_bias', 'weekly_fall_volume_bias',
              'monthly_winter_volume_bias', 'monthly_spring_volume_bias', 'monthly_summer_volume_bias', 'monthly_fall_volume_bias',
              'daily_FDC_bias', 'daily_E50', 'weekly_FDC_bias', 'weekly_E50', 'monthly_FDC_bias', 'monthly_E50',
              'D-KGE', 'D-NSE', 'D-RMSE', 'D-TRMSE', 'D-MAE', 'M-KGE', 'M-NSE', 'M-RMSE', 'M-TRMSE', 'M-MAE']








# load the data
for i in range(nbasin):
	file = './temp/out_basin_%08d' %(OUT[i,0,0],)
	temp = npnan(ensemble, len(OUT[0,0,:]))
	lines = [line.rstrip('\n') for line in open(file)]	
	count = 0
	for line in lines:
		item = line.split()	
		for j in range(len(item)):
			temp[count, j] = float(item[j]) 
		count +=1

	OUT[i,4:,:] = temp[:,:]




for i in range(len(out_header)):
	temp = npnan(nbasin, ensemble+4)
	temp[:,:] = OUT[:,:,i]
	np.savetxt('./flow_metrics/OUT_%s.csv' %(out_header[i],), temp,  fmt='%08d,%f,%f,%d,' + '%6.5f,'*(ensemble))






