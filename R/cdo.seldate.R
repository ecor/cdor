# TODO: Add comment
# 
# Author: ecor
###############################################################################


NULL
#' R Interface for 'cdo.seldate'
#' 
#' @param infile input necdf file
#' @param outfile 
#' @param start start date
#' @param end end date 
#' 
#' @note This function calls \code{cdo seldate}. 
#' See \url{http://www.fourtythree.org/tech/remapping-a-netcdf-file-using-cdo/},
#' \url{https://code.zmaw.de/projects/cdo/embedded/1.4.7/cdo.html}
#' 
#' @seealso \code{\link{system}}
#' @author Emanuele Cordano
#' @export
#' @examples
#'  \dontrun{
#'  infile <- "/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/data/e-obs/tg_0.25deg_reg_v11.0.nc4"
#'  outfile <- "/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/temp/test0.nc4" 
#'  
#'  ncs <- cdo.seldate(infile,outfile,start="1997-05-01",end="1997-05-31")
#'  }

cdo.seldate <-function(infile,outfile,start="1997-05-01",end="1997-05-31",...) {
	
	
	

	command <- paste("cdo seldate,",start,",",end," ",infile,"  ",outfile,sep="")
	print(command)
	out <- system(command)
	
	return(out)
	
	
}


