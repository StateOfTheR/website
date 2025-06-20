---
title: Git, un gentil 'push' vers une meilleure maîtrise
author: State of the R
date: '2025-06-02'
slug: saperlipopette
categories: ["HappyR", "workshop"]
tags: ["saperlipopette", "git"]
subtitle: ''
summary: ''
authors: []
lastmod: '2025-06-02T15:41:27+02:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

Le vendredi 20 juin prochain, nous accueillerons à Palaiseau [Maëlle Salmon](https://masalmon.eu/) pour un nouvel atelier HappyR.

### Résumé : 
Une pratique confiante de Git peut changer la vie professionnelle de toute personne écrivant du code ou de la prose avec R, résultant en un historique utile à parcourir ou à consulter, la possibilité de travailler en parallèle sur différents aspects, etc. En particulier, la meilleure pratique Git est de créer de petits commits atomiques avec des messages informatifs. Pourquoi ? Et comment ?

Apprenez trois raisons pour lesquelles les petits commits Git valent la peine. Découvrez comment les créer de manière réaliste, sans trop de tracas. Pratiquez en toute sécurité avec le paquet R saperlipopette, et partagez vos propres conseils et questions sur Git !

### Pré-requis :
- Connaissances basiques de Git (git add, git commit, git push/pull, création de branches, fusion des branches sur une plate-forme comme GitHub)
- Installation locale de Git. <https://happygitwithr.com/install-git> + <https://happygitwithr.com/hello-git>
- Installation de `{saperlipopette}`. <https://docs.ropensci.org/saperlipopette/>

Astuce pour vérifier et si besoin modifier le choix de son éditeur de git sous R avec `{gert}`:

``` r
# verifier sa configuration
config <- gert::git_config_global()
# verifier si on a une configuration par defaut pour l editeur
config$value[config$name == "core.editor"]
# faire la modification
gert::git_config_global_set(name = "core.editor", value = <QUOI>)
# Par exemple "/usr/bin/positron --wait"
```

Maëlle a prévu deux démos en utilisant [Positron](https://positron.posit.co/), si vous voulez tester aussi vous pouvez l'installer et installer l'extension `GitLens`. Mais les exercices peuvent se faire peu importe dans quelle interface vous utilisez R et Git!


### Intervenante : [Maëlle Salmon](https://masalmon.eu/)

### Diapos : <https://happyr-git.netlify.app/#/>


