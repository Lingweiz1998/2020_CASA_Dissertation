library (igraph)
library (readr)
library (haven)
library (ggplot2)

Colleague_Network <- read.csv('FinalData/network.csv')

Discussion_Network <- read.csv('FinalData/network.csv')

Discussion_EdgeList <- Discussion_Network
#Creating a Graph Obeject for Subsequent Analyses
#Importantly, we define here whether the graph will be directed or not
Discussion_Graph2=graph_from_data_frame(Discussion_EdgeList, directed=FALSE)

plot(Discussion_Graph2)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout_with_kk(Discussion_Graph2)
#Node or Vetex Options: Size and Color
V(Discussion_Graph2)$size=degree(Discussion_Graph, mode = "in")/5 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.
V(Discussion_Graph2)$color <- ifelse(Discussion_Attributes[V(Discussion_Graph2), 2] == "Researcher", "blue", "red")

#Edge Options: Color
E(Discussion_Graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(Discussion_Graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


Discussion_OutDegree <- degree(Discussion_Graph2, mode = 'all')
Discussion_OutDegree <- as.data.frame(Discussion_OutDegree)

#Betweeness Centrality
Discussion_Betweeness <- betweenness(Discussion_Graph2)
Discussion_Betweeness <- as.data.frame(Discussion_Betweeness)


#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(Discussion_Graph2,niter=500)
#Node or Vetex Options: Size and Color
V(Discussion_Graph2)$size=betweenness(Discussion_Graph)/200 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.
V(Discussion_Graph2)$color <- ifelse(Discussion_Attributes[V(Discussion_Graph2), 2] == "Researcher", "blue", "red")

#Edge Options: Color
E(Discussion_Graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(Discussion_Graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


Discussion_InCloseness <- closeness(Discussion_Graph2,mode="all")
Discussion_InCloseness <- as.data.frame(Discussion_InCloseness)


eigen_centrality(Discussion_Graph2)
Discussion_EigenCentrality <- eigen_centrality(Discussion_Graph2)
Discussion_EigenCentrality <- as.data.frame(Discussion_EigenCentrality)

write.csv(Discussion_OutDegree,"FinalData/degree.csv", row.names = TRUE)
write.csv(Discussion_Betweeness,"FinalData/betweeness.csv", row.names = TRUE)
write.csv(Discussion_InCloseness,"FinalData/closeness.csv", row.names = TRUE)
write.csv(Discussion_EigenCentrality,"FinalData/eigen.csv", row.names = TRUE)


edgelists <- as_edgelist(Discussion_Graph2, names = TRUE)
write_graph(Discussion_Graph2, "networkgraph.txt", format = c("edgelist"))
