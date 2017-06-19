library(magrittr)
library(devtools)
library(rjson)
source("../src/ddg.bug.report/ddg.bug.report.R")
library(RDataTracker)
library(RCurl)
## library(d3Network)
library(networkD3)
library(htmlwidgets)

### test typecoercion
install_github("End-to-end-provenance/RDataTracker", ref = "typecoercion")
setwd("../../eep-usecases/src")
ddg.run("coerce3.R",ddgdir = "../../dev/test_lab/ddg_coerce3")
ddg.run("coerce4.R",ddgdir = "../../dev/test_lab/ddg_coerce4")
setwd("../../dev/test_lab")

ddg3 <- fromJSON(file = "ddg_coerce3/ddg.json")
ddg4 <- fromJSON(file = "ddg_coerce4/ddg.json")

net4 <- ddg2net(ddg4)
simpleNetwork(net4$links,zoom = TRUE) %>% 
    htmlwidgets::saveWidget('~/Desktop/d3prov.html')
system('open ~/Desktop/d3prov.html')

### test assignfunction
install_github("End-to-end-provenance/RDataTracker", ref = "assignfunction")
ddg.run('assign.R')
