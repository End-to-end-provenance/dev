### Check if ggmap is install and then library
if (!'ggmap' %in% installed.packages()[,1]){install.packages('ggmap')}
library(ggmap)
### Import data from the Harvard Forest Archives
### Data courtesy of AM Ellison
x <- read.csv('http://harvardforest.fas.harvard.edu/data/p14/hf147/hf147-12-ne-ants-1864-2011.csv')
sites <- read.csv('http://harvardforest.fas.harvard.edu/data/p14/hf147/hf147-07-ant-sites-1999-2000.csv')
nant.sites <- read.csv('http://harvardforest.fas.harvard.edu/data/p14/hf147/hf147-09-nantucket-sites-2004-09.csv')
x[,'county'] <- as.character(x[,'county'])
x[,'locality'] <- as.character(x[,'locality'])
### Limit to Aphaenogaster rudis
x <- x[grepl('aphrud',as.character(x[,'code'])),]

### Nantucket: Resolve missing coordinates
nant.sites[,'site'] <- as.character(nant.sites[,'site'])
nant <- (x[grepl('nant',as.character(x[,'county'])),])
nant[nant[,'locality'] == 'NorwoodFarm','locality'] <- 'Norwood Farm'
nant[nant[,'locality'] == 'Madequecham','locality'] <- 'Madequechum'
for (loc in unique(nant[,'locality'])){
    nant[nant[,'locality'] == loc,c('latitude','longitude')] <- 
        nant.sites[nant.sites[,'site'] == loc,c('latitude','longitude')][1,]
}
### Martha's Vineyard (Dukes County): Resolve missing coordinates
duke <- (x[grepl('dukes',as.character(x[,'county'])),])
duke[is.na(duke[,'latitude']),'longitude'] <- 70.8
duke[is.na(duke[,'latitude']),'latitude'] <- 41.32
### Limit to only CT and RI prior to appending
### Nantucket and Martha's Vineyard
include <- (grepl('connect',x[,'state']) |
                grepl('rhode',x[,'state']) 
            )
ants <- x[include,]
### Append Nantucket and Martha's Vineyard
ants <- rbind(ants,duke,nant)
### Resolving known A. rudis in Maine
ME <- x[x[,'state'] == 'maine',]
ME <- ME[grepl('waterboro barrens',ME[,'locality'],ign=TRUE),]
### Append ME to ants
ants <- ants[ants[,'state'] != 'maine',]
ants <- rbind(ants,ME)
### Resolve remaining missing coordinates
missing <- ants[is.na(ants[,'latitude']),]
missing[(missing[,'county'] == 'litchfield' & 
             missing[,'locality'] == 'colebrook'),
        c('latitude','longitude')] <- c(42.0010, -73.0840)
missing[(missing[,'county'] == 'litchfield' & 
             !(missing[,'locality'] == 'colebrook')),
        c('latitude','longitude')] <- c(41.73333,-73.183298)
missing[grepl('willimantic',missing[,'locality'],ign=TRUE) ,
        c('latitude','longitude')] <- c(41.7,-72.21)
missing[grepl('new haven',missing[,'county'],ign=TRUE) ,
        c('latitude','longitude')] <- c(41.3725976,-72.9256266)
missing[grepl('block island',missing[,'locality'],ign=TRUE) ,
        c('latitude','longitude')] <- c(41.1892405,-71.5785894)
### Append the now resolved missing coordinates
ants <- ants[!(is.na(ants[,'latitude'])),]
ants <- rbind(ants,missing)

### Make a map of the locations in New England
ne.map <- qmap(location='new england',zoom=6) 
### 
pdf('NE_arudis_map.pdf')
ne.map + geom_point(data=ants,aes(x=longitude,y=latitude),col='violet',size=0.5)
dev.off()


