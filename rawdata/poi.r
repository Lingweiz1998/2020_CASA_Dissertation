
map <- st_read("poi_geo.geojson")
poi1 <- read_csv("poi_retial_food_hotel.csv")
poi2 <- read_csv("poi_edu_heal_cul.csv")
poi3 <- read_csv("poi_admin_public.csv")

map <- select(map,c('osm_id','geometry'))

poi1$osm_id <- as.character(poi1$osm_id)
poi2$osm_id <- as.character(poi2$osm_id)
poi3$osm_id <- as.character(poi3$osm_id)


poi1.map <- dplyr::left_join(x=poi1,y=map,by=c("osm_id"="osm_id"))
poi2.map <- dplyr::left_join(x=poi2,y=map,by=c("osm_id"="osm_id"))
poi3.map <- dplyr::left_join(x=poi3,y=map,by=c("osm_id"="osm_id"))

st_geometry(poi1.map) <- poi1.map$geometry
st_geometry(poi2.map) <- poi2.map$geometry
st_geometry(poi3.map) <- poi3.map$geometry

poi1.map.sf<- poi1.map %>%
  as(., 'Spatial')
poi2.map.sf<- poi2.map %>%
  as(., 'Spatial')
poi3.map.sf<- poi3.map %>%
  as(., 'Spatial')

writeOGR(poi1.map.sf, "poi1.geojson", layer="poi1", driver="GeoJSON")
writeOGR(poi2.map.sf, "poi2.geojson", layer="poi2", driver="GeoJSON")
writeOGR(poi3.map.sf, "poi3.geojson", layer="poi3", driver="GeoJSON")




