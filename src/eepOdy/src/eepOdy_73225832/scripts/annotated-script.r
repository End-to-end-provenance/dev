1: if (!"ggmap" %in% installed.packages()[, 1]) {
1:     install.packages("ggmap")
1: }
2: library(ggmap)
3: x <- read.csv("http://harvardforest.fas.harvard.edu/data/p14/hf147/hf147-12-ne-ants-1864-2011.csv")
