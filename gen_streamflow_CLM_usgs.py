#--------------------------------------------------------------------------------------------------------------
# This is a Python3 script to convert CLM netcdf file to ascii file



#--------------------------------------------------------------------------------------------------------------
import numpy as np
import datetime
import os.path
# import copy
import math
import re
import csv
# from shutil import copyfile
# from scipy.io import netcdf
# from joblib import Parallel, delayed  
# import multiprocessing
import netCDF4
# import timeit
# from mpi4py import MPI
import os
# import wrf
# import pytz
# from tzwhere import tzwhere
from joblib import Parallel, delayed  
import multiprocessing

#--------------------------------------------------------------------------------------------------------------
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
# 1. specify datetime
s_year = 2005
e_year = 2014
date1 = datetime.date(s_year, 1, 1)
date2 = datetime.date(e_year, 12, 31)
num_days = abs(date2 - date1).days + 1

# 0-year, 1-month, 2-day, 
# 3- surface runoff (m3/s); 4-ground runoff (m3/s);  5-total runoff (m3/s) = surface + subsurface; 6-USGS obs (m3/s)
runoff = npnan(num_days, 7)  


# fill the date (no leap day)
count = 0
for day in range(num_days):
	temp_date = date1 + datetime.timedelta(days=day)
	if temp_date.month==2 and temp_date.day==29:
		continue
	else:
		runoff[count,0] = temp_date.year
		runoff[count,1] = temp_date.month
		runoff[count,2] = temp_date.day
		count += 1

# remove the NAN values
runoff = runoff[~np.isnan(runoff[:,0]), :]






num_basin = 464
basin_id = npnan(num_basin, 6)


file = '/global/u2/y/yanh869/CAMEL_NLDAS2_default_run_all_basin_results/selected_FID_basinID_region_areaKM2_area2cellRatio_numCells'
lines = [line.rstrip('\n') for line in open(file)]
num_basin = len(lines)
# load basin info
basin_id = []
basin_region = [] # HUC2 region 1-18
basin_area = []   # km2

for line in lines:
	item = line.split()	
	basin_id.append(item[1])           # str
	basin_region.append(int(item[2]))  # int
	basin_area.append(float(item[3]))  # float
















success_id = npnan(1341, 1)
file = './sucessful_par_id'
lines = [line.rstrip('\n') for line in open(file)]	
count = 0
for line in lines:
	success_id[count, 0] = float(line)
	count += 1









#--------------------------------------------------------------------------------------------------------------
# loop each ensemble members
def gen(k, success_id, basin_id, basin_region, basin_area, runoff):


	for m in range(464):


		file = './daily_runoff/par_%03d/basin_%s'  %(success_id[k,0], basin_id[m])	
		lines = [line.rstrip('\n') for line in open(file)]	
		count = 0
		for line in lines:
			item = line.split()	
			for i in range(len(item)):
				runoff[count, i] = float(item[i])
			count += 1


		runoff[:,3] = runoff[:,3] / (24*60*60)        # mm/day  -> mm/s
		runoff[:,4] = runoff[:,4] / (24*60*60)        
		runoff[:,5] = runoff[:,5] / (24*60*60)       
		

		runoff[:,3] = runoff[:,3] * basin_area[m] * 1000       # m3/s
		runoff[:,4] = runoff[:,4] * basin_area[m] * 1000       # m3/s
		runoff[:,5] = runoff[:,5] * basin_area[m] * 1000       # m3/s







		# ---------------------------------------------------------------------------------------------------------
		# load the USGS obs
		file = '/global/project/projectdirs/m2702/hongxiang/usgs_streamflow/%02d/%s_streamflow_qc.txt' %(basin_region[m], basin_id[m])
		lines = [line.rstrip('\n') for line in open(file)]
		temp = npnan(len(lines), 4)  # year, mon, day, flow (ft3/s)
		count = 0
		for line in lines:
			item = line.split()
			temp[count, 0] = float(item[1])
			temp[count, 1] = float(item[2])
			temp[count, 2] = float(item[3])
			temp[count, 3] = float(item[4])
			count += 1		
		

		usgs_flow = npnan(len(runoff[:,0]), 4)    
		usgs_flow[:,:3] = runoff[:,:3]         # the date is from s_date to e_date; note some usgs flow date donot cover the [s_date, e_date]

		for j in range(len(runoff[:,0])):
			index = finddate(int(runoff[j,0]), int(runoff[j,1]), int(runoff[j,2]), temp)
			if index<0:
				usgs_flow[j, 3] = -9999
			else:
				if temp[index,3] < 0:
					usgs_flow[j, 3] = -9999
				else:
					usgs_flow[j, 3] = temp[index,3]* 0.0283168    # fts/s -> m3/s

		runoff[:,6] = usgs_flow[:,3]






		# save the output
		if not os.path.isdir('./daily_streamflow/par_%03d' %(success_id[k,0],)):
			os.mkdir('./daily_streamflow/par_%03d' %(success_id[k,0],))		

		file_name = './daily_streamflow/par_%03d/basin_%s'  %(success_id[k,0], basin_id[m])

		myfile = open(file_name, 'w')
		for n in range(len(runoff[:,1])):
			myfile.write("%d %d %d %6.5f %6.5f %6.5f %6.5f\n" %(runoff[n,0], runoff[n,1], runoff[n,2], runoff[n,3], runoff[n,4], runoff[n,5], runoff[n,6]))
		myfile.close()

		print(success_id[k,0], m+1)





num_cores = multiprocessing.cpu_count()
num_cores = 48
Parallel(n_jobs=num_cores)(delayed(gen)(k, success_id, basin_id, basin_region, basin_area, runoff) for k in range(1341))