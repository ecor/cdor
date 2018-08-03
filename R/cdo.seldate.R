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
#'  ##
#' 
#'  \dontrun{
#' 
#' 	ncname <- "chirps-v2.0.2005.days_p05.nc"
#'  url <- "ftp://ftp.chg.ucsb.edu/pub/org/chg/products/CHIRPS-2.0/global_daily/netcdf/p05"
#'  temp <- rasterTmFile()
#'  download.file(from=paste(url,ncname,sep="/"),to=temp)
#'  x <- paste(temp,ncname,sep="/")
#'  infile <- x
#'  outfile <- NA
#'  
#'  ncs <- cdo.seldate(infile,outfile,start="1997-05-01",end="1997-05-31")
#'  }

cdo.seldate <-function(infile,outfile=NULL,start="1997-05-01",end="1997-05-31",return.raster=TRUE,...) {
	
	
	if (is.null(outfile)) outfile <- NA
	format ="%Y-%m-%d"
	start <- as.Date(start,format=format)
	end <- as.Date(end,format=format)
	
	
	startc <- as.character(start)
	if (is.na(outfile)) outfile <- "default"
	if  (outfile=="default")  {
		formats <- "%Y_%m_%d"
		starts <- as.character(start,format=formats)
		starts <- as.character(end,format=formats)
		suffix <- sprintf("_%s_%s.nc",starts,ends)
		outfile <- str_replace(infile,".nc",suffix)
		
		
	}
	
	if (outfile=="temp") outfile <- paste(tempfile(),".nc")
	
	command <- paste("cdo seldate,",as.character(start),",",end," ",infile,"  ",outfile,sep="")
	print(command)
	out <- system(command)
	
	if (out==0) {
		
		if (return.raster==TRUE) {
			
			
			out <- stack(outfile)
			
		} else {
			
			out <- outfile
		}
	}
	
	return(out)
	
	
}


