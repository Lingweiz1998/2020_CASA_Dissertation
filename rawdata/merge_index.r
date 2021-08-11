metro <- read_csv("FinalData/railandmetro_merged.csv")
bet <- read_csv("FinalData/betweeness.csv")
clo <- read_csv("FinalData/closeness.csv")
eig <- read_csv("FinalData/eigen.csv")


merged <- dplyr::left_join(x=metro,y=bet,by=c("name"="X1"))
merged <- dplyr::left_join(x=merged,y=clo,by=c("name"="X1"))
merged <- dplyr::left_join(x=merged,y=eig,by=c("name"="X1"))


write.csv(merged,"FinalData/trainmergednet.csv", row.names = FALSE)

