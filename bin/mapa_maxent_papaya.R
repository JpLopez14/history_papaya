# Mapa de distribucion potencial de papaya # 


# Cargar packages

library(ggplot2)
library(raster)
library(rasterVis)
library(rgdal)
library(grid)
library(scales)
library(viridis)  
library(ggthemes)
library(readr)

# Cargar base con distribucion puntual de carica papaya #

CP_2017 <- read_csv("../raw_maxent_cp_mex.csv")
names(CP_2017)

CP_2017$Latitude<-as.numeric(CP_2017$Latitud)
CP_2017$Longitude<-as.numeric(CP_2017$Longitud)

names(CP_2017)
CP_2017 <- data.frame(ID = CP_2017$Especie, longitude = CP_2017$Longitude, latitude = CP_2017$Latitude, stringsAsFactors = T)

plot(CP_2017)
####################################
# cargamos el output del MaxEnt #### 
####################################

MaxEnt_CP <- raster("out_MaxEnt/mapa1/Carica_Papaya_total.asc") 

test_spdf <- as(MaxEnt_CP, "SpatialPixelsDataFrame")
test_df <- as.data.frame(test_spdf)
colnames(test_df) <- c("value", "x", "y")

source("../functions/Scale_Bar.R")

# Mapa 1 #

ggplot() +  
  geom_tile(data=test_df, aes(x=x, y=y, fill=value), alpha=1)+
  coord_equal()+
  scale_fill_viridis(breaks=c(0,0.2,0.4,0.6,0.8,1))+
  theme(legend.position="bottom", panel.border = element_rect(linetype = "solid", fill = NA)) +
  theme(legend.key.width=unit(2, "cm"))+
  geom_point(data=CP_2017, aes(x=longitude, y=latitude), color="black", size= 1)+xlab("Longitude")+ylab("Latitude")+
  scale_bar(lon = -120, lat = 0, distance_lon = 500, distance_lat = 100, distance_legend = 200,
            dist_unit = "km", orientation = FALSE, arrow_length = 100, arrow_distance = 60, arrow_north_size = 1)+theme_bw()

ggsave("figures/Mapa1/papaya_mapa_mexdata_19bio.pdf")
ggsave("figures/Mapa1/papaya_mapa_mexdata_19bio.png")




####################################
# cargamos el resultado del MaxEnt # con quitando algunas de bioclim y parámetros de valeria A
#################################### data: mexico + costa rica

MaxEnt_CP <- raster("out_MaxEnt/mapa2/Carica_Papaya_avg.asc") 

test_spdf <- as(MaxEnt_CP, "SpatialPixelsDataFrame")
test_df <- as.data.frame(test_spdf)
colnames(test_df) <- c("value", "x", "y")

# Mapa 2 #

ggplot() +  
  geom_tile(data=test_df, aes(x=x, y=y, fill=value), alpha=1)+
  coord_equal()+
  scale_fill_viridis(breaks=c(0,0.2,0.4,0.6,0.8,1))+
  theme(legend.position="bottom", panel.border = element_rect(linetype = "solid", fill = NA)) +
  theme(legend.key.width=unit(2, "cm"))+
  geom_point(data=CP_2017, aes(x=longitude, y=latitude), color="black", size= 1)+xlab("Longitude")+ylab("Latitude")+
  scale_bar(lon = -120, lat = 0, distance_lon = 500, distance_lat = 100, distance_legend = 200,
            dist_unit = "km", orientation = FALSE, arrow_length = 100, arrow_distance = 60, arrow_north_size = 1)+theme_bw()

ggsave("figures/Mapa2/Mapa2.png")
ggsave("figures/Mapa2/Mapa2.pdf")




