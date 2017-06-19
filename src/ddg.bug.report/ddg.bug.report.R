#' Generates bug reporting information
#' to help a user more clearly give feedback on
#' bugs that they encounter.

#' @param file a path to a script file
#' @return Output file written to the current working directory with \item{Environment} \item{RDataTracker Input} \item{RDataTracker Output} 
#' @details Users can copy and paste the output file into an issue created on Github. Related, please consider using options(error=recover) to look for the source of the bug in RDataTracker.
#' @import RDataTracker

ddg.bug.report <- function(file = 'R script file path',verbose = TRUE){

                                        # Capture output
    out <- capture.output(ddg.run(file))
    test <- c('Environment',capture.output(version),capture.output(
        installed.packages()[installed.packages()[,1] == 'RDataTracker',]),
              'RDataTracker Input',readLines(file),
              'RDataTracker Output',out)

                                        # Write to disk
    time <- gsub('-','',Sys.time());time <- gsub(':','',time);time <- gsub(' ','_',time)
    file.path <- paste0('./RDT_bug_report',time,'.txt')
    fileConn <- file(file.path)
    file.create(file.path)
    writeLines(test, fileConn)
    close(fileConn)
                                        # Return to console what was written 
    if (verbose){file.show(file.path)}
}
