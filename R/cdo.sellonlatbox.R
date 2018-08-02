# TODO: Add comment
# 
# Author: ecor
###############################################################################
NULL
#' R Interface for 'cdo.seldate'
#' 
#' @param x input netcdf file for 'cdo.sellonlatbox'
#' @param y extent or \code{Extent*} object indicateing the extent to extract
#' @param outdir output directory
#' @param return.raster logical value. If is \code{TRUE}, outputs are returned as \code{\link{RasterStack-Class}} objects.
#' 
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
#' @importFrom stringr str_replace str_replace_all
#' @importFrom raster extent stack
#' 
#' @export
#' 
#' @examples
#' 
#' 
#' \dontrun{
#'
#' 	ncname <- chirps-v2.0.2005.days_p05.nc"
#'  url <- "ftp://ftp.chg.ucsb.edu/pub/org/chg/products/CHIRPS-2.0/global_daily/netcdf/p05"
#'  temp <- rasterTmFile()
#'  download.file(from=paste(url,ncname,sep="/"),to=temp)
#'  x <- paste(temp,ncname,sep="/")
#' 
#' 	DOWNLOAD.FILE
#' 
#' 
#' 	library(raster)
#' 
#' 	out <- cdo.sellonlatbox(x=x,y=y)
#' 	out2 <- cdo.sellonlatbox(x=x,y=y,dim=c(2,2))
#' 	map_path <-  '/STORAGE/projects/R-Packages/cdor/inst/map'
#'  gadm <- getData('GADM',country='ITA',level=3,path=map_path)
#'  gadm <- gadm[gadm$NAME_1 %in% c("Trentino-Alto Adige"),]
#'  prec <- cdo.sellonlatbox(x=x,y=gadm)
#'  
#' library(RColorBrewer)
#' library(rasterVis)
#' cols <- colorRampPalette(brewer.pal(9,"YlGnBu"))
#' levelplot(prec[[5]],col.regions=cols)+layer(sp.polygons(gadm))
#' levelplot(sum(prec),col.regions=cols)+layer(sp.polygons(gadm))
#' 
#' 
#' ### Africa Extent: extent      : -18.1625, 54.5375, -34.8375, 37.5625  (xmin, xmax, ymin, ymax)
#' ###y <- extent(c(-17.6608, -5.727799, 10.17488, 18.62197)) ## Extent senegal
#'  y <- extent(c(-18.1625,54.5375,-34.8375,37.5625))
#' 
#'  prec_afr <- cdo.sellonlatbox(x=x,y=y,dim=c(10,10),parallel=TRUE)	
#' 
#' 
#' }


cdo.sellonlatbox <-function(x,y,...,dim=c(1,1),outdir=NULL,outfile=NULL,return.raster=TRUE,parallel=FALSE,npar=NA,use.distbase=FALSE)  {
	
	
	
	
	if (is.null(outfile)) outfile <- NA
	if (is.na(outfile)) outfile <- "default"
	if (is.null(outdir)) outdir <- NA
	if (is.na(outdir)) outdir <- "default"
	
	if (outdir=="default") outdir <- tempdir()
	
	
	
	
	if (!is.vector(y)) {
			
			y <- extent(y)
			y <- as.vector(y)
			
		} 
	
	######
	if (length(dim)<2) dim <- c(1,1)
	
	if (any(dim!=c(1,1))) {
	
	  ysmax <- rep(1:dim[1],times=dim[2])
	  xsmax <- rep(1:dim[2],each=dim[1])
	  
	  
	  ysmin <- ysmax-1
	  xsmin <- xsmax-1
 	  
	  scaley <- 1/dim[1]*(y[4]-y[3])
	  scalex <- 1/dim[2]*(y[2]-y[1])

	  offsetx <- y[1]
	  offsety <- y[3]
	  xsmin <- xsmin*scalex+offsetx
	  xsmax <- xsmax*scalex+offsetx
	  
	  ysmin <- ysmin*scaley+offsety
	  ysmax <- ysmax*scaley+offsety
	  
	  extents <- mapply(xmin=xsmin,xmax=xsmax,ymin=ysmin,ymax=ysmax,FUN=c,SIMPLIFY=FALSE)
	  
	  if (parallel==TRUE) {
		  
		  
		 ## require("doParallel")
		 ## require("foreach")
		  npar_max <- min(detectCores(all.tests = FALSE, logical = TRUE)-1,dim[1]*dim[2])
		  if (is.na(npar)) npar <- npar_max 
		  if (npar>npar_max) npar <- npar_max 
		  
		 registerDoParallel(npar)
		  print(extents)
		  ## SPERIMENTARE 
		  iextents <- 1:length(extents)
		  print(iextents)
		 #######extentss <<- extents
		  out <- foreach(ii=iextents) %dopar% {cdo.sellonlatbox(x=x,y=extents[[ii]],dim=1,outdir=outdir,return.raster=return.raster,parallel=FALSE,...)}
		  
	  } else {
	  		
		
	  		out <- mapply(x=x,y=extents,dim=1,outdir=outdir,return.raster=return.raster,FUN=cdo.sellonlatbox,...,SIMPLIFY=FALSE)
  		}
	  return(out)
	
	}
	
	yev <- y
	
	yc <- paste(yev,collapse=",")
	names(yev) <- c("E","W","S","N")
	
	nn <- c("E","E","N","N")
	nn[sign(yev)<0 && nn=="E"] <- "W"
	nn[sign(yev)<0 && nn=="N"] <- "S"
	###
	ys <- paste(paste0(names(yev),abs(yev),nn),collapse="_")
	ys <- str_replace_all(ys,"[.]","d")
	###
	
					
				###	ysf <- str_replace(yev,"-","n")				)
	
	
	####
	
	if (outfile=="default") {
		
		
		suffix <- paste0("__",ys,".nc")
		outfile <- str_replace(basename(x),".nc",suffix)
		if (outdir!="")  outfile <- paste(outdir,outfile,sep="/")
		
		
		
	}
	
	
	
	cdostring <- sprintf('cdo sellonlatbox,%s %s %s',yc,x,outfile) ### cdo sellonlatbox,-10,0,30,0 temperature_africa.nc out.nc 
	message(cdostring)
	out <- system(cdostring)
	
	
	if (out==0) {
		
		if (return.raster==TRUE) {
			
			
			out <- stack(outfile)
			
		} else {
			
			out <- outfile
		}
		
		
		
		
	}
###	cdo remapnn,$COARSE $FINE $OUTPUT 
#	command <- paste("cdo remapnn,",coarse_nc," ",fine_nc," ",outfile,sep="")
#	message(command)
#	out <- system(command)
	return(out)

}
