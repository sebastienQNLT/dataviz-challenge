
proxy = paste0("http://", Sys.getenv('LOGNAME'), ":", "Maaf0006", "@10.200.16.132:8128")
Sys.setenv(http_proxy=proxy) 
Sys.setenv(https_proxy=proxy) 
Sys.setenv(ftp_proxy=proxy)

par_trajet<-read.csv2("https://raw.githubusercontent.com/ToulouseDataViz/Hackaviz2019/master/par_trajet.csv",sep=",",stringsAsFactors = FALSE)
par_commune<-read.csv2("https://raw.githubusercontent.com/ToulouseDataViz/Hackaviz2019/master/par_commune.csv",sep=",",stringsAsFactors = FALSE)

par_trajet<-par_trajet %>% mutate(latitude=as.numeric(latitude),
                                  longitude=as.numeric(longitude),
                                  travail_latitude=as.numeric(travail_latitude),
                                  travail_longitude=as.numeric(travail_longitude)
)

par_commune<-par_commune %>% mutate(latitude=as.numeric(latitude),
                                    longitude=as.numeric(longitude)
)

library(geojsonio)
library(leaflet)
library(dplyr)
library(svglite)
library(ggplot2)
library(maptools)
library(rgdal)
setwd("~/dataviz challenge")
data_json <- geojson_read("./region-occitanie.geojson",
                          what = "sp")

occitanie<- subset(data_json, nom=="Occitanie")
occitanie <- fortify(occitanie)

data<-par_trajet %>%
  filter(travail_departement !="95") %>% 
  filter(travail_departement !="0") %>% 
  filter(travail_departement !="26") %>% 
  filter(travail_departement !="40") %>% 
  filter(travail_departement !="33") %>% 
  filter(travail_departement !="64") %>% 
  filter(departement !="95") %>% 
  filter(departement !="0") %>% 
  filter(departement !="26") %>% 
  filter(departement !="40") %>% 
  filter(departement !="33") %>% 
  filter(departement !="64") %>% 
  select(departement,
                            latitude,travail_latitude,
                            longitude,travail_longitude,
                            X2014_extra_travail_commune,commune) %>% 
  filter(X2014_extra_travail_commune>0) %>% 
  dplyr::rename(trips=X2014_extra_travail_commune,
         oX=longitude,
         oY=latitude,
         dX=travail_longitude,
         dY=travail_latitude)

xquiet<- scale_x_continuous("", breaks=NULL)
yquiet<-scale_y_continuous("", breaks=NULL)
quiet<-list(xquiet, yquiet)

data.commune<-data %>%
  dplyr::group_by(commune,oX,oY) %>%
  dplyr::summarize(s=sum(trips)) 


a<-ggplot()+
  #Set black background, ditch axes and fix aspect ratio
  theme(panel.background = element_rect(fill='black',colour='black'))+
  quiet+
  coord_fixed(xlim=c(-0.10,5),ylim=c(42.2,45))+
  theme(legend.position="none")+
  geom_map(data=occitanie, map=occitanie, aes(map_id=id),
           fill=NA,colour=alpha("lightcyan1",.75))
a 
ggsave("fond.pdf",dpi = 2400,plot=a,
       width = 37.6, height = 27.32, units = c("cm"))

# plot constellation ----
p<-ggplot()+
#Set black background, ditch axes and fix aspect ratio
  theme(panel.background = element_rect(fill='black',colour='black'))+
  quiet+
  coord_fixed(xlim=c(-0.10,5),ylim=c(42.2,45))+
  theme(legend.position="none")+
  scale_shape_identity() +
  geom_point(data=data.commune,aes(x=oX,y=oY,shape=11),
             color=alpha("white",.5),size=.1)+
  scale_alpha_continuous(range = c(0.1, .95))+
  geom_segment(data=data,aes(x=oX, y=oY,xend=dX, yend=dY, alpha=trips,size=0.6), 
               col="lightcyan1", 
               size=1.5
               )+
  geom_map(data=occitanie, map=occitanie, aes(map_id=id),
            fill=NA,colour=alpha("lightcyan1",.75))
p 

ggsave("constellation.svg",dpi = 2400,plot=p,
       width = 37.6, height = 27.32, units = c("cm"))


#plot stars ----
data.stars<-par_commune %>% 
  group_by(commune,latitude,longitude) %>% 
  summarise(extra=sum(X2014_extra_km),
            intra=sum(X2014_intra_km)
            ) %>% 
  mutate(tot=(extra+intra)/100*13,5/1000) %>% 
  arrange(-tot)

data.stars.5<-data.stars %>% 
  head(5)

data.stars.20<-data.stars[1:25,]


q<-ggplot()+
  geom_point(data=data.stars.20,aes(x=latitude,y=longitude,size=tot,color=tot))+
  scale_colour_gradient2(low = alpha("blue",.8), mid=alpha("white",.4),high = alpha("white",.9))+
  theme(panel.background = element_rect(fill='black',colour='black'))+
  quiet+theme(legend.position="none")+
  scale_size(range = c(0, 20))+
  coord_fixed(xlim=c(-0.10,5),ylim=c(42.2,45))+
  geom_map(data=occitanie, map=occitanie, aes(map_id=id),
           fill=NA,colour=alpha("lightcyan1",.75))
  q
  
  ggsave("stars.svg",dpi = 2400,plot=q,
         width = 25.78, height = 18.72, units = c("cm"))
  