map <- read_csv("FinalData/trainmergednet.csv")
green <- read_csv("FinalData/buffer_Green.csv")
merged <- dplyr::left_join(x=map,y=green,by=c("NPTREF"="geoid"))
write.csv(merged,"FinalData/npm_greenspace.csv", row.names = FALSE)


map <- read_csv("FinalData/npm_greenspace_forclustering.csv")
green <- read_csv("labourcounts.csv")
merged <- dplyr::left_join(x=map,y=green,by=c("NPTREF"="geoid"))
write.csv(merged,"FinalData/npm_greenspace_forclustering.csv", row.names = FALSE)


