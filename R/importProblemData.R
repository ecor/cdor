# TODO: Add comment
# 
# Author: ecor
###############################################################################
NULL
#' This function imports Problem Data as \code{RasterBrick-class} object
#' 
#' @param ... further arguments
#' @param files netcdf files. If it is \code{NULL} , files are created with \code{\link{cdo.remapnn.conf}}.
#' @export
#' 
#' @author Emanuele Cordano
#' @return a list of \code{RasterBrick-class} objects
#' 
#' @seealso \code{\link{brick}},\code{\link{cdo.remapnn.conf}}
#' 
#' @import raster
#' @examples 
#' 
## files <-   c("/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/temp/RCM_GCM_PAST_1997-05-01_1997-05-31_remapnn.nc", 
##  "/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/temp/RCM_REAN_PAST_1997-05-01_1997-05-31_remapnn.nc", 
##  "/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/temp/E_OBS_PAST_1997-05-01_1997-05-31.nc")
##  names(files) <- c("RCM_GCM_PAST","RCM_REAN_PAST","E_OBS_PAST","RCM_GCM_FUTURE") #####
##  
##                                                           RCM_GCM_PAST                                                            RCM_REAN_PAST 
##   "./temporary_nccdosmart/RCM_GCM_PAST_1997-05-01_1997-05-31_remapnn.nc"  "./temporary_nccdosmart/RCM_REAN_PAST_1997-05-01_1997-05-31_remapnn.nc" 
##                                                              E_OBS_PAST                                                           RCM_GCM_FUTURE 
##            "./temporary_nccdosmart/E_OBS_PAST_1997-05-01_1997-05-31.nc" "./temporary_nccdosmart/RCM_GCM_FUTURE_2017-05-01_2017-05-31_remapnn.nc" 
#' 
#' files <- cdo.remapnn.conf()
#' maps <- importProblemData(files=files)                                                                                        
#' 

importProblemData <- function(...,files=NULL) {
	
	
	if (is.null(files)) files <- cdo.remapnn.conf(...)
	
	
	
	out <- lapply(X=files,FUN=brick)
	print(out)
	for (it in names(out)[names(out)!="E_OBS_PAST"]) {
	
		out[[it]] <- out[[it]]+out[["E_OBS_PAST"]]*0
	
	}
	
	
	
	
	return(out)
}
