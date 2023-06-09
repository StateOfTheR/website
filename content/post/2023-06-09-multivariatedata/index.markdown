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

Bastien Batardière nous présente le package python `{pyPLNmodels}`, conçu spécifiquement pour l’analyse de données de comptage. Ce package repose sur les modèles PLN et PLN-PCA (Chiquet, Mariadassou, and Robin 2018, 2021), qui font l’hypothèse d’une couche latente gaussienne. Grâce aux lois a posteriori, il permet d’extraire cette couche gaussienne et d’effectuer une ACP probabiliste adaptée aux données de comptage. Le package est accompagné d’un ensemble d’outils de visualisation pour faciliter l’interprétation des résultats.

- Le package: <https://pypi.org/project/pyPLNmodels/>

- Le github: <https://github.com/PLN-team/pyPLNmodels>

Utilisez le Getting_started.ipynb et c’est parti !

Le support introductif est [ici](../../post/multivariatedata/main.pdf)

## Atelier

Cette séance sous forme d’atelier a pour objectif de tester différents packages permettant de traiter des données de présence/absence ou d’abondance multivariées notamment en écologie, comme (liste non exhaustive)

#### Packages R

- `{gllvm}` : [Generalized Linear Latent Variable Models package](https://cran.r-project.org/package=gllvm)

Le package \[gllvm-package; Niku, Hui, et al. (2019)\] utilise l’implémentation d’une méthode variationnelle via `{TMB}` (Kristensen et al. 2016) ou une méthode de Laplace d’approximation pour l’estimation. Pour plus de détails, allez voir Niku et al. (2021); Niku, Brooks, et al. (2019).

- `{Hmsc}` : [Hierarchical Modelling of Species Communities (HMSC)](https://cran.r-project.org/package=Hmsc)

is a model-based approach for analyzing community ecological data (Tikhonov et al. 2022) (Ovaskainen et a.2017a).

#### Données Présence/Absence

Nous aurons au moins un jeu de données à disposition du type présence de différentes espèces de plantes sur différentes périodes sur différentes sites, accompagnées de covariables définissant le site.

Nous pourrons utiliser les données exemples du chapitre [Modèles à facteurs latents, un outil de réduction de dimension pour les modèles de distribution d’espèce joints](https://oliviergimenez.github.io/code_livre_variables_cachees/bystrova.html) à récupérer dans [ici](https://github.com/oliviergimenez/code_livre_variables_cachees/tree/master/dat)

#### Données pieds d’arbre

Données publiées [sur zenodo](https://zenodo.org/record/3770339)

[Données pieds d’arbre 2009-2012](../../post/multivariatedata/dataPiedsArbres_2009_2012.Rdata) [Données pieds d’arbre 2014-2018](../../post/multivariatedata/dataPiedsArbres_2014_2018.Rdata)

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-PLNPCA" class="csl-entry">

Chiquet, Julien, Mahendra Mariadassou, and Stéphane Robin. 2018. “Variational Inference for Probabilistic Poisson PCA.” *The Annals of Applied Statistics* 12: 2674–98. <https://projecteuclid.org/journals/annals-of-applied-statistics/volume-12/issue-4/Variational-inference-for-probabilistic-Poisson-PCA/10.1214/18-AOAS1177.full>.

</div>

<div id="ref-PLNmodels" class="csl-entry">

———. 2021. “The Poisson-Lognormal Model as a Versatile Framework for the Joint Analysis of Species Abundances.” *Frontiers in Ecology and Evolution*. <https://doi.org/10.3389/fevo.2021.588292>.

</div>

<div id="ref-TMB" class="csl-entry">

Kristensen, Kasper, Anders Nielsen, Casper W. Berg, Hans Skaug, and Bradley M. Bell. 2016. “TMB: Automatic Differentiation and Laplace Approximation.” *Journal of Statistical Software* 70 (5): 1–21. <https://doi.org/10.18637/jss.v070.i05>.

</div>

<div id="ref-Niku2019" class="csl-entry">

Niku, Jenni, Wesley Brooks, Riki Herliansyah, Francis K. C. Hui, Sara Taskinen, and David I. Warton. 2019. “Efficient Estimation of Generalized Linear Latent Variable Models.” *PLoS ONE* 14 (May). <https://doi.org/10.1371/journal.pone.0216129>.

</div>

<div id="ref-gllvm-packageMEE" class="csl-entry">

Niku, Jenni, Francis K. C. Hui, Sara Taskinen, and David I. Warton. 2019. “Gllvm - Fast Analysis of Multivariate Abundance Data with Generalized Linear Latent Variable Models in r.” *Methods in Ecology and Evolution* 10: 2173–82.

</div>

<div id="ref-Niku2021" class="csl-entry">

———. 2021. “Analyzing Environmental-Trait Interactions in Ecological Communities with Fourth-Corner Latent Variable Models.” *Environmetrics* 32: 1–17.

</div>

<div id="ref-Hmsc" class="csl-entry">

Tikhonov, Gleb, Otso Ovaskainen, Jari Oksanen, Melinda de Jonge, Oystein Opedal, and Tad Dallas. 2022. *Hmsc: Hierarchical Model of Species Communities*. <https://CRAN.R-project.org/package=Hmsc>.

</div>

</div>
