# départements 13
# habitants 5.7M
# communes 4516
# emplois 670 136
# revenu median 17206
# 
# dist km - 16km
  # 20 M*2 de km /
  # 50 AR terre lune
# dist horaire - 20mn
# CO2 global /extra - 2700T*2 par JOUR 



library(dplyr)
par_commune %>% summarize(s=sum(emplois)) # 670 136
par_commune %>% summarize(s=sum(habitants)) #5 730753
par_commune %>% summarize(s=n_distinct(insee)) #4 516
par_commune %>% summarize(s=sum(pers_par_menages)) #5506008
par_commune %>% summarize(s=sum(menages)) #2455503
par_commune %>% summarize(s=sum(X2015)) #2220866
# revenu median par UC
par_commune %>% mutate(revenu=revenu_median*unite_conso_menages) %>% 
  mutate(revenu=ifelse(is.na(revenu),0,revenu)) %>% 
  summarize(s=sum(revenu),
            s2=sum(unite_conso_menages)) %>% 
  mutate(r=s/s2) #17206

#distance km extra
t<-par_commune %>%
  mutate(km.extra=X2014_extra_km/X2014_extra) %>% 
  mutate(km.extra=ifelse(is.na(km.extra),0,km.extra)) %>% 
  select(commune,X2014_extra,km.extra)

t %>% summarize(s=sum(X2014_extra*km.extra),
                s2=sum(X2014_extra)) %>% 
  mutate(r=s/s2)

#distance km extra
t<-par_commune %>%
  mutate(km.extra=X2014_extra_heure/X2014_extra) %>% 
  mutate(km.extra=ifelse(is.na(km.extra),0,km.extra)) %>% 
  select(commune,X2014_extra,km.extra)

t %>% summarize(s=sum(X2014_extra*km.extra),
                s2=sum(X2014_extra)) %>% 
  mutate(r=s/s2)

#CO2
par_commune %>%
  mutate(X2014_extra_km=ifelse(is.na(X2014_extra_km),0,X2014_extra_km)) %>% 
  summarize(co2=sum(X2014_extra_km))%>%
  mutate(co2=co2*13.5/100/1000)

par_commune %>%
  mutate(X2014_extra=ifelse(is.na(X2014_extra),0,X2014_extra)) %>% 
  summarize(nb=sum(X2014_extra)) 