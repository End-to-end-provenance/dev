### Size
### Nestedness

library(devtools)
install_github('End-to-end-provenance/RDataTracker',ref='control2')
library(RDataTracker)

setwd('test_control_ano_F')
lapply(dir('.'),ddg.run,annotate.inside=FALSE)
