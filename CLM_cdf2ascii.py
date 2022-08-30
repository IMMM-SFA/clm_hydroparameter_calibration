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
from joblib import Parallel, delayed  
import multiprocessing
import netCDF4
# import timeit
# from mpi4py import MPI
import os
# import wrf
# import pytz
# from tzwhere import tzwhere


#--------------------------------------------------------------------------------------------------------------
def npnan(x,y):
	# this function creates the np.nan 2d-array (np.nan should be float)
 	array_2d = np.zeros((x,y), float) 
 	array_2d[:] = np.nan
 	return array_2d


#--------------------------------------------------------------------------------------------------------------
# 1. specify datetime
s_year = 2005
e_year = 2014
date1 = datetime.date(s_year, 1, 1)
date2 = datetime.date(e_year, 12, 31)
num_days = abs(date2 - date1).days + 1

# 0-year, 1-month, 2-day, 
# 3- surface runoff (mm/s); 4-ground runoff (mm/s);  5-total runoff (mm/s) = surface + subsurface
runoff = npnan(num_days, 6)  

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




# load the 2d lat and lon and mask
lat_2d = npnan(464, 464)
lon_2d = npnan(464, 464)
mask =   npnan(464, 464)

basin_id = npnan(464, 6)



# load the camel basin outlet coordinates
coor_outlet = npnan(num_basin ,2) #0-lat, 1-lon
file = '/global/u2/y/yanh869/gen_464x464camelbasin_CLM_domain_surface_forcing/camel_gauge_coor.txt'
lines = [line.rstrip('\n') for line in open(file)]	
count = 0
for line in lines:
	item = line.split()	
	coor_outlet[count, 0] = float(item[1])
	coor_outlet[count, 1] = float(item[2])+360
	count += 1

file = '/global/u2/y/yanh869/gen_464x464camelbasin_CLM_domain_surface_forcing/camel_lat_2d.txt'
lines = [line.rstrip('\n') for line in open(file)]	
count = 0
for line in lines:
	item = line.split()	
	for i in range(len(item)):
		lat_2d[count, i] = float(item[i])
	count += 1

file = '/global/u2/y/yanh869/gen_464x464camelbasin_CLM_domain_surface_forcing/camel_lon_2d.txt'
lines = [line.rstrip('\n') for line in open(file)]	
count = 0
for line in lines:
	item = line.split()	
	for i in range(len(item)):
		lon_2d[count, i] = float(item[i]) + 360
	count += 1

file = '/global/u2/y/yanh869/gen_464x464camelbasin_CLM_domain_surface_forcing/camel_mask.txt'
lines = [line.rstrip('\n') for line in open(file)]	
count = 0
for line in lines:
	item = line.split()	
	for i in range(len(item)):
		mask[count, i] = float(item[i])
	count += 1




# load the basin index id based on mask file
file = './basin_index_areaKM2.txt'
lines = [line.rstrip('\n') for line in open(file)]	
count = 0
for line in lines:
	item = line.split()	
	for i in range(len(item)):
		basin_id[count, i] = float(item[i])
	count += 1



basin_area = basin_id[:,5]



success_id = npnan(1341, 1)
file = './sucessful_par_id'
lines = [line.rstrip('\n') for line in open(file)]	
count = 0
for line in lines:
	success_id[count, 0] = float(line)
	count += 1




#--------------------------------------------------------------------------------------------------------------
# loop each ensemble members
def gen(k, success_id):

	# load the netcdf into RAM first

	list_nc_file = []  
	for yr in range(s_year, e_year+1):
		file_dir = '/global/project/projectdirs/m2702/hongxiang/CAMEL_SA_ppe_run_NLDAS2_allbasin/para_%03d/clm_archive/para_%03d/lnd/hist/para_%03d.clm2.h0.%d-01-01-00000.nc' %(success_id[k], success_id[k], success_id[k], yr)
		list_nc_file.append(netCDF4.Dataset(file_dir, 'r'))



	# 2. loop each year and output runoff for each gridcell
	# loop each cell
	for m in range(464):

		# load runoff output 
		count = 0
		for i in range(len(list_nc_file)):
			days = list_nc_file[i].variables['QRUNOFF'].shape[0]  # mm/s



			runoff[count:(count+days), 3] = list_nc_file[i].variables['QOVER'][:,m]
			runoff[count:(count+days), 3] = list_nc_file[i].variables['QH2OSFC'][:,m] + runoff[count:(count+days), 3]

			runoff[count:(count+days), 4] = list_nc_file[i].variables['QDRAI'][:,m]
			runoff[count:(count+days), 4] = list_nc_file[i].variables['QDRAI_PERCH'][:,m] + runoff[count:(count+days), 4]		

			runoff[count:(count+days), 5] = runoff[count:(count+days), 3] + runoff[count:(count+days), 4]

			count = count + days

		
		runoff[runoff[:,3]>1e5, 3] = -9999 # in the CLM output, the nan value is given a huge value: 1e36
		runoff[runoff[:,4]>1e5, 4] = -9999 # in the CLM output, the nan value is given a huge value: 1e36
		runoff[runoff[:,5]>1e5, 5] = -9999 # in the CLM output, the nan value is given a huge value: 1e36
		

		# runoff[:,3] = runoff[:,3] * basin_area[m] * 1000       # m3/s
		# runoff[:,4] = runoff[:,4] * basin_area[m] * 1000       # m3/s
		# runoff[:,5] = runoff[:,5] * basin_area[m] * 1000       # m3/s


		runoff[:,3] = runoff[:,3] * 24*60*60        # mm/day
		runoff[:,4] = runoff[:,4] * 24*60*60        # mm/day
		runoff[:,5] = runoff[:,5] * 24*60*60        # mm/day





		# save the output
		if not os.path.isdir('./daily_runoff/par_%03d' %(success_id[k],)):
			os.mkdir('./daily_runoff/par_%03d' %(success_id[k],))		



		file_name = './daily_runoff/par_%03d/basin_%08d'  %(success_id[k], basin_id[m,0])




		myfile = open(file_name, 'w')
		for n in range(len(runoff[:,1])):
			myfile.write("%d %d %d %6.5f %6.5f %6.5f\n" %(runoff[n,0], runoff[n,1], runoff[n,2], runoff[n,3], runoff[n,4], runoff[n,5]))
		myfile.close()

		print(k+1, m+1)







num_cores = multiprocessing.cpu_count()
num_cores = 1
Parallel(n_jobs=num_cores)(delayed(gen)(k, success_id) for k in range(1, 200))


