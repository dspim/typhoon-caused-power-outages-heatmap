library(leaflet)
library(rgdal)
library(RColorBrewer)

path <- "./"
tw <- readOGR(dsn = paste0(path, '村里界圖(TWD97經緯度)1050715/Village_NLSC_1050715.shp'),
              layer='Village_NLSC_1050715', stringsAsFactors = F,
              verbose = F)

train <- read.csv(paste0(path,"train.csv"))

tw@data <- left_join(tw@data, train, by=c("VILLAGE_ID"="VilCode"))


# 繪製 Soudelor 停電戶數，熱點用log轉換 
leaflet(tw) %>%
  addPolygons(weight = 0, smoothFactor = 0.1, opacity = 0.1, fillOpacity = 1,
              fillColor = ~colorNumeric("YlOrRd", log(Soudelor+1))(log(Soudelor+1))) %>%
  addTiles(attribution = 'DSP, Inc.') 
