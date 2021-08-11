
landuse1 <- st_read("landuse1.geojson")
landuse2 <- st_read("landuse2.geojson")
landuse3 <- st_read("landuse3.geojson")
landuse4 <- read_csv("landuse4.csv")
landuse5 <- read_csv("landuse5.csv")

landusemap <- dplyr::left_join(x=landuse3,y=landuse4,by=c("buffer_poi3.OBJECTID"="join_id"))
landusemap <- dplyr::left_join(x=landusemap,y=landuse5,by=c("buffer_poi3.OBJECTID"="Join_ID"))

landusemap <- select(landusemap,c('buffer_poi3.NPTREF','buffer_poi3.poi3','buffer_poi2.poi2','buffer_poi1.poi1'
                                  ,'poi_house','industry'))

landusemix <- landusemap %>% 
  rename(
    geoid = buffer_poi3.NPTREF,
    l1 = buffer_poi1.poi1,
    l2 = buffer_poi2.poi2,
    l3 = buffer_poi3.poi3,
    l4 = poi_house,
    l5 = industry
  )

landusemix$l1 <- scale(landusemix$l1, center = TRUE, scale = TRUE)
landusemix$l2 <- scale(landusemix$l2, center = TRUE, scale = TRUE)
landusemix$l3 <- scale(landusemix$l3, center = TRUE, scale = TRUE)
landusemix$l4 <- scale(landusemix$l4, center = TRUE, scale = TRUE)
landusemix$l5 <- scale(landusemix$l5, center = TRUE, scale = TRUE)

landusemix <- st_drop_geometry(landusemix)

write.csv(landusemix,"labourcounts.csv", row.names = FALSE)




