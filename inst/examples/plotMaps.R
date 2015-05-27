
###############################################################################

# plotMaps.R
#
# This file is part of the prototype execercise of the ENERGY GROUP of
# the latest EUROPEAS "First Climate Services Masterclass: Energy, Tourism, Agriculture in a changing climate" (http://www.euporias.eu) 
# held in Bozen (South Tyrol, Italy), 18-22 May 2015.  
# It manipulates netCDF climate data files with external tools, like  'cdo' and interfaces with "raster" 
# package for data import/export and analysis.
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

###source('/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/LOAD_ALL.R', chdir = TRUE)

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
### STOP HRE AT THE MOMENT 

### Spatial Aggragation in accordance to the Political Borders of European Countries
dsn <- system.file("misc/europe",package="nccdosmart")
##"/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/data/europe"
layer <-"europe_countries_ddg"

europe <- readOGR(dsn=dsn,layer=layer)
europe_raster <- rasterize(europe[,"NATION"],maps_aggr[[1]])
nation_code <- sprintf("N%03d",as.vector(europe$NATION))
maps_aggr_eu <- maps_aggr
mask <- !is.na(europe_raster)
for (it in names(maps_aggr_eu)) {
	
	mask <- !is.na(maps_aggr_eu[[it]]) & mask
	
}	

europe_raster_masked <- europe_raster
europe_raster_masked[!mask] <- NA
for (it in names(maps_aggr_eu)) {
	
	maps_aggr_eu[[it]][!mask] <- NA
	
}	

dfr <- as.data.frame(stack(maps_aggr_eu),xy=TRUE)
dfr_nation <- as.data.frame(europe_raster_masked,xy=FALSE)
dfr_nation$NATION <- sprintf("N%04d",dfr_nation$NATION)
europe$NATION_chr <- sprintf("N%04d",europe$NATION)
#dfr <- cbind(df,df_nation)
for (it in names(maps_aggr_eu)) {
	
	europe@data[,it] <- NA
	out <- tapply(X=dfr[,it],INDEX=dfr_nation$NATION,FUN=mean)
	missing_names <- europe$NATION_chr[!(europe$NATION_chr %in% names(out))]
	out[missing_names] <- NA
	print(out)
	europe@data[,it] <- out[europe$NATION_chr]
	
}
for (it in names(maps_aggr_eu)) {
	
	pdffile <- paste(DirPlot,"/",it,"_eu.pdf",sep="")
	pdf(pdffile)
	p <- spplot(europe,it,main=it,col.regions=rev(color))
	print(p)
	
	dev.off()
	
	
}

