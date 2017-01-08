
if (!"lintr" %in% installed.packages()[,"Package"]){install.packages("lintr")}
library(lintr)

test.rdt <- lint("./R/RDataTracker.R",cache=TRUE)

con <- file("../results/test_rdt.log")
sink(con, append=TRUE)
print(test.rdt)
sink(con, append=TRUE, type="message")
