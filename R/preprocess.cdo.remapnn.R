# TODO: Add comment
# 
# Author: ecor
###############################################################################
NULL
#' R Interface for 'cdo.seldate'
#' 
#' @param coarse_nc coarse input netcdf
#' @param fine_nc fine  input netcdf
#' @param outfile output netcdf 
#' 
#' @note This function calls \code{cdo remapnn}. 
#' See \url{http://www.fourtythree.org/tech/remapping-a-netcdf-file-using-cdo/},
#' \url{https://code.zmaw.de/projects/cdo/embedded/1.4.7/cdo.html}
#' 
#' @author Emanuele Cordano
#' 
#' @seealso \code{\link{system}}
#' 
#' @export


cdo.remapnn <-function(coarse_nc,fine_nc,outfile)  {
	
###	cdo remapnn,$COARSE $FINE $OUTPUT 
	command <- paste("cdo remapnn,",coarse_nc," ",fine_nc," ",outfile,sep="")
	message(command)
	out <- system(command)

}
