library(leaflet)
library(dplyr)
data<-par_trajet %>% select(departement,
                            latitude,travail_latitude,
                            longitude,travail_longitude,
                            X2014_extra_travail_commune) %>% 
  filter(X2014_extra_travail_commune>0) %>% 
  rename(trips=X2014_extra_travail_commune,
         oX=longitude,
         oY=latitude,
         dX=travail_longitude,
         dY=travail_latitude)

library(plyr)
library(ggplot2)
library(maptools)
library(rgdal)

xquiet<- scale_x_continuous("", breaks=NULL)
yquiet<-scale_y_continuous("", breaks=NULL)
quiet<-list(xquiet, yquiet)


ggplot(data, aes(oX, oY))+
  #The next line tells ggplot that we wish to plot line segments. The "alpha=" is line transparency and used below 
  geom_segment(aes(x=oX, y=oY,xend=dX, yend=dY, alpha=trips), col="white")+
  #Here is the magic bit that sets line transparency - essential to make the plot readable
  scale_alpha_continuous(range = c(0.05, 0.5))+
  #Set black background, ditch axes and fix aspect ratio
  theme(panel.background = element_rect(fill='black',colour='black'))+quiet+
  coord_fixed(ylim=c(42.2,45))
