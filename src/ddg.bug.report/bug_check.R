if (!'RDataTracker' %in% installed.packages()[,1]){
    if (!'devtools' %in% installed.packages()[,1]){
        install.packages('devtools')
    }
    library(devtools)
    install_github('end-to-end-provenance/RDataTracker',ref='development')
}

library('RDataTracker')
source('ddg.bug.report.R')

ddg.bug.report('example_debug.R')
