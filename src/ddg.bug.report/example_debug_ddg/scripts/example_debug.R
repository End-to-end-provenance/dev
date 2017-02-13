hffill <- matrix(100,10)
year <- 2010
assign(paste("Resids", year-2, year+2, sep="."),rep(NA, nrow(hffill)))
