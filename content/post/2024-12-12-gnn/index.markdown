---
title: Analyser des réseaux de neurones graphiques avec `pytorch Geometric`
author: State of the R
date: '2024-12-02'
slug: pytorchgeometric
categories: ["HappyR", "workshop"]
tags: ["torch", "python", "gNN", "pytorch", "graph"]
subtitle: ''
summary: ''
authors: [StateOftheR]
lastmod: '2024-12-02T16:04:01+01:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

Lors de cet atelier, Pierre Barbillon et Emré Anakok nous ont présenté les réseaux de neurones graphiques puis leur implémentation avec `pytorch geometric`.

## Aide à l'installation

[Pour l'installation de Python et la création d'environnement pour ceux qui n'ont pas l'habitude de Python](<https://stateofther.github.io/finistR2024/python_practice.html>)

### Pré-requis

Liste des packages requis et exemple de création d'environnement avec `conda`

```{bash}
#| eval: false
#| echo: false
conda create --name happyrgnn python=3.11 pip
conda activate happyrgnn
pip install numpy torch matplotlib networkx torch-geometric pandas
scikit-learn
conda deactivate
conda env list
```

## Support de présentations

[Slides](../../post/gNN/GNN_SoTR.pdf).

## Notebooks

Ils ont mis à notre disposition différents notebooks permettant d'effectuer différentes tâches (apprentissage semi-supervisé, prédiction de liens, ...) à partir de différents jeux de données simulés.


## Quelques références

-   [introduction to GNN](https://distill.pub/2021/gnn-intro/)  
-   [understanding gnns](https://distill.pub/2021/understanding-gnns/)
-   [convolution on graphs](https://distill.pub/2021/understanding-gnns/)  
-   [google colabs for pytorch geometric](https://pytorch-geometric.readthedocs.io/en/latest/get_started/colabs.html)

### pytorch geometric

-   [available convolutions](https://pytorch-geometric.%20readthedocs.io/en/latest/cheatsheet/gnn_cheatsheet.html)
