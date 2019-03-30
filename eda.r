

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
