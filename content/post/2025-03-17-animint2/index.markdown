---
title: animint2 dans R pour les graphiques interactifs
author: State of the R
date: '2025-03-17'
slug: animint2
categories: ["HappyR", "workshop"]
tags: ["animint2", "interactive graphics", "ggplot2"]
subtitle: ''
summary: ''
authors: [StateOftheR]
lastmod: '2025-03-17T17:11:28+01:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

Dans cet atelier, [Toby Dylan Hocking](http://tdhock.github.io/), Professeur Agrégé, UdeS Département d’Informatique nous a présenté
le package R [`{animint2}`](https://github.com/animint/animint2).

### Résumé : 
Dans la visualisation de données, les graphiques interactifs permettent de cliquer sur des éléments d’un graphique, 
pour ensuite changer ce qui est affiché dans un autre graphique. Ils sont utiles pour l’enseignement et la recherche,
mais ils sont souvent difficiles à créer. Ici, je propose le package R `{animint2}` pour la création rapide des graphiques interactifs, 
en utilisant la méthode “grammaire de graphiques” qui a été popularisé par `{ggplot2}` pour les graphiques non interactifs. 
`{animint2}` est un logiciel mature, développé depuis 2013, disponible sur CRAN, avec beaucoup de documentation. 
Dans cette présentation je vais expliquer comment vous pouvez utiliser `{animint2}` pour créer et partager les graphiques interactifs.

### Et tous les liens utiles :

**Diapos** : <https://docs.google.com/presentation/d/1QDwo9x4OM7UKAXffJrny6nSfeytFR0kO5NB-NQEspcE>\
**Article** : <https://doi.org/10.1080/10618600.2018.1513367>\
**Package R** : <https://github.com/animint/animint2>\
**Documentation** : <https://rcdata.nau.edu/genomic-ml/animint2-manual/Ch02-ggplot2.html>\
**Exemples** : <https://animint.github.io/gallery/>\
**Installation** : sous R version >= 3.5.0


``` r
install.packages("animint2")
```
