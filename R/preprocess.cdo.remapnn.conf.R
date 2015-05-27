#' It applies 'cdo.remapnn' to the netcdf file listed in the CONFIGURATION file 
#' 
#' @param file CONFIGURATION file 
#' @param outdir output directory for newly created NetCDF
#' @param files NetCDF data file if not set through the CONFIGURATION file 
#' @param ... further arguments for \code{\link{cdo.remapnn}}
#' 
#' @note This function calls \code{cdo seldate}. 
#' See \url{http://www.fourtythree.org/tech/remapping-a-netcdf-file-using-cdo/},
#' \url{https://code.zmaw.de/projects/cdo/embedded/1.4.7/cdo.html}
#' 
#' @author Emanuele Cordano
#' @seealso \code{\link{cdo.seldate.conf}},\code{\link{system}},\code{\link{cdo.remapnn.conf}}
#' 
#' @export 
#' 
#' @examples
#' 
#'  out <- cdo.remapnn.conf()
#' 
#' 

####file="/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/CONFIGURATION",
#####outdir="/Users/ecor/workspace_eclipse/MASTERCLASS/EMC15ENERGY/temp"



cdo.remapnn.conf <- function(file=system.file("configuration_template/CONFIGURATION.R",package="nccdosmart"),outdir="./temporary_nccdosmart",files=NULL)  {
	
	if (file.exists(outdir)==FALSE) dir.create(outdir,recursive=TRUE)
	
	if (is.null(files)) files <- cdo.seldate.conf(file=file,outdir=outdir)
	
	names_fine <- c("RCM_GCM_PAST","RCM_REAN_PAST","RCM_GCM_FUTURE")
	
	fine <- files[names_fine]
	coarse <- files[c("E_OBS_PAST")]
	
	###outfine <- str_replace_all(fine,".nc","_remapnn.nc")
	outfine <- fine
	str_sub(outfine, -3, -1) <- "_remapnn.nc"
	names(outfine) <- names(fine)
	
	print(fine)
	print(outfine)
	
	for (it in names_fine) {
		
		out <- cdo.remapnn(coarse_nc=coarse,fine_nc=fine[it],outfile=outfine[it])
		
	}
	
	if (out==0) {
		
		out <- files 
		out[names_fine] <- outfine
	}
	
	return(out)
	
	###	cdo remapnn,$COARSE $FINE $OUTPUT
	........
#	command <- paste("cdo remapnn,",coarse_nc," ",fine_nc," ",outfile,sep="")
#	out <- system(command)
	
}
