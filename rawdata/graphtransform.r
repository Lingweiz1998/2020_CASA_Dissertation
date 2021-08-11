nodel <- read_csv("railwaymap.csv")
edgel <- read_csv("edgelist.csv")
gm.map <- st_read("gmboundary.geojson")


merged <- dplyr::left_join(x=edgel,y=nodel,by=c("from"="RSTNAM"))

merged1 <- dplyr::left_join(x=merged,y=nodel,by=c("to"="RSTNAM"))

write.csv(merged1,"graphin.csv", row.names = FALSE)
merged1 <- read_csv("graphinii.csv")

ggplot(gm.map)+
  geom_sf(aes(fill="white"))+
  geom_path (data=merged1,aes(x=longitude.x,y=latitude.x,group=type.x,colour=type.x), size=1,linejoin = "bevel", lineend = "square")+
  geom_point(data=merged1,aes(x=longitude.x,y=latitude.x,group=type.x,colour=type.x),shape=21,size=2.5,fill="white")+
  xlab("longitude.x")+
  ylab("latitude.x")

ggplot(gm.map) +
  geom_sf(fill="grey")+
  
  geom_curve(data=merged1,aes(x=longitude.x,y=latitude.x,xend=longitude.y,yend=latitude.y,
                              colour=Type),
             size=0.75,curvature = 0.01)+
  geom_point(data =merged1,aes(x=longitude.y,y=latitude.y,colour=type.y),
             shape=21,size=2.5,fill="white")
