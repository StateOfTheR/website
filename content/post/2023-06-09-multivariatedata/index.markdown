---
title: Analyse de données multivariées
author: State of the R
date: '2023-06-09'
slug: multivariatedata
categories: ["HappyR","workshop"]
bibliography: biblio.bib
tags: ["multivariate data", "pyPLNmodels","PLNmodels","gllvm","hmsc"]
subtitle: ''
summary: ''
authors: []
lastmod: '2023-06-09T11:40:51+02:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

## Présentation de `{pyPLNmodels}`

Bastien Batardière nous présente le package python `{pyPLNmodels}`, conçu spécifiquement pour l’analyse de données de comptage. Ce package repose sur les modèles PLN et PLN-PCA \[@PLNPCA; @PLNmodels\], qui font l’hypothèse d’une couche latente gaussienne. Grâce aux lois a posteriori, il permet d’extraire cette couche gaussienne et d’effectuer une ACP probabiliste adaptée aux données de comptage. Le package est accompagné d’un ensemble d’outils de visualisation pour faciliter l’interprétation des résultats.

- Le package: <https://pypi.org/project/pyPLNmodels/>

- Le github: <https://github.com/PLN-team/pyPLNmodels>

Utiliser le Getting_started.ipynb et c’est parti !

## Atelier

Cette séance sous forme d’atelier a pour objectif de tester différents packages permettant de traiter des données de présence/absence ou d’abondance multivariées notamment en écologie, comme (liste non exhaustive)

#### Packages R

- `{gllvm}` : [Generalized Linear Latent Variable Models package](https://cran.r-project.org/package=gllvm)

Le package \[gllvm-package; @gllvm-packageMEE\] utilise l’implémentation d’une méthode variationnelle via `{TMB}` \[@TMB\] ou une méthode de Laplace d’approximation pour l’estimation. Pour plus de détails, allez voir @Niku2021; @Niku2019.

- `{Hmsc}` : [Hierarchical Modelling of Species Communities (HMSC)](https://cran.r-project.org/package=Hmsc)

is a model-based approach for analyzing community ecological data \[@Hmsc\] (Ovaskainen et a.2017a).

#### Données Présence/Absence

Nous aurons au moins un jeu de données à disposition du type présence de différentes espèces de plantes sur différentes périodes sur différentes sites, accompagnées de covariables définissant le site.

Nous pourrons utiliser les données exemples du chapitre [Modèles à facteurs latents, un outil de réduction de dimension pour les modèles de distribution d’espèce joints](https://oliviergimenez.github.io/code_livre_variables_cachees/bystrova.html) à récupérer dans [ici](https://github.com/oliviergimenez/code_livre_variables_cachees/tree/master/dat)

#### Données pieds d’arbre

Données publiées [sur zenodo](https://zenodo.org/record/3770339)

[Données pieds d’arbre 2009-2012](../../post/multivariatedata/dataPiedsArbres_2009_2012.Rdata) [Données pieds d’arbre 2014-2018](../../post/multivariatedata/dataPiedsArbres_2014_2018.Rdata)

## References
