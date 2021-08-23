gm.map <- st_read("Metropolitan.geojson")
node <-  st_read("FinalData/clusterresult1.geojson")
edge <- st_read("trainsystem.geojson")

node$bc <- as.numeric(node$bc)
node$cc <- as.numeric(node$cc)
node$greenspace <- as.numeric(node$greenspace)

# Create a link layer
mob_links <- mf_get_links(x = node, df = edge,x_id = 'RSTNAM')
# Plot the links
mf_map(gm.map)
mf_map(node, var = "type", type = "symb",add=TRUE)
mf_map(edge, col = "red4", lwd = 2, add = TRUE)


mf_init(x = gm.map, theme = "candy",expandBB = c(0,0,0,.15))
# Plot a shadow
mf_map(gm.map, add = TRUE)
# Plot the municipalities
mf_map(edge,col = "white", lwd = 2,add = TRUE)
# Plot symbols with choropleth coloration
mf_map(
  x = node, 
  var = "Segement", 
  type = "typo",
  pal = "RdYlBu",
  cex=1.5,
  leg_pos = "topright", 
  leg_title = "Cluster Distribution",
  val_order = c("Cluster4", "Cluster3","Cluster2", 
                "Cluster1"),add=TRUE)
# layout
mf_layout(title = "Train System in Greater Manchester", 
          credits = paste0("Sources: TFGM, 2021\n",
                           "mapsf ", 
                           packageVersion("mapsf")), 
          frame = TRUE)



mf_init(x = gm.map, theme = "candy",expandBB = c(0,0,0,.15))
# Plot a shadow
mf_map(gm.map, add = TRUE)
# Plot the municipalities
mf_map(edge,col = "white", lwd = 2,add = TRUE)
# Plot symbols with choropleth coloration
mf_map(
  x = node, 
  var = "cc", 
  type = "choro",
  pal = "OrRd",
  cex=1.5,
  leg_pos = "topright", 
  leg_title = "Closeness Centrality", add=TRUE)
# layout
mf_layout(title = "GM Station Closeness Centrality", 
          credits = paste0("Sources: TFGM, 2021\n",
                           "mapsf ", 
                           packageVersion("mapsf")), 
          frame = TRUE)