---
title: Créer un pipeline complet pour en apprentissage automatique avec {tidymodels}
author: State of the R
date: '2023-12-08'
slug: tidymodelspipeline
categories: ["HappyR", "workshop"]
tags: ["R", "tidymodels", "tidyverse", "glmnet", "ranger", "xgboost", "recipes", "parsnip", "finetune", "workflowsets", "rsample", "yardstick", "tune"]
subtitle: ''
summary: ''
authors: []
lastmod: '2024-01-08T09:56:41+01:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

Antoine Bichat et Julie Aubert ont rejoué le tutoriel donné aux [rencontres R 2024](https://rr2023.sciencesconf.org/) pour apprendre à créer un"pipeline" complet pour l'apprentissage automatique avec [`{tidymodels}`](https://www.tidymodels.org/).

## Résumé :

`{Tidymodels}` regroupe un ensemble de packages facilitant l’utilisation de méthodes d’apprentissage statistique (telles que les forêts aléatoires, modèles linéaires bayésien ou non...) dans un cadre unifié et “tidy”. Ce tutoriel montre comment utiliser ces packages pour prétraiter les données, construire, entraîner et évaluer un modèle,  optimiser des hyperparamètres et tout ce qu'il est utile de savoir pour mener de bout en bout un projet d’apprentissage statistique supervisé.

## Pré-requis :

Pour profiter au maximum de ce tutoriel, merci de vérifier que vous avez une version de R >= 4.1 [disponible ici](https://cran.r-project.org), une version récente de [RStudio](https://www.rstudio.com/download) et d'installer au préalable les packages R utiles à l'aide de la commande suivante :



``` r
install.packages(c("tidyverse", "tidymodels", 
                   "glmnet", "ranger", "xgboost", 
                   "finetune", "workflowsets", "corrr", "vip", 
                   "ggforce", "ggrain"))
```

**Lien vers le tutoriel**: <https://abichat.github.io/rr23-tuto-tidymodels/>                   
