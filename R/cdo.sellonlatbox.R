# TODO: Add comment
# 
# Author: ecor
###############################################################################
NULL
#' R Interface for 'cdo.seldate'
#' 
#' @param x coarse input netcdf
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


cdo.sellonlatbox <-function(x,y,...,outdir=NULL,outfile=NULL,return.raster=TRUE)  {
	
	
	
	
	if (is.null(outfile)) outfile <- NA
	if (is.na(outfile)) outfile <- "default"
	if (is.null(outdire)) outdir <- NA
	if (is.na(outdir)) outdir <- "default"
	
	if (outdir=="default") outdir <- tempdir()
	
	ye <- extent(y)
	####
	yev <- as.vector(ye)
	
	yc <- paste(yev,collapse=",")
	names(yev) <- c("E","W","S","N")
	
	nn <- c("E","E","N","N")
	nn[sign(yev)<0 && nn="E"] <- "W"
	nn[sign(yev)<0 && nn="N"] <- "S"
	###
	ys <- paste(paste0(names(yev),abs(yev),nn),collapse="_")
	ys <- str_replace(ys,"[.]","d")
	###
	
					
				###	ysf <- str_replace(yev,"-","n")				)
	names(ysf) <- c("E","W","S","N")
	
	####
	
	if (outfile=="default") {
		
		
		suffix <- paste0(ys,".nc")
		outfile <- str_replace(basename(x),".nc",suffix)
		
		
		
		
	}
	
	
	
	####
	
	
	cdostring <- sprintf('cdo sellonlatbox,%s %s %s',yc,x,outfile) ### cdo sellonlatbox,-10,0,30,0 temperature_africa.nc out.nc 
	print(cdostring)
	system(cdostring)
	
###	cdo remapnn,$COARSE $FINE $OUTPUT 
	command <- paste("cdo remapnn,",coarse_nc," ",fine_nc," ",outfile,sep="")
	message(command)
	out <- system(command)
	return(out)

}
