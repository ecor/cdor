
## Input data

x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 100000

## parallel time 
ptime <- system.time({
			 r <- foreach(icount(trials), .combine=cbind) %dopar% {
			ind <- sample(100, 100, replace=TRUE)
		    result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
		    coefficients(result1)
			}
			})[3]
ptime

## sequential time 

stime <- system.time({
			 r <- foreach(icount(trials), .combine=cbind) %do% {
			 ind <- sample(100, 100, replace=TRUE)
			 result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
			 coefficients(result1)
			 }
			})[3]
stime



url <- "ftp://ftp.chg.ucsb.edu/pub/org/chg/products/CHIRPS-2.0/global_daily/netcdf/p05/chirps-v2.0.2005.days_p05.nc"
temp <-- rasterTmFile()

y <- extent(c(-17.6608, -5.727799, 10.17488, 18.62197))



out <- cdo.sellonlatbox(x=x,y=y)
out2 <- cdo.sellonlatbox(x=x,y=y,dim=c(2,2))
map_path <-  '/STORAGE/projects/R-Packages/cdor/inst/map'
gadm <- getData('GADM',country='ITA',level=3,path=map_path)
gadm <- gadm[gadm$NAME_1 %in% c("Trentino-Alto Adige"),]
prec <- cdo.sellonlatbox(x=x,y=gadm)

library(RColorBrewer)
library(rasterVis)
cols <- colorRampPalette(brewer.pal(9,"YlGnBu"))
levelplot(prec[[5]],col.regions=cols)+layer(sp.polygons(gadm))
levelplot(sum(prec),col.regions=cols)+layer(sp.polygons(gadm))

## End(Not run)

