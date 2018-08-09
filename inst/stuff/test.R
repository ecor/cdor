# TODO: Add comment
# 
# Author: ecor
###############################################################################
library(cdor)

ncname <- "chirps-v2.0.2005.days_p05.nc"
url <- "ftp://ftp.chg.ucsb.edu/pub/org/chg/products/CHIRPS-2.0/global_daily/netcdf/p05"
temp <- tempdir()

x <- paste(temp,ncname,sep="/")
download.file(url=paste(url,ncname,sep="/"),destfile=x)


### Africa Extent: extent      : -18.1625, 54.5375, -34.8375, 37.5625  (xmin, xmax, ymin, ymax)
###y <- extent(c(-17.6608, -5.727799, 10.17488, 18.62197)) ## Extent senegal
y <- extent(c(-18.1625,54.5375,-34.8375,37.5625))

prec_afr <- cdo.distgrid(x=x,y=y,dim=c(10,10),parallel=TRUE)	


