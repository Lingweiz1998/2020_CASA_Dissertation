library(tidyverse)
library(dplyr)
library(sf)
library(ggthemes)
library(mapview)
library(rgdal)
library(mapsf)
library(ggmap)
library(ggplot2)

# minimal theme for nice plots throughout the project
theme_set(theme_economist())

#read census geographic information
lsoa.map <- st_read("lsoa.geojson")
pop <- read_csv("resident.csv")
labour <- read_csv("worker1.csv")

demo <- dplyr::left_join(x=labour,y=lsoa.map,by=c("mnemonic"="LSOA11CD"))

demo.map <- dplyr::left_join(x=demo,y=lsoa.map,by=c("code"="lsoa11cd"))

demo.map <- select(demo,c('mnemonic','sum_lab','geometry'))

st_geometry(demo.map) <- demo.map$geometry

# st_write(nyc.demo, "NYCdemo.shp")

LSOA.cent <- st_centroid(demo.map)

LSOA.cent.sf<- demo.map %>%
  as(., 'Spatial')

# result mapped: 
demo.map %>% 
  ggplot() +
  geom_sf(color = "#BFBFBF") +
  geom_sf(data = demo.map, size = 0.75, color = "#4E79A7") +
  ggtitle("Cardiff Census centroids") + 
  theme(axis.text.x = element_blank(), axis.text.y = element_blank())

writeOGR(LSOA.cent.sf, "lsoa_lab2.geojson", layer="lab", driver="GeoJSON")


