library(sf)
library(tidyverse)
library(mapview)

## read the shapefiles
ccRoad <- sf::st_read("./data/boundaries/CCRoad_GIS/CCRoad_WHOLE.shp")
ccRoad <- st_cast(ccRoad,"POLYGON")
ccRoad %>% st_geometry() %>% plot #This still includes the northern parcel. 

## create a grid of points
grdpts <- sf::st_make_grid(ccRoad,
                           n = c(20,20),
                           what = "centers") #these are all just under 200 m apart

## convert it to an `sf` object, as opposed to an `sfc`
my.points <- sf::st_sf(grdpts) 

map <- mapview(ccRoad)
pointsRed <- mapview(my.points, cex=3, color="red")
map+pointsRed

pointsInside <- sf::st_join(x = my.points, y = ccRoad, left = FALSE)
pointsInRed <- mapview(pointsInside, cex=3, color="red")
map+pointsInRed

#Points from the Northern parcel are still included. Need to drop anything north of 30.46
pointIn_df <- as(pointsInside, "Spatial") #convert to spatial points data frame
pointIn_df <- as.data.frame(pointIn_df) #convert to flat data frame
pointIn_df.s <- pointIn_df %>%
  filter(coords.x2 < 30.46)
write.csv(pointIn_df.s, file = "./data/CCRoadSamplingSites.csv")


dat <- sf::st_read("./data/boundaries/Northshore/AbitaFlatwoods_WHOLE.shp")
dat <- st_cast(dat,"POLYGON")
dat %>% st_geometry() %>% plot #This still includes the northern parcel. 

## create a grid of points
grdpts <- sf::st_make_grid(dat,
                           n = c(20,20),
                           what = "centers") #these are all just under 200 m apart

## convert it to an `sf` object, as opposed to an `sfc`
my.points <- sf::st_sf(grdpts) 

map <- mapview(dat)
pointsRed <- mapview(my.points, cex=3, color="red")
map+pointsRed

pointsInside <- sf::st_join(x = my.points, y = dat, left = FALSE)
pointsInRed <- mapview(pointsInside, cex=3, color="red")
map+pointsInRed

#Points from the eastern parcel are still included. Need to drop anything east of -89.95571
pointIn_df <- as(pointsInside, "Spatial") #convert to spatial points data frame
pointIn_df <- as.data.frame(pointIn_df) #convert to flat data frame
pointIn_df.s <- pointIn_df %>%
  filter(coords.x1 < -89.95571)
write.csv(pointIn_df.s, file = "./data/AbitaFlatsSamplingSites.csv")


