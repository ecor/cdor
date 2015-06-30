#
#
#   INPUT NETCDF DATA
# 
#   The netCDF input data (E_OBS abd RCM CORDEX) used in this example
#   can be directly downloaded from
#
#   https://www.dropbox.com/sh/u13azj7dj0d15j7/AAD7UQOynUTELqM-EGgkvsnwa?dl=0&s=sl
#
#   and put in the directory declared in INPUT_DATADIR
#
INPUT_DATADIR <- paste(Sys.getenv("HOME"),"Dropbox/public_/ncdosmart_data",sep="/") ## modify this value with the name of the directory containing the input file.  
RCM_OROGRAPHY_FIX=paste(INPUT_DATADIR,"/rcm/orog_MED-11_ECMWF-ERAINT_evaluation_r1i1p1_CNRM-ALADIN52_v1_fx.nc",sep="/")                  
RCM_LANDSEAMASK_FIX=paste(INPUT_DATADIR,"rcm/sftlf_MED-11_ECMWF-ERAINT_evaluation_r1i1p1_CNRM-ALADIN52_v1_fx.nc",sep="/")                   
RCM_GCM_PAST=paste(INPUT_DATADIR,"rcm/tas_MED-11_CNRM-CM5_historical_r8i1p1_CNRM-ALADIN52_v1_day_19960101-20001231.nc",sep="/")      
RCM_GCM_FUTURE=paste(INPUT_DATADIR,"rcm/tas_MED-11_CNRM-CM5_rcp45_r8i1p1_CNRM-ALADIN52_v1_day_20160101-20201231.nc",sep="/")        
RCM_REAN_PAST=paste(INPUT_DATADIR,"rcm/tas_MED-11_ECMWF-ERAINT_evaluation_r1i1p1_CNRM-ALADIN52_v1_day_19960101-20001231.nc",sep="/")
E_OBS_PAST=paste(INPUT_DATADIR,"e-obs/tg_0.25deg_reg_v11.0.nc4",sep="/")

STARTDATE_PAST="1997-05-01"
ENDDATE_PAST="1997-05-31"

STARTDATE_FUTURE="2017-05-01"
ENDDATE_FUTURE="2017-05-31"

#
#Information & detailed documentation of the data used for this exercise can be found at:
#		
#		For E-OBS (gridded observational dataset) the official information is at http://eca.knmi.nl/download/ensembles/download.php
#
#Regional climate model data examples are downloaded from https://www.medcordex.eu/ from where we have selected the 
#regional climate model ALADIN (both reanalysis-driven and GCM-driven experiments), but feel free to choose from many more. Data from the MED-CORDEX project available on that server is provided without charge and may be used for research and education only. Commercial use of the data is not permitted.
#
#



