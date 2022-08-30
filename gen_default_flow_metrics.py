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
		KGE = np.nan
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
	if np.mean(obs)==0 or sum((obs -np.mean(obs))**2)==0:
		NSE = np.nan
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


def flow_weekly_autocorrelation(obs):   
	obs_new = obs[obs>=0]
	n = len(obs_new)
	obs_t0 = obs_new[0:n-1]
	obs_t1 = obs_new[1:n]
	R = np.corrcoef(obs_t0, obs_t1)
	r = R[0,1]   # correlation	
	return r

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
num_metric = 60
nbasin = 464
OUT = npnan(nbasin, num_metric+4)  # 0-ID, 1-lat, 2-lon, 3-cluster, others - metrics value
s_year = 2005
e_year = 2014
num_yr = e_year - s_year + 1

# load the basin ID and lat, lon
file = '/global/project/projectdirs/m2702/hongxiang/CAMEL_SA_ppe_run_NLDAS2_allbasin/nc_output_Livneh/basin_index_areaKM2.txt'
lines = [line.rstrip('\n') for line in open(file)]
count = 0
for line in lines:
	item = line.split()	
	OUT[count, 0] = float(item[0])  # 0-ID
	OUT[count, 1] = float(item[1])  # 1-lat
	OUT[count, 2] = float(item[2])  # 2-lon
	count+=1

# load the clustering ID
file = '/global/project/projectdirs/m2702/hongxiang/CAMEL_SA_ppe_run_NLDAS2_allbasin/nc_output_Livneh/camel_clustering_id.csv'
lines = [line.rstrip('\n') for line in open(file)]
lines = lines[1:]
count = 0
for line in lines:
	item = line.split(',')	
	lat = float(item[2])
	lon = float(item[3])
	for i in range(nbasin):
		if OUT[i,1]==lat and OUT[i,2]==lon:
			OUT[i,3] = float(item[4])  
			break



OUT_daily    = copy.deepcopy(OUT)
OUT_monthly  = copy.deepcopy(OUT)
OUT_weekly   = copy.deepcopy(OUT)
OUT_annually   = copy.deepcopy(OUT)



# --------------------------------------------------------------------------------------------------------------
# loop the basin
for i in range(nbasin):

	# load the CLM runoff data
	file = '/global/project/projectdirs/m2702/hongxiang/CAMEL_allbasin_default_ppe_run/clm_archive/CAMEL_allbasin_default_ppe_run/lnd/hist/Livneh_v3_2005_2014/basin_%08d' %(OUT[i,0],)
	lines = [line.rstrip('\n') for line in open(file)]	
	data = npnan(40*366, 5)   #0-year, 1-mon, 2-day, 3-sim, 4-obs in m3/s
	count = 0
	for line in lines:
		item = line.split()	
		data[count, 0] = float(item[0])  #year
		data[count, 1] = float(item[1])  #month
		data[count, 2] = float(item[2])  #day
		data[count, 3] = float(item[5])  #sim (m3/s)
		count += 1	
	index1 = finddate(s_year,1, 1, data)
	index2 = finddate(e_year,12,31,data)+1
	data_daily = data[index1:index2, :]

	# load the USGS flow
	file = '/global/project/projectdirs/m2702/hongxiang/CAMEL_SA_ppe_run_NLDAS2_allbasin/nc_output_Livneh/daily_streamflow/par_001/basin_%08d' %(OUT[i,0],)
	lines = [line.rstrip('\n') for line in open(file)]	
	count = 0
	for line in lines:
		item = line.split()	
		data_daily[count, 4] = float(item[6])  #sim (m3/s)
		count += 1	


	# agg into monthly
	data_monthly = npnan(num_yr*12, 4)  #0-year, 1-mon,  2-sim, 3-obs in m3/s
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
	for j in range(int(len(data_daily[:,0])/7)):
		temp1 = data_daily[j*7:(j+1)*7,:]
		data_weekly[j, 0:3] = temp1[-1, 0:3]
		data_weekly[j, 3]   = np.mean(temp1[:,3])
		if np.sum(temp1[:,4]>=0)==len(temp1[:,4]):
			data_weekly[j, 4] = np.mean(temp1[:,4])
		else:
			data_weekly[j, 4] = -9999


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




	# if OUT[i,0] == 2198100 or OUT[i,0] == 9065500:
	# 	np.savetxt('./flow_metrics/%08d_daily'   %(OUT[i,0],),    data_daily,   fmt='%6.5f '*5)
	# 	np.savetxt('./flow_metrics/%08d_weekly'  %(OUT[i,0],),    data_weekly,   fmt='%6.5f '*5)
	# 	np.savetxt('./flow_metrics/%08d_monthly' %(OUT[i,0],),    data_monthly,   fmt='%6.5f '*4)
	# 	np.savetxt('./flow_metrics/%08d_annually' %(OUT[i,0],),    data_annually,   fmt='%6.5f '*3)


	# find the seasonal flow 





	# # calculate the metrics
	# OUT_weekly[i,4] = flow_weekly_autocorrelation(data_weekly[:, 4])





	

	OUT_daily[i,4] = flow_RMSE(data_daily[:,3],  data_daily[:,4])
	OUT_daily[i,5] = flow_NSE(data_daily[:,3],   data_daily[:,4])
	OUT_daily[i,6] = flow_KGE(data_daily[:,3],   data_daily[:,4])
	OUT_daily[i,7] = flow_MAE(data_daily[:,3],   data_daily[:,4])
	OUT_daily[i,8] = flow_TRMSE(data_daily[:,3], data_daily[:,4])
	OUT_daily[i,39] = flow_volume_bias(data_daily[:,3], data_daily[:,4])
	OUT_daily[i,40] = flow_variance_bias(data_daily[:,3], data_daily[:,4])
	OUT_daily[i,53] = flow_FDC_slope_bias(data_daily[:,3], data_daily[:,4])
	OUT_daily[i,54] = flow_E50(data_daily[:,3],  data_daily[:,4])

	index = np.logical_or(np.logical_or(data_daily[:,1]==12, data_daily[:,1]==1), data_daily[:,1]==2)  # winter
	OUT_daily[i,55] = flow_volume_bias(data_daily[index,3], data_daily[index,4])
	index = np.logical_or(np.logical_or(data_daily[:,1]==3, data_daily[:,1]==4), data_daily[:,1]==5)   # spring
	OUT_daily[i,56] = flow_volume_bias(data_daily[index,3], data_daily[index,4])
	index = np.logical_or(np.logical_or(data_daily[:,1]==6, data_daily[:,1]==7), data_daily[:,1]==8)   # summer
	OUT_daily[i,57] = flow_volume_bias(data_daily[index,3], data_daily[index,4])
	index = np.logical_or(np.logical_or(data_daily[:,1]==9, data_daily[:,1]==10), data_daily[:,1]==11) # fall
	OUT_daily[i,58] = flow_volume_bias(data_daily[index,3], data_daily[index,4])






	OUT_monthly[i,4] = flow_RMSE(data_monthly[:,2],  data_monthly[:,3])
	OUT_monthly[i,5] = flow_NSE(data_monthly[:,2],   data_monthly[:,3])
	OUT_monthly[i,6] = flow_KGE(data_monthly[:,2],   data_monthly[:,3])
	OUT_monthly[i,7] = flow_MAE(data_monthly[:,2],   data_monthly[:,3])
	OUT_monthly[i,8] = flow_TRMSE(data_monthly[:,2], data_monthly[:,3])
	OUT_monthly[i,39] = flow_volume_bias(data_monthly[:,2], data_monthly[:,3])
	OUT_monthly[i,40] = flow_variance_bias(data_monthly[:,2], data_monthly[:,3])
	OUT_monthly[i,53] = flow_FDC_slope_bias(data_monthly[:,2], data_monthly[:,3])
	OUT_monthly[i,54] = flow_E50(data_monthly[:,2],  data_monthly[:,3])

	index = np.logical_or(np.logical_or(data_monthly[:,1]==12, data_monthly[:,1]==1), data_monthly[:,1]==2)  # winter
	OUT_monthly[i,55] = flow_volume_bias(data_monthly[index,2], data_monthly[index,3])
	index = np.logical_or(np.logical_or(data_monthly[:,1]==3, data_monthly[:,1]==4), data_monthly[:,1]==5)   # spring
	OUT_monthly[i,56] = flow_volume_bias(data_monthly[index,2], data_monthly[index,3])
	index = np.logical_or(np.logical_or(data_monthly[:,1]==6, data_monthly[:,1]==7), data_monthly[:,1]==8)   # summer
	OUT_monthly[i,57] = flow_volume_bias(data_monthly[index,2], data_monthly[index,3])
	index = np.logical_or(np.logical_or(data_monthly[:,1]==9, data_monthly[:,1]==10), data_monthly[:,1]==11) # fall
	OUT_monthly[i,58] = flow_volume_bias(data_monthly[index,2], data_monthly[index,3])







	OUT_weekly[i,4] = flow_RMSE(data_weekly[:,3],  data_weekly[:,4])
	OUT_weekly[i,5] = flow_NSE(data_weekly[:,3],   data_weekly[:,4])
	OUT_weekly[i,6] = flow_KGE(data_weekly[:,3],   data_weekly[:,4])
	OUT_weekly[i,7] = flow_MAE(data_weekly[:,3],   data_weekly[:,4])
	OUT_weekly[i,8] = flow_TRMSE(data_weekly[:,3], data_weekly[:,4])
	OUT_weekly[i,39] = flow_volume_bias(data_weekly[:,3], data_weekly[:,4])
	OUT_weekly[i,40] = flow_variance_bias(data_weekly[:,3], data_weekly[:,4])
	OUT_weekly[i,53] = flow_FDC_slope_bias(data_weekly[:,3], data_weekly[:,4])
	OUT_weekly[i,54] = flow_E50(data_weekly[:,3],  data_weekly[:,4])


	index = np.logical_or(np.logical_or(data_weekly[:,1]==12, data_weekly[:,1]==1), data_weekly[:,1]==2)  # winter
	OUT_weekly[i,55] = flow_volume_bias(data_weekly[index,3], data_weekly[index,4])
	index = np.logical_or(np.logical_or(data_weekly[:,1]==3, data_weekly[:,1]==4), data_weekly[:,1]==5)   # spring
	OUT_weekly[i,56] = flow_volume_bias(data_weekly[index,3], data_weekly[index,4])
	index = np.logical_or(np.logical_or(data_weekly[:,1]==6, data_weekly[:,1]==7), data_weekly[:,1]==8)   # summer
	OUT_weekly[i,57] = flow_volume_bias(data_weekly[index,3], data_weekly[index,4])
	index = np.logical_or(np.logical_or(data_weekly[:,1]==9, data_weekly[:,1]==10), data_weekly[:,1]==11) # fall
	OUT_weekly[i,58] = flow_volume_bias(data_weekly[index,3], data_weekly[index,4])






	# divide flow into regime (some values maybe []): daily scale
	sim1, obs1, sim2, obs2, sim3, obs3, sim4, obs4, sim5, obs5, sim6, obs6  = divide_flow_range(data_daily[:,3],  data_daily[:,4])

	if len(obs1)>0:
		sim = sim1; obs = obs1;
		OUT_daily[i,9]  = flow_RMSE(sim,obs); OUT_daily[i,10] = flow_NSE(sim,obs); OUT_daily[i,11] = flow_KGE(sim,obs); OUT_daily[i,12] = flow_MAE(sim,obs); OUT_daily[i,13] = flow_TRMSE(sim,obs)
		OUT_daily[i,41] = flow_volume_bias(sim,obs); OUT_daily[i,42] = flow_variance_bias(sim,obs); 
	if len(obs2)>0:
		sim = sim2; obs = obs2;
		OUT_daily[i,14]  = flow_RMSE(sim,obs); OUT_daily[i,15] = flow_NSE(sim,obs); OUT_daily[i,16] = flow_KGE(sim,obs); OUT_daily[i,17] = flow_MAE(sim,obs); OUT_daily[i,18] = flow_TRMSE(sim,obs)	
		OUT_daily[i,43] = flow_volume_bias(sim,obs); OUT_daily[i,44] = flow_variance_bias(sim,obs); 	
	if len(obs3)>0:
		sim = sim3; obs = obs3;
		OUT_daily[i,19]  = flow_RMSE(sim,obs); OUT_daily[i,20] = flow_NSE(sim,obs); OUT_daily[i,21] = flow_KGE(sim,obs); OUT_daily[i,22] = flow_MAE(sim,obs); OUT_daily[i,23] = flow_TRMSE(sim,obs)		
		OUT_daily[i,45] = flow_volume_bias(sim,obs); OUT_daily[i,46] = flow_variance_bias(sim,obs); 			
	if len(obs4)>0:
		sim = sim4; obs = obs4;
		OUT_daily[i,24]  = flow_RMSE(sim,obs); OUT_daily[i,25] = flow_NSE(sim,obs); OUT_daily[i,26] = flow_KGE(sim,obs); OUT_daily[i,27] = flow_MAE(sim,obs); OUT_daily[i,28] = flow_TRMSE(sim,obs)	
		OUT_daily[i,47] = flow_volume_bias(sim,obs); OUT_daily[i,48] = flow_variance_bias(sim,obs); 				
	if len(obs5)>0:
		sim = sim5; obs = obs5;
		OUT_daily[i,29]  = flow_RMSE(sim,obs); OUT_daily[i,30] = flow_NSE(sim,obs); OUT_daily[i,31] = flow_KGE(sim,obs); OUT_daily[i,32] = flow_MAE(sim,obs); OUT_daily[i,33] = flow_TRMSE(sim,obs)	
		OUT_daily[i,49] = flow_volume_bias(sim,obs); OUT_daily[i,50] = flow_variance_bias(sim,obs); 				
	if len(obs6)>0:
		sim = sim6; obs = obs6;
		OUT_daily[i,34]  = flow_RMSE(sim,obs); OUT_daily[i,35] = flow_NSE(sim,obs); OUT_daily[i,36] = flow_KGE(sim,obs); OUT_daily[i,37] = flow_MAE(sim,obs); OUT_daily[i,38] = flow_TRMSE(sim,obs)		
		OUT_daily[i,51] = flow_volume_bias(sim,obs); OUT_daily[i,52] = flow_variance_bias(sim,obs); 			

















	# divide flow into regime (some values maybe []): monthly scale
	sim1, obs1, sim2, obs2, sim3, obs3, sim4, obs4, sim5, obs5, sim6, obs6  = divide_flow_range(data_monthly[:,2],  data_monthly[:,3])
	if len(obs1)>0:
		sim = sim1; obs = obs1;
		OUT_monthly[i,9]  = flow_RMSE(sim,obs); OUT_monthly[i,10] = flow_NSE(sim,obs); OUT_monthly[i,11] = flow_KGE(sim,obs); OUT_monthly[i,12] = flow_MAE(sim,obs); OUT_monthly[i,13] = flow_TRMSE(sim,obs)
		OUT_monthly[i,41] = flow_volume_bias(sim,obs); OUT_monthly[i,42] = flow_variance_bias(sim,obs); 
	if len(obs2)>0:
		sim = sim2; obs = obs2;
		OUT_monthly[i,14]  = flow_RMSE(sim,obs); OUT_monthly[i,15] = flow_NSE(sim,obs); OUT_monthly[i,16] = flow_KGE(sim,obs); OUT_monthly[i,17] = flow_MAE(sim,obs); OUT_monthly[i,18] = flow_TRMSE(sim,obs)	
		OUT_monthly[i,43] = flow_volume_bias(sim,obs); OUT_monthly[i,44] = flow_variance_bias(sim,obs); 	
	if len(obs3)>0:
		sim = sim3; obs = obs3;
		OUT_monthly[i,19]  = flow_RMSE(sim,obs); OUT_monthly[i,20] = flow_NSE(sim,obs); OUT_monthly[i,21] = flow_KGE(sim,obs); OUT_monthly[i,22] = flow_MAE(sim,obs); OUT_monthly[i,23] = flow_TRMSE(sim,obs)
		OUT_monthly[i,45] = flow_volume_bias(sim,obs); OUT_monthly[i,46] = flow_variance_bias(sim,obs); 				
	if len(obs4)>0:
		sim = sim4; obs = obs4;
		OUT_monthly[i,24]  = flow_RMSE(sim,obs); OUT_monthly[i,25] = flow_NSE(sim,obs); OUT_monthly[i,26] = flow_KGE(sim,obs); OUT_monthly[i,27] = flow_MAE(sim,obs); OUT_monthly[i,28] = flow_TRMSE(sim,obs)	
		OUT_monthly[i,47] = flow_volume_bias(sim,obs); OUT_monthly[i,48] = flow_variance_bias(sim,obs); 			
	if len(obs5)>0:
		sim = sim5; obs = obs5;
		OUT_monthly[i,29]  = flow_RMSE(sim,obs); OUT_monthly[i,30] = flow_NSE(sim,obs); OUT_monthly[i,31] = flow_KGE(sim,obs); OUT_monthly[i,32] = flow_MAE(sim,obs); OUT_monthly[i,33] = flow_TRMSE(sim,obs)
		OUT_monthly[i,49] = flow_volume_bias(sim,obs); OUT_monthly[i,50] = flow_variance_bias(sim,obs); 				
	if len(obs6)>0:
		sim = sim6; obs = obs6;
		OUT_monthly[i,34]  = flow_RMSE(sim,obs); OUT_monthly[i,35] = flow_NSE(sim,obs); OUT_monthly[i,36] = flow_KGE(sim,obs); OUT_monthly[i,37] = flow_MAE(sim,obs); OUT_monthly[i,38] = flow_TRMSE(sim,obs)
		OUT_monthly[i,51] = flow_volume_bias(sim,obs); OUT_monthly[i,52] = flow_variance_bias(sim,obs); 	



	# divide flow into regime (some values maybe []): weekly scale
	sim1, obs1, sim2, obs2, sim3, obs3, sim4, obs4, sim5, obs5, sim6, obs6  = divide_flow_range(data_weekly[:,3],  data_weekly[:,4])
	if len(obs1)>0:
		sim = sim1; obs = obs1;
		OUT_weekly[i,9]  = flow_RMSE(sim,obs); OUT_weekly[i,10] = flow_NSE(sim,obs); OUT_weekly[i,11] = flow_KGE(sim,obs); OUT_weekly[i,12] = flow_MAE(sim,obs); OUT_weekly[i,13] = flow_TRMSE(sim,obs)
		OUT_weekly[i,41] = flow_volume_bias(sim,obs); OUT_weekly[i,42] = flow_variance_bias(sim,obs); 
	if len(obs2)>0:
		sim = sim2; obs = obs2;
		OUT_weekly[i,14]  = flow_RMSE(sim,obs); OUT_weekly[i,15] = flow_NSE(sim,obs); OUT_weekly[i,16] = flow_KGE(sim,obs); OUT_weekly[i,17] = flow_MAE(sim,obs); OUT_weekly[i,18] = flow_TRMSE(sim,obs)	
		OUT_weekly[i,43] = flow_volume_bias(sim,obs); OUT_weekly[i,44] = flow_variance_bias(sim,obs); 	
	if len(obs3)>0:
		sim = sim3; obs = obs3;
		OUT_weekly[i,19]  = flow_RMSE(sim,obs); OUT_weekly[i,20] = flow_NSE(sim,obs); OUT_weekly[i,21] = flow_KGE(sim,obs); OUT_weekly[i,22] = flow_MAE(sim,obs); OUT_weekly[i,23] = flow_TRMSE(sim,obs)
		OUT_weekly[i,45] = flow_volume_bias(sim,obs); OUT_weekly[i,46] = flow_variance_bias(sim,obs); 				
	if len(obs4)>0:
		sim = sim4; obs = obs4;
		OUT_weekly[i,24]  = flow_RMSE(sim,obs); OUT_weekly[i,25] = flow_NSE(sim,obs); OUT_weekly[i,26] = flow_KGE(sim,obs); OUT_weekly[i,27] = flow_MAE(sim,obs); OUT_weekly[i,28] = flow_TRMSE(sim,obs)	
		OUT_weekly[i,47] = flow_volume_bias(sim,obs); OUT_weekly[i,48] = flow_variance_bias(sim,obs); 			
	if len(obs5)>0:
		sim = sim5; obs = obs5;
		OUT_weekly[i,29]  = flow_RMSE(sim,obs); OUT_weekly[i,30] = flow_NSE(sim,obs); OUT_weekly[i,31] = flow_KGE(sim,obs); OUT_weekly[i,32] = flow_MAE(sim,obs); OUT_weekly[i,33] = flow_TRMSE(sim,obs)
		OUT_weekly[i,49] = flow_volume_bias(sim,obs); OUT_weekly[i,50] = flow_variance_bias(sim,obs); 				
	if len(obs6)>0:
		sim = sim6; obs = obs6;
		OUT_weekly[i,34]  = flow_RMSE(sim,obs); OUT_weekly[i,35] = flow_NSE(sim,obs); OUT_weekly[i,36] = flow_KGE(sim,obs); OUT_weekly[i,37] = flow_MAE(sim,obs); OUT_weekly[i,38] = flow_TRMSE(sim,obs)
		OUT_weekly[i,51] = flow_volume_bias(sim,obs); OUT_weekly[i,52] = flow_variance_bias(sim,obs); 	










	print(i)




daily_header = "basin_id,lat,lon,cluster_id,RMSE,NSE,KGE,MAE,TRMSE,\
                Q0-10_RMSE,Q0-10_NSE,Q0-10_KGE,Q0-10_MAE,Q0-10_TRMSE,\
                Q10-25_RMSE,Q10-25_NSE,Q10-25_KGE,Q10-25_MAE,Q10-25_TRMSE,\
                Q25-50_RMSE,Q25-50_NSE,Q25-50_KGE,Q25-50_MAE,Q25-50_TRMSE,\
                Q50-75_RMSE,Q50-75_NSE,Q50-75_KGE,Q50-75_MAE,Q50-75_TRMSE,\
                Q75-90_RMSE,Q75-90_NSE,Q75-90_KGE,Q75-90_MAE,Q75-90_TRMSE,\
                Q90-100_RMSE,Q90-100_NSE,Q90-100_KGE,Q90-100_MAE,Q90-100_TRMSE,\
                Volume_bias,variance_bias,Q0-10_volume_bias,Q0-10_variance_bias,\
                Q10-25_volume_bias,Q10-25_variance_bias, Q25-50_volume_bias,Q25-50_variance_bias,\
                Q50-75_volume_bias,Q50-75_variance_bias, Q75-90_volume_bias,Q75-90_variance_bias,\
                Q90-100_volume_bias,Q90-100_variance_bias,FDC_slope_bias,E50,winter_volume_bias, spring_volume_bias, summer_volume_bias, fall_volume_bias\
"






np.savetxt('./flow_metrics/default_daily_metrics.csv',    OUT_daily,   header=daily_header, fmt='%08d,%f,%f,%d,' + '%6.5f,'*(num_metric))
np.savetxt('./flow_metrics/default_monthly_metrics.csv',  OUT_monthly, header=daily_header, fmt='%08d,%f,%f,%d,' + '%6.5f,'*(num_metric))
np.savetxt('./flow_metrics/default_weekly_metrics.csv',   OUT_weekly,  header=daily_header, fmt='%08d,%f,%f,%d,' + '%6.5f,'*(num_metric))
