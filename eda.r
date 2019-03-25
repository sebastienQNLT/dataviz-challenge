par_trajet<-read.csv2("https://raw.githubusercontent.com/ToulouseDataViz/Hackaviz2019/master/par_trajet.csv",sep=",",stringsAsFactors = FALSE)
par_commune<-read.csv2("https://raw.githubusercontent.com/ToulouseDataViz/Hackaviz2019/master/par_commune.csv",sep=",",stringsAsFactors = FALSE)

par_trajet<-par_trajet %>% mutate(latitude=as.numeric(latitude),
                                  longitude=as.numeric(longitude),
                                  travail_latitude=as.numeric(travail_latitude),
                                  travail_longitude=as.numeric(travail_longitude)
                                  )

library(DataExplorer)
#general overview ----
introduce(par_trajet)
plot_intro(par_trajet)

introduce(par_commune)
plot_intro(par_commune)

#missing values ----
plot_missing(par_trajet)
profile_missing(par_trajet)
plot_missing(par_commune)
profile_missing(par_commune)

plot_bar(par_trajet)
plot_histogram(par_trajet)

plot_bar(par_commune)
plot_histogram(par_commune)
