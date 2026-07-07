---
title: MLOps pour la reproductibilité et la traçabilité des expériences d’apprentissage
author: State of the R
date: '2026-07-07'
slug: mlops
categories: ["HappyR", "workshop"]
tags: ["Python", "uv", "Hydra", "Optuna", "MLflow"]
subtitle: 'Structurer des projets de recherche avec UV, Hydra, Optuna et MLflow'
summary: ''
authors: []
lastmod: '2026-07-07T09:46:56+02:00'
featured: false
image:
  caption: ''
  focal_point: ''
  preview_only: false
projects: []
---

Garantir la reproductibilité et la traçabilité des expériences constitue un enjeu essentiel dans la conduite de projets de recherche en apprentissage automatique. Les outils issus de l’ingénierie logicielle et de l'apprentissage automatique industriel apportent une réponse efficace à ces besoins grâce à un coût d’intégration réduit et une puissance utilitaire forte.

Dans cet atelier, Joseph Allyndree et Julian Agudelo Acosta (MIA Paris-Saclay) nous ont proposé une introduction pratique à quatre outils largement utilisés dans les workflows modernes de MLOps (Machine Learning Operations) qui s'avèrent adaptés à des projets de recherche en Python : 

- `uv` pour la gestion d’environnement et des dépendances.
- `Hydra` pour la configuration modulaire des expériences.
- `MLflow` pour le suivi et la traçabilité des expérimentations.
- `Optuna` pour l’optimisation des hyperparamètres.


À travers le développement guidé d’un projet simplifié, l'atelier donne l'occasion de comprendre en profondeur la philosophie des outils, structurer une pipeline expérimental (traitement et gestion des versions des ensembles de données, entraînement d’un modèle, optimisation élémentaire des hyperparamètres) et transmettre son projet à un collègue chargé de reproduire les résultats obtenus. 

L'atelier à comme objectif de mettre en évidence la manière dont ces outils facilitent l’organisation du code, la reproductibilité des expériences et la collaboration au sein d’équipes de recherche.

### Pré-requis

Pour suivre l’atelier dans de bonnes conditions, voici ce dont vous avez besoin :

- Connaissances de base en Python
- Un compte Github fonctionnel installé et configuré sur votre ordinateur.
- Capacité à installer des logiciels sur votre compte utilisateur : vous n’avez pas besoin de droits administrateur. Concrètement, vous devez pouvoir installer et exécuter des outils dans votre propre environnement utilisateur.
- Une connexion internet stable, indispensable pour installer les outils et leurs dépendances.

### Supports

L'atelier est basé sur deux dépôts git :
- Le [premier](https://github.com/J-ally/Deep_repro.git) est un exemple général de reproductibilité en apprentissage profond.

- Le [deuxième](https://github.com/J-ally/Deep_repro_LR) reprend un exemple plus concret basé sur la régression linéair

Pour refaire l'atelier, suivre le readMe des dépôts.

Les diapositives générales de présentation sont disponibles [en français ici](../../post/mlops/Slides_Deep_Repro_FR.pdf)
et [in english here](../../post/mlops/Slides_Deep_Repro_EN.pdf)
