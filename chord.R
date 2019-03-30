par_trajet<-read.csv2("https://raw.githubusercontent.com/ToulouseDataViz/Hackaviz2019/master/par_trajet.csv",sep=",",stringsAsFactors = FALSE)

library(circlize)
library(dplyr)
circos.clear()
circos.par(start.degree = 270,
           gap.degree =4)


#TOULOUSE ----
par_trajet %>%filter(travail_commune=="TOULOUSE") %>% 
  select(commune,X2014_extra_travail_commune) %>% 
  arrange(-X2014_extra_travail_commune) %>% 
  head(5)

rm(mat)
c1<-c(5992,0,0,0,0)
c2<-c(0,5969,0,0,0)
c3<-c(0,0,3888,0,0)
c4<-c(0,0,0,3413,0)
c5<-c(0,0,0,0,3373)
(mat<-cbind(c1,c2,c3,c4,c5))
rownames(mat) = c("TOULOUSE","TOULOUSE","TOULOUSE","TOULOUSE","TOULOUSE")
colnames(mat) = c("COLOMIERS","TOURNEFEUILLE","BLAGNAC","CUGNAUX","PLAISANCE_DU_TOUCH")
mat

chordDiagram(mat,annotationTrack =  c("name", "grid"), grid.col = "lightcyan3",
             transparency = .8,link.border = "white")

#NIMES
par_trajet %>%filter(travail_commune=="NIMES") %>% 
  select(commune,X2014_extra_travail_commune) %>% 
  arrange(-X2014_extra_travail_commune) %>% 
  head(5)

rm(mat)
c1<-c(1533,0,0,0,0)
c2<-c(0,1272,0,0,0)
c3<-c(0,0,1121,0,0)
c4<-c(0,0,0,1120,0)
c5<-c(0,0,0,0,992)
(mat<-cbind(c1,c2,c3,c4,c5))
rownames(mat) = c("NIMES","NIMES","NIMES","NIMES","NIMES")
colnames(mat) = c("MARGUERITTES","MONTPELLIER","BOUILLARGUES","MANDUEL","MILHAUD")

chordDiagram(mat,annotationTrack =  c("name", "grid"), 
             grid.col = "lightcyan3",
             transparency = .8,link.border = "white"
             )



#MONTPELLIER
par_trajet %>%filter(travail_commune=="MONTPELLIER") %>% 
  select(commune,X2014_extra_travail_commune) %>% 
  arrange(-X2014_extra_travail_commune) %>% 
  head(5)

rm(mat)
c1<-c(3572,0,0,0,0)
c2<-c(0,2635,0,0,0)
c3<-c(0,0,2356,0,0)
c4<-c(0,0,0,2073,0)
c5<-c(0,0,0,0,1890)
(mat<-cbind(c1,c2,c3,c4,c5))
rownames(mat) = c("MONTPELLIER","MONTPELLIER","MONTPELLIER","MONTPELLIER","MONTPELLIER")
colnames(mat) = c("CASTELNAU-LE-LEZ ","LATTES","MAUGUIO","SAINT-GELY-DU-FESC","GRABELS")


chordDiagram(mat,annotationTrack =  c("name", "grid"),  grid.col = "lightcyan3",
             transparency = .8,link.border = "white")


#PERPIGNAN
par_trajet %>%filter(travail_commune=="PERPIGNAN") %>% 
  select(commune,X2014_extra_travail_commune) %>% 
  arrange(-X2014_extra_travail_commune) %>% 
  head(5)

c1<-c(2034,0,0,0,0)
c2<-c(0,1588,0,0,0)
c3<-c(0,0,1467,0,0)
c4<-c(0,0,0,1368,0)
c5<-c(0,0,0,0,1350)
(mat4<-cbind(c1,c2,c3,c4,c5))
rownames(mat4) = c("PERPIGNAN","PERPIGNAN","PERPIGNAN","PERPIGNAN","PERPIGNAN")
colnames(mat4) = c("SAINT-ESTEVE ","CABESTANY","PIA","TOULOUGES","LE SOLER")

chordDiagram(mat4,annotationTrack =  c("name", "grid"), grid.col = "lightcyan3",
             transparency = .8,link.border = "white")