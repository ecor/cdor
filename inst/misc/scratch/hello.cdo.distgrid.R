library(cdor)
library(raster)
#
#ncname <- "chirps-v2.0.2005.days_p05.nc"
#url <- "ftp://ftp.chg.ucsb.edu/pub/org/chg/products/CHIRPS-2.0/global_daily/netcdf/p05"
#temp <- rasterTmpFile()
#
#
#download.file(url=paste(url,ncname,sep="/"),destfile=temp)
#x <- paste(temp,ncname,sep="/")
source('/STORAGE/projects/R-Packages/cdor/R/cdo.distgrid.R')
x <- '/H01/SHAREDWORK/ACEWATER2/data/db/climate/chirps/data/daily/netcdf_global/p05/chirps-v2.0.2005.days_p05.nc' 


### Africa Extent: extent      : -18.1625, 54.5375, -34.8375, 37.5625  (xmin, xmax, ymin, ymax)
###y <- extent(c(-17.6608, -5.727799, 10.17488, 18.62197)) ## Extent senegal
y <- extent(c(-18.1625,54.5375,-34.8375,37.5625))

prec_afr <- cdo.distgrid(x=x,y=y,dim=c(30,30),parallel=TRUE)	
