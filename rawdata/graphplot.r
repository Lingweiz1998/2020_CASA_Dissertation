library(plot3D)
library(scales)
library(RColorBrewer)
library(fields) 
library(wesanderson)
library(plotly)


df <- read_csv("FinalData/railandmetro_merged1.csv")
normdf <- read_csv("FinalData/normedmetrolink.csv")
clt <- read_csv("FinalData/clusterresult2.csv")



clt$Segement <- as.factor(clt$Segement)
colors <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00')

fig <- plot_ly(clt, x = ~node, y = ~place, z = ~design, color = ~Segement,size = ~greenspace, 
               colors = colors,sizes = c(10,100))
fig <- fig %>% add_markers()
fig <- fig %>% layout(scene = list(xaxis = list(title = 'node'),
                                   yaxis = list(title = 'place'),
                                   zaxis = list(title = 'design')))

fig