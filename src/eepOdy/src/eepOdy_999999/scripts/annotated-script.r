1: if (!"ggmap" %in% installed.packages()[, 1]) {
1:     install.packages("ggmap")
1: }
2: library(ggmap)
3: x <- read.csv("http://harvardforest.fas.harvard.edu/data/p14/hf147/hf147-12-ne-ants-1864-2011.csv")
4: sites <- read.csv("http://harvardforest.fas.harvard.edu/data/p14/hf147/hf147-07-ant-sites-1999-2000.csv")
5: nant.sites <- read.csv("http://harvardforest.fas.harvard.edu/data/p14/hf147/hf147-09-nantucket-sites-2004-09.csv")
6: x[, "county"] <- as.character(x[, "county"])
7: x[, "locality"] <- as.character(x[, "locality"])
8: x <- x[grepl("aphrud", as.character(x[, "code"])), ]
9: nant.sites[, "site"] <- as.character(nant.sites[, "site"])
10: nant <- (x[grepl("nant", as.character(x[, "county"])), ])
11: nant[nant[, "locality"] == "NorwoodFarm", "locality"] <- "Norwood Farm"
12: nant[nant[, "locality"] == "Madequecham", "locality"] <- "Madequechum"
13: for (loc in unique(nant[, "locality"])) {
13:     nant[nant[, "locality"] == loc, c("latitude", "longitude")] <- nant.sites[nant.sites[, 
13:         "site"] == loc, c("latitude", "longitude")][1, ]
13: }
14: duke <- (x[grepl("dukes", as.character(x[, "county"])), ])
15: duke[is.na(duke[, "latitude"]), "longitude"] <- 70.8
16: duke[is.na(duke[, "latitude"]), "latitude"] <- 41.32
17: include <- (grepl("connect", x[, "state"]) | grepl("rhode", x[, 
17:     "state"]))
18: ants <- x[include, ]
19: ants <- rbind(ants, duke, nant)
20: ME <- x[x[, "state"] == "maine", ]
21: ME <- ME[grepl("waterboro barrens", ME[, "locality"], ign = TRUE), 
21:     ]
22: ants <- ants[ants[, "state"] != "maine", ]
23: ants <- rbind(ants, ME)
24: missing <- ants[is.na(ants[, "latitude"]), ]
25: missing[(missing[, "county"] == "litchfield" & missing[, "locality"] == 
25:     "colebrook"), c("latitude", "longitude")] <- c(42.001, -73.084)
26: missing[(missing[, "county"] == "litchfield" & !(missing[, "locality"] == 
26:     "colebrook")), c("latitude", "longitude")] <- c(41.73333, 
26:     -73.183298)
27: missing[grepl("willimantic", missing[, "locality"], ign = TRUE), 
27:     c("latitude", "longitude")] <- c(41.7, -72.21)
28: missing[grepl("new haven", missing[, "county"], ign = TRUE), 
28:     c("latitude", "longitude")] <- c(41.3725976, -72.9256266)
29: missing[grepl("block island", missing[, "locality"], ign = TRUE), 
29:     c("latitude", "longitude")] <- c(41.1892405, -71.5785894)
30: ants <- ants[!(is.na(ants[, "latitude"])), ]
31: ants <- rbind(ants, missing)
32: ne.map <- qmap(location = "new england", zoom = 6)
33: pdf("NE_arudis_map.pdf")
34: ne.map + geom_point(data = ants, aes(x = longitude, y = latitude), 
34:     col = "violet", size = 0.5)
35: dev.off()
