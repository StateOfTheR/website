---
title: Livecoding
author: ~
date: '2020-04-17'
slug: livecoding
categories: ["workshop"]
tags: ["devtools","usethis","testthat","package"]
subtitle: ''
summary: ''
authors: []
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

Confinement oblige, ce vendredi 17 avril 2020 a lieu le premier State of the R en distanciel. Antoine nous a proposé une séance de live coding consacrée à la création de package sous Twitch, une plateforme de diffusion de vidéos en flux continu, qui permet de partager en temps réel l'écran et la petite bouille d'Antoine.

Quel sujet ?
La *création de package* pour tous, depuis la base. Il suffit juste de savoir comment on crée une fonction en R.
Tout sera fait avec le package usethis mis à jour il y a peu, donc Antoine a présenté ce qui a changé (bye bye *Travis* et *AppVeyor*, welcome *GitHub Action*).

Trois parties :

- le minimum vital (fonctions, description, check...)
- les bonnes pratiques (tests, intégration continue, pkgdown...)
- quelques besoins spécifiques (jeu de données, Rcpp, template rmarkdown, addin...)


Pour installer les packages qui seront utilisés :

```r
install.packages("remotes")
remotes::install_github(c("r-lib/devtools",
                          "r-lib/usethis", # ne prenez pas celle du CRAN, c'est pas la dernière 
                          "r-lib/testthat",
                          "r-lib/pkgdown",
                          "r-lib/covr",
                          "mangothecat/goodpractice",
                          "ThinkR-open/attachment",
                          "ropensci/spelling",
                          "RcppCore/Rcpp",
                          "abichat/rcppclick",
                          "GuangchuangYu/badger",
                          "rmhogervorst/badgecreatr"))
```


                          
Le site pkgdown déployé pendant la séance est dispo [ici](https://stateofther.github.io/LCpackage/)
