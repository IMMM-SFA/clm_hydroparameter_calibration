# -----------------------------------------------------------------
# Python2 script to create multiple CLM case folders
# Written: Hongxiang Yan at PNNL
# Jun 11, 2021
# -----------------------------------------------------------------

import os


# -------------------------------------------------
clm_dir = '/global/project/projectdirs/m2702/hongxiang/clm5_ppe/cime/scripts'
case_dir = '/global/project/projectdirs/m2702/hongxiang/CAMEL_SA_ppe_run_NLDAS2_allbasin'

ensemble = 1500


# -------------------------------------------------
# load the two namelist parameter values
baseflow_scalar = npnan(ensemble, 1)
file = '/global/project/projectdirs/m2702/hongxiang/inputdata/parameter/baseflow_scalar_LHS1500'
lines = [line.rstrip('\n') for line in open(file)]	
count = 0
for line in lines:
	baseflow_scalar[count, 0] = float(line)
	count += 1


maximum_leaf_wetted_fraction = npnan(ensemble, 1)
file = '/global/project/projectdirs/m2702/hongxiang/inputdata/parameter/maximum_leaf_wetted_fraction_LHS1500'
lines = [line.rstrip('\n') for line in open(file)]	
count = 0
for line in lines:
	maximum_leaf_wetted_fraction[count, 0] = float(line)
	count += 1

# -------------------------------------------------
for i in range(num_basin):

	case_name = 'para_%03d' %(i+1)
	os.system("%s/create_newcase --case %s/%s --res CLM_USRDAT --mach cori-knl --compset IM3Clm50Sp --project m2702 --run-unsupported" %(clm_dir, case_dir, case_name))


	case_dir = '/global/project/projectdirs/m2702/hongxiang/CAMEL_SA_ppe_run_NLDAS2_allbasin/para_%03d' %(i+1, )
	os.chdir(case_dir)

	# run the following 
	CLM_FORC  = 'CAMEL_NLDAS2_464basin_1x464'
	CASE_NAME = 'para_%03d' %(i+1, )
	DIN_LOC_ROOT_CLMFORC = '/global/project/projectdirs/m2702/hongxiang/inputdata/atm/datm7'
	ARCHIVE_DIR  = 'clm_archive'
	domain_path  = '/global/project/projectdirs/m2702/hongxiang/inputdata/share/domains/CAMEL_domain464_464x464'
	input_path   = '/project/projectdirs/m2702/hongxiang/inputdata'
	para_path    = '/global/project/projectdirs/m2702/hongxiang/inputdata/parameter/LHS1500/parameter_file_%03d.nc'  %(i+1,)
	surface_path = '/global/project/projectdirs/m2702/hongxiang/inputdata/lnd/clm2/surfdata_map/CAMEL_surface_464/surface_all464basin_464x464.nc'  
	restart_path = '/global/project/projectdirs/m2702/hongxiang/CAMEL_allbasin_default_ppe_run/clm_archive/CAMEL_allbasin_default_ppe_run/rest/2005-01-01-00000/CAMEL_allbasin_default_ppe_run.clm2.r.2005-01-01-00000.nc' 

	os.system("export INPUTDATA_DIR=%s"  %(input_path,))
	os.system("export ARCHIVE_DIR=%s"    %(ARCHIVE_DIR,))
	os.system("./xmlchange --file env_workflow.xml --id JOB_QUEUE --val %s --force"   %('regular',))
	os.system("./xmlchange --file env_workflow.xml --id JOB_WALLCLOCK_TIME --val %s"  %('24:00:00',))
	os.system("./xmlchange --file env_mach_pes.xml --id NTASKS_ATM --val 64")
	os.system("./xmlchange --file env_mach_pes.xml --id NTASKS_LND --val 64")
	os.system("./xmlchange --file env_mach_pes.xml --id NTASKS_CPL --val 64")
	os.system("./xmlchange --file env_run.xml --id RUN_STARTDATE --val %s"    %('2005-01-01',))
	os.system("./xmlchange --file env_run.xml --id CLM_USRDAT_NAME --val %s"  %(CLM_FORC,))
	os.system("./xmlchange --file env_run.xml --id CASESTR --val %s"          %(CASE_NAME,))
	os.system("./xmlchange --file env_run.xml --id LND_DOMAIN_FILE --val domain_464basin_464x464.nc")
	os.system("./xmlchange --file env_run.xml --id ATM_DOMAIN_FILE --val domain_464basin_464x464.nc")
	os.system("./xmlchange --file env_run.xml --id ATM_DOMAIN_PATH --val %s"  %(domain_path,))
	os.system("./xmlchange --file env_run.xml --id LND_DOMAIN_PATH --val %s"  %(domain_path,))
	os.system("./xmlchange --file env_run.xml --id STOP_N --val 10")
	os.system("./xmlchange --file env_run.xml --id REST_N --val 1")
	os.system("./xmlchange --file env_run.xml --id STOP_OPTION --val nyears")
	os.system("./xmlchange --file env_run.xml --id REST_OPTION --val nyears")
	os.system("./xmlchange --file env_run.xml --id DATM_CLMNCEP_YR_START --val 2005")
	os.system("./xmlchange --file env_run.xml --id DATM_CLMNCEP_YR_END --val   2014")
	os.system("./xmlchange --file env_run.xml --id DATM_CLMNCEP_YR_ALIGN --val 2005")
	os.system("./xmlchange --file env_run.xml --id DIN_LOC_ROOT --val %s"  %(input_path,))
	os.system("./xmlchange --file env_run.xml --id DIN_LOC_ROOT_CLMFORC --val %s"  %(DIN_LOC_ROOT_CLMFORC,))
	os.system("./xmlchange --file env_run.xml --id DOUT_S_ROOT --val %s/%s"        %(ARCHIVE_DIR,CASE_NAME))
	os.system("./xmlchange --file env_run.xml --id DATM_MODE --val CLM1PT")
	os.system("./xmlchange --file env_run.xml --id RUN_TYPE --val startup")
	os.system("./xmlchange --file env_run.xml --id DOUT_S_SAVE_INTERIM_RESTART_FILES --val TRUE")
	
	os.system("./case.setup")


	# add lines into the 'user_nl_clm' file
	file_object = open('./user_nl_clm', 'a')          # Open a file with access mode 'a'
	file_object.write("fsurdat=\'%s\'\n"  %(surface_path,))  # # Append at the end of file
	file_object.write('hist_nhtfrq = -24\n')            # output in daily time step
	file_object.write('hist_mfilt  = 365\n')            # output in yearly (consist of 365 days)
	file_object.write("paramfile=\'%s\'\n"  %(para_path,))  
	file_object.write("finidat=\'%s\'\n"    %(restart_path,))  
	file_object.write('baseflow_scalar = %7.6f\n'   %(baseflow_scalar[i,0],))
	file_object.write('maximum_leaf_wetted_fraction = %7.6f\n'   %(maximum_leaf_wetted_fraction[i,0],))
	file_object.write('hist_type1d_pertape(1) = \'GRID\'\n')
	file_object.write('hist_dov2xy(1) = .false.')
	file_object.close()

	# monitoring the process
	print(i+1, ensemble)

	# build case
	os.system('./case.build')	

	# change USRDAT
    case_path = path+'para_%03d' %(i+1,)


    # adjust the forcing 
    file = case_path + '/CaseDocs/datm.streams.txt.CLM1PT.CLM_USRDAT'
    replace_line(file, 24, '        QBOT     shum\n')      # line number start with 0

    replace_line(file, 17, '     domain_464basin_1x464.nc\n')      # line number start with 0

    delete_line_by_full_match(file, '     ZBOT     z')



    # copy the forcing
    file_copy = case_path + '/user_datm.streams.txt.CLM1PT.CLM_USRDAT'
    os.system('cp %s %s'  %(file, file_copy))

    os.system('./case.submit')	