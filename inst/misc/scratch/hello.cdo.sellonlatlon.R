rm(list=ls())

library(cdor)
library(raster)
library(doParallel)
source('/STORAGE/projects/R-Packages/cdor/R/cdo.sellonlatbox.R')
url <- "ftp://ftp.chg.ucsb.edu/pub/org/chg/products/CHIRPS-2.0/global_daily/netcdf/p05/chirps-v2.0.2005.days_p05.nc"
x <- '/H01/SHAREDWORK/ACEWATER2/data/db/climate/chirps/data/daily/netcdf_global/p05/chirps-v2.0.2005.days_p05.nc' 


###temp <- rasterTmFile()

y <- extent(c(-17.6608, -5.727799, 10.17488, 18.62197))



##out <- cdo.sellonlatbox(x=x,y=y)

a <- Sys.time()
cc_p <- system.time(out_p <- cdo.sellonlatbox(x=x,y=y,dim=c(2,2),parallel=TRUE,npar=6))
b <- Sys.time()
cc_s <- system.time(out_s <- cdo.sellonlatbox(x=x,y=y,dim=c(2,2),parallel=FALSE,npar=6))
c <- Sys.time() 

#map_path <-  '/STORAGE/projects/R-Packages/cdor/inst/map'
#gadm <- getData('GADM',country='ITA',level=3,path=map_path)
#gadm <- gadm[gadm$NAME_1 %in% c("Trentino-Alto Adige"),]
#prec <- cdo.sellonlatbox(x=x,y=gadm)
#
#library(RColorBrewer)
#library(rasterVis)
#cols <- colorRampPalette(brewer.pal(9,"YlGnBu"))
#levelplot(prec[[5]],col.regions=cols)+layer(sp.polygons(gadm))
#levelplot(sum(prec),col.regions=cols)+layer(sp.polygons(gadm))

## End(Not run)

