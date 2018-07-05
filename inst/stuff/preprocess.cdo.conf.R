# TODO: Add comment
# 
# Author: ecor
###############################################################################



NULL
#' It applies 'cdo.seldate' to the netcdf file listed in the CONFIGURATION file 
#' 
#' @param file CONFIGURATION file 
#' @param outdir output directory for newly created NetCDF
#' @param ... further arguments for \code{\link{cdo.seldate}}
#' 
#' @note This function calls \code{cdo seldate}. 
#' See \url{http://www.fourtythree.org/tech/remapping-a-netcdf-file-using-cdo/},
#' \url{https://code.zmaw.de/projects/cdo/embedded/1.4.7/cdo.html}
#' 
#' @seealso \code{\link{cdo.seldate}},\code{\link{system}},\url{http://pcmdi9.llnl.gov/esgf-web-fe/live#}
#'
#' @author Emanuele Cordano 
#' @export
#' 
#' @examples
#' 
#'  out <- cdo.seldate.conf()
#' 
#' 
##' ##(file="/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/CONFIGURATION",
# ##outdir="/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/temp")
cdo.seldate.conf <-function(file=system.file("configuration_template/CONFIGURATION.R",package="nccdosmart"),
		outdir="./temporary_nccdosmart") {
	
	if (file.exists(outdir)==FALSE) dir.create(outdir,recursive=TRUE)
	
	source(file)
	
	
	
	ncpast <- c("RCM_GCM_PAST","RCM_REAN_PAST","E_OBS_PAST")
	
	ncfuture <- c("RCM_GCM_FUTURE")
	
	ncpast_out <- paste(outdir,"/",ncpast,"_",STARTDATE_PAST,"_",ENDDATE_PAST,".nc",sep="")
	ncfuture_out <- paste(outdir,"/",ncfuture,"_",STARTDATE_FUTURE,"_",ENDDATE_FUTURE,".nc",sep="")
	
	names(ncpast_out) <- ncpast
	names(ncfuture_out) <- ncfuture
	
	
	for (i in 1:length(ncpast)) {
		
		infile <- get(ncpast[i])
		out <- cdo.seldate(infile=infile,outfile=ncpast_out[i],start=STARTDATE_PAST,end=ENDDATE_PAST)
	}
	for (i in 1:length(ncfuture)) {
		
		infile <- get(ncfuture[i])
		out <- cdo.seldate(infile=infile,outfile=ncfuture_out[i],start=STARTDATE_FUTURE,end=ENDDATE_FUTURE)
	}
	
	
	if (out==0) {
		
		out <- c(ncpast_out,ncfuture_out)
		
	}
	
	
	return(out)
	
	}
#	cdo.seldate(infile=RCM_GCM_PAST,outfile=RCM_GCM_PAST_OUT,start=STARTDATE_PAST,end=ENDDATE_PAST)
#	cdo.seldate(infile=RCM_REAN_PAST,outfile=RCM_REAN_PAST_OUT,start=STARTDATE_PAST,end=ENDDATE_PAST)
#	cdo.seldate(infile=RCM_GCM_FUTURE,outfile=RCM_GCM_FUTURE,start=STARTDATE_FUTURE,end=ENDDATE_FUTURE)
#	cdo.seldate(infile=E_OBS_PAST,outfile=E_OBS_PAST_OUT,start=STARTDATE_PAST,end=ENDDATE_PAST)
##	
#	
#	RCM_GCM_PAST="/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/data/rcm/tas_MED-11_CNRM-CM5_historical_r8i1p1_CNRM-ALADIN52_v1_day_19960101-20001231.nc"    
#	RCM_GCM_FUTURE="/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/data/rcm/tas_MED-11_CNRM-CM5_rcp45_r8i1p1_CNRM-ALADIN52_v1_day_20160101-20201231.nc"         
#	RCM_REAN_PAST= "/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/data/rcm/tas_MED-11_ECMWF-ERAINT_evaluation_r1i1p1_CNRM-ALADIN52_v1_day_19960101-20001231.nc"
#	E_OBS_PAST
#
#	
#	return(out)
#	
#	
#}
#
#
