# Chargement du jeu de donnees
# twitter #TidyTuesday!
library(ggplot2)
library(tidyverse)

df_nuclear <- tt_load("2019-08-20")$nuclear_explosions
df_nuclear

emperors <- tt_load("2019-08-13")$emperors

# Manipulation de facteurs
library(forcats)

# Transformation en facteur
as_factor() # utilise par defaut l'ordre d'apparition et non l'ordre alphabétique et donc independant du locate

# Recodage
fct_recode(nom, ancienniveau = niveau)
# A l'aide d'une fonction
fct_relabel(nom, str_to_title)

# Reordonner les labels
## par rapport à une autre variable
levels(iris$Species)
#iris %>% mutate(Species = fct_reorder(Species, Sepal.Width) )
#              %>% ggplot() + aes(x = Species, y = Sepal.Width, fill = Species)
#                + geom_boxplot(notch = TRUE, show.legend = FALSE)
                
## Adieu spread, gather, Bienvenue pivot_longer dans tidyr !
WorldPhones %>% as_tibble(rownames = 'Year') %>%
  pivot_longer(-Year, names_to = "Region", values_to = "Count")

## fct_reorder2(Region, Year, Count) Reordonne Region par rapport à derniere année et comptage

anscombe %>%
  pivot_longer(everything(),
               names_to = c(".value", "group"),
               names_pattern = "(.)(.)")
# option full_range = TRUE
# (.) expression reguliere

## Exercice : 
df_nuclear %>% count(country, sort = TRUE) %>%
  mutate(country = fct_inorder(country),
         country = fct_rev(country),
         country = fct_recode(country, France = "FRANCE", China = "CHINA", 
                              India = "INDIA", Pakistan = "PAKIST")) %>%
ggplot() + aes(x = country, y = n, fill = country) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(x = "Country", y = "Total number of nuclear explosions") +
  scale_fill_viridis_d(option = "E", direction = -1)

 # viridis option = "E" couleur pour impression en noir et blanc et daltonien


# Regroupement de niveaux
# fct_lump pour regrouper les plus frequents (n=)
# REgroupement des facteurs qui apparaissent au moins 20 fois fct_lump_min(min = 20)
# A la main fct_collapse
#df_nuclear$type %>%
#  fct_collape(Air = c("Atmosph", "Airdrop"), ...)

# fct_c pour concatener deux facteurs
# theme et couleur ggexpanse, arg dans geom_line, facteurs ordonnes en fonction derniere valeur et regroupement
# pakistan et inde et sur 2 lignes

df_nuclear %>%
  mutate(country = fct_collapse(`PAKISTAN\n& INDIA`= c("PAKIST", "INDIA"))) %>%
  count(year, country) %>%
  group_by(country) %>%
  mutate(cum = cumsum(n)) %>%
  ungroup() %>%
  mutate() %>%
  ggplot() %>%
  aes(x = year, y = cumsum)

## A completer...

###############@ Gestion des dates ###############
## 
library(lubridate)
first_landing <- ymd("1969-07-20")
class(first_landing)
x <- ymd_hms("2009-08-03 12:01:59.23")
  
# fonction mdy formatted dates could be very different mais tant que l ordre est ok.
# idem avec les heures
# Fonctions pour extraire ce qu'on veut year(), month(label = TRUE), etc...
# Arrondir les dates

Sys.setlocale("LC_TIME", "C")

# week_start = 1 permet de commander la semaine à lundi.
df_nuclear %>%
  select(date_long, country) %>%
  mutate(date = ymd(date_long)) %>%
  mutate(wday = wday(date, label = TRUE, week_start = 1, abbr = FALSE), 
         month = month(date, label = TRUE),
         wday = fct_rev(wday))


  