library("devtools")
source("../src/ddg.bug.report/ddg.bug.report.R")

### test typecoercion
install_github("End-to-end-provenance/RDataTracker", ref = "typecoercion")

### test assignfunction
install_github("End-to-end-provenance/RDataTracker", ref = "assignfunction")
