#Stratified random sampling
library(tidyverse)
library(ggmap)

abita <- read.csv("./data/AbitaFlatsSamplingSites.csv")
ccroad <- read.csv("./data/CCRoadSamplingSites.csv")

center <- c(abita$coords.x1[70], abita$coords.x2[70])
map <- get_map(location = center, zoom = 14, maptype = "satellite")

ggplot(abita)+
  geom_text(aes(x = coords.x1, y = coords.x2, label=X),hjust=0, vjust=0)

east <- abita %>% filter(use == east)

pdf("./output/abitaSites.pdf", width = 8, height = 11 )
ggmap(map)+
  geom_text(data = abita, aes(x = coords.x1, y = coords.x2, label=X),hjust=0, vjust=0, color = "white")
dev.off()


ggplot(ccroad)+
  geom_text(aes(x = coords.x1, y = coords.x2, label=X),hjust=0, vjust=0)

centerCC <- c(ccroad$coords.x1[33], ccroad$coords.x2[33])
mapCC <- get_map(location = centerCC, zoom = 14, maptype = "satellite")

ggmap(mapCC)+
  geom_text(data = ccroad, aes(x = coords.x1, y = coords.x2, label=X),hjust=0, vjust=0, color = "white")
