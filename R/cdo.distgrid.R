#' R Interface for 'cdo.sellonlatbox' and 'cdo.distgrid'
#' 
#' @param x,y BLA BLA
#' 
#' @export
#' @examples 
#' 
#' \dontrun{
#'
#' 	ncname <- "chirps-v2.0.2005.days_p05.nc"
#'  url <- "ftp://ftp.chg.ucsb.edu/pub/org/chg/products/CHIRPS-2.0/global_daily/netcdf/p05"
#'  temp <- rasterTmpFile()
#'  download.file(from=paste(url,ncname,sep="/"),to=temp)
#'  x <- paste(temp,ncname,sep="/")
#' 
#' 
#' 
#' ### Africa Extent: extent      : -18.1625, 54.5375, -34.8375, 37.5625  (xmin, xmax, ymin, ymax)
#' ###y <- extent(c(-17.6608, -5.727799, 10.17488, 18.62197)) ## Extent senegal
#'  y <- extent(c(-18.1625,54.5375,-34.8375,37.5625))
#' 
#'  prec_afr <- cdo.distgrid(x=x,y=y,dim=c(10,10),parallel=TRUE)	
#' 
#' 
#' }

cdo.distgrid <-function(x,y,...,dim=c(1,1),return.raster=TRUE)  {
	
	
	
	out <- cdo.sellonlatbox(x,y,...,dim=c(1,1),return.raster=FALSE)
	
	infile <- out
	
	obase <- out
	extension(obase) <- ""
	obase <- paste0(obase,"_tile_")
	rdims <- paste(rev(dim),collapse=",") 
	
	cdostring <- sprintf('cdo distgrid,%s %s %s',rdims,infile,obase)
	
	message(cdostring)
	out <- system(cdostring)
	## ref see https://code.mpimet.mpg.de/projects/cdo/embedded/cdo.pdf page 37	
	if (out==0) {
		
		 dirf <- dirname(obase)
		 pattern <- basename(obase)		
		 out <- list.files(dirf,pattern=pattern,full.name=TRUE)	
		
			if (return.raster==TRUE) {
				
				out <- lapply(X=out,FUN=stack)
				
			}
		
	}
		
		
	
	return(out)
	
	
	
}