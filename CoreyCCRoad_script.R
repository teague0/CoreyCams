
library(sf)
library(tidyverse)
library(mapview)


ccRoad <- read_sf("./data/boundaries/CCRoad_GIS/CCRoad_WHOLE.shp") #I changed the path so I could get to it
ccRoad <- st_cast(ccRoad, "POLYGON")
ccRoad %>% st_geometry() %>% plot

#The above works.


library(ggplot2)
library(ggmap)

grdpts <- sf::st_make_grid(ccRoad,
                           n = c(20,20),
                           what = "centers")

my.points <- sf::st_sf(grdpts)

map <- mapview(ccRoad)
pointsRed <- mapview(my.points, cex=3, color="red")
map+pointsRed

#Above works

pointsInside <- sf::st_join(x = my.points, y = ccRoad, left = FALSE)
pointsInRed <- mapview(pointsInside, cex=3, color="red")
map+pointsInRed

#Above works

pointIn_df <- as(pointsInside, "Spatial") #convert to spatial points data frame
pointIn_df <- as.data.frame(pointIn_df) #convert to flat data frame
pointIn_df.s <- pointIn_df %>% 
  filter(coords.x2 < 30.46)

centerCC <- c(ccRoad$coords.x1[33], ccRoad$coords.x2[33]) #not sure what's happening here

### Okay. Your problem is that you were working with the sf object and not the data frame that was read in in the script StratifiedSampling. I named it ccroad_df to make it more obvious

ccroad_df <- read.csv("./data/CCRoadSamplingSites.csv")
centerCC <- c(ccroad_df$coords.x1[33], ccroad_df$coords.x2[33])
mapCC <- get_map(location = centerCC, zoom = 14, maptype = "satellite")


camNums <- c(17, 54, 28, 16, 52, 13, 23, 39, 19, 32, 67)
camSites <- ccroad_df %>% filter(X %in% camNums)

camsite_sf <- st_as_sf(camSites, 
                       coords = c("coords.x1", "coords.x2"),
                       crs = 4326)
<<<<<<< HEAD
st_write(camsite_sf, "./output/CCRoad.kml", driver = "kml")


ccroadmap <- ggmap(mapCC)+
  geom_text(data = ccroad, aes(x = coords.x1, y = coords.x2, label=X),hjust=0, vjust=0, color = "white")+
  geom_text(data = camSites, aes(x = coords.x1, y = coords.x2, label=X),hjust=0, vjust=0, color = "red")

pdf(file = "./output/CCRoadSites.pdf", width = 8, height = 8)
print(ccroadmap)
dev.off()


=======
write.csv2(camsite_sf, "./output/CCRoad.kml", driver = "kml")


ggmap(mapCC)+
  geom_text(data = ccroad, aes(x = coords.x1, y = coords.x2, label=X),hjust=0, vjust=0, color = "white")+
  geom_text(data = camSites, aes(x = coords.x1, y = coords.x2, label=X),hjust=0, vjust=0, color = "red")

>>>>>>> 70e407c36429e3d608035b72e35d035482e36d7b
```
