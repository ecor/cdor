
###############################################################################

# plotMaps_usingExtractMethod.R
#
# This file is part of the prototype execercise of the ENERGY GROUP of
# the latest EUROPEAS "First Climate Services Masterclass: Energy, Tourism, Agriculture in a changing climate" (http://www.euporias.eu) 
# held in Bozen (South Tyrol, Italy), 18-22 May 2015.  
# It manipulates netCDF climate data files with external tools, like  'cdo' and interfaces with "raster" 
# package for data import/export and analysis.
#
#  NOTE: the use of "extract" method for RasterClass object lets Spatial Aggregation on Administrative Areas be executed in a very easy way!
#  Keep warning on how to set correctly the arguments for "extract" method.
#
#
#
# author: Emanuele Cordano on 22-05-2015

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.

###############################################################################
#
# Support: Contact Emanuele Cordano <emanuele.cordano@gmail.com> 

#! /user/bin/sh Rscript

rm(list=ls())

library(ncdf4)
library(rgdal)
library(raster)
library(stringr)
library(nccdosmart)


## Remaps the netcdf in accordance with the period (PAST and FUTURE) set in the CONFIGURATION file
outdir <- paste(Sys.getenv("HOME"),"temporary_nccdosmart",sep="/")
files <- cdo.remapnn.conf(outdir=outdir)

## Load the maps as 
maps <- importProblemData(files=files)

## Time Aggregation and Map Plots
maps_aggr <- list()
DirPlot <- paste(outdir,"pdf",sep="/")
if (file.exists(DirPlot)==FALSE) dir.create(DirPlot,recursive=TRUE)
if (file.exists(DirPlot)==FALSE) stop()
color <- heat.colors(1000)
for (it in names(maps)) {
	
	maps_aggr[[it]] <- stackApply(x=maps[[it]],indices=1,fun=mean)
	
	pdffile <- paste(DirPlot,"/",it,".pdf",sep="")
	pdf(pdffile)
	plot(maps_aggr[[it]],main=it,col=rev(color))
	dev.off()
	
	
	
}
 

### Spatial Aggragation in accordance to the Political Borders of European Countries
dsn <- system.file("misc/europe",package="nccdosmart")
##"/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/data/europe"
layer <-"europe_countries_ddg"

###
nameData <- "E_OBS_PAST"
vectorMap <- readOGR(dsn=dsn,layer=layer)[,"NATION"]

rasterMap <- maps[[nameData]]

print(rasterMap)
print(vectorMap)
##
## 
## help(extract) to see documentation on 'extract' method
## or see
## http://www.inside-r.org/packages/cran/raster/docs/extract

AggregatedData <- extract(x=rasterMap,y=vectorMap,fun=mean,sp=TRUE,na.rm=TRUE)

it <- "X1997.05.01"

p <- spplot(AggregatedData,it,main=paste(nameData,it,sep=" "),col.regions=rev(color))
print(p)




#####
