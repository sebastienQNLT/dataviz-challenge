par_trajet %>% 
  mutate(tps.global=as.numeric(distance_auto_km)*X2009_extra_travail_commune)%>% 
  group_by(commune) %>% 
  summarize(s1=sum(tps.global),
            s2=sum(X2009_extra_travail_commune)) %>% 
  mutate(dist.moyenne=s1/s2) %>% 
  filter(commune=="TOULOUSE")

par_trajet %>% 
  group_by(commune) %>% 
  summarize(s1=mean(as.numeric(distance_auto_km)) ) %>% 
  filter(commune=="TOULOUSE")

