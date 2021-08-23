library(plot3D)
library(scales)
library(RColorBrewer)
library(fields) 
library(wesanderson)
library(plotly)


df <- read_csv("FinalData/railandmetro_merged1.csv")
normdf <- read_csv("FinalData/normedmetrolink.csv")
clt <- read_csv("FinalData/cwithoutpca.csv")



clt$Segement <- as.factor(clt$Segement)
colors <- c('#d7191c', '#fdae61', '#abd9e9', '#2c7bb6')

fig <- plot_ly(clt, x = ~node, y = ~place, z = ~design, color = ~Segement,
               colors = colors)
fig <- fig %>% add_markers()
fig <- fig %>% layout(scene = list(xaxis = list(title = 'node'),
                                   yaxis = list(title = 'place'),
                                   zaxis = list(title = 'design')))

fig
