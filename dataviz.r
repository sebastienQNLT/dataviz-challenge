library(leaflet)
library(dplyr)
library(svglite)
data<-par_trajet %>% select(departement,
                            latitude,travail_latitude,
                            longitude,travail_longitude,
                            X2014_extra_travail_commune,commune) %>% 
  filter(X2014_extra_travail_commune>0) %>% 
  dplyr::rename(trips=X2014_extra_travail_commune,
         oX=longitude,
         oY=latitude,
         dX=travail_longitude,
         dY=travail_latitude)

library(ggplot2)
library(maptools)
library(rgdal)

xquiet<- scale_x_continuous("", breaks=NULL)
yquiet<-scale_y_continuous("", breaks=NULL)
quiet<-list(xquiet, yquiet)

data.commune<-data %>%
  dplyr::group_by(commune,oX,oY) %>%
  dplyr::summarize(s=sum(trips)) %>% 
  filter(commune %in% c('TOULOUSE','MONTPELLIER','PERPIGNAN','NIMES')         )


(p<-ggplot(data, aes(oX, oY))+
  #The next line tells ggplot that we wish to plot line segments. The "alpha=" is line transparency and used below 
  geom_segment(aes(x=oX, y=oY,xend=dX, yend=dY, alpha=trips), 
               col="azure1", 
               lineend = "round",
               size=.2)+
  #Here is the magic bit that sets line transparency - essential to make the plot readable
  scale_alpha_continuous(range = c(0.2, 0.9))+
  #Set black background, ditch axes and fix aspect ratio
  theme(panel.background = element_rect(fill='black',colour='black'))+quiet+
  coord_fixed(xlim=c(-0.10,5),ylim=c(42.2,44.6))+
  theme(legend.position="none")+
  geom_text(data=data.commune,aes(x=oX, y=oY,label=commune,fontface=2),hjust=0, vjust=0, 
            col="cadetblue1",size=2,family="sans"))

ggsave("test.pdf",dpi = 1200,
       width = 28, height = 20, units = c("cm"))

       
