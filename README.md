---
editor_options: 
  markdown: 
    wrap: 72
---

# Le dépôt du site web de notre groupe State of the R

<https://stateofther.netlify.app>

[![Netlify
Status](https://api.netlify.com/api/v1/badges/72cec766-75ad-441d-979d-93283f8ed87f/deploy-status)](https://app.netlify.com/sites/stateofther/deploys)

## Notes pour la mise à jour du site, ajout d'un post

-   Aller dans le répertoire website/

-   Ouvrir le .Rprojet

-   Créer un nouveau post

`blogdown::new_post(title = "optimizer",                                        ext = '.Rmarkdown',                                       subdir = "post")`

-   Faire ses modifications dans le Markdown puis construire le .rmd

-   On peut changer le titre et mettre un long titre avec espace ...
    `blogdown::build_site(build_rmd = 'content/post/2021-02-12-keops/index.Rmarkdown')`

-   Verifier que tout est ok. `blogdown::check_site()`

-   Construire le site `blogdown::build_site(build_rmd = 'timestamp')`

-   Penser à faire ses commit + push

Et dans qqs instants le site sera mis à jour automatiquement.

## Pour l'ajout d'un nouveau bootcamp

- Mettre à jour le fichier `website>content>home>bootcamp.md`
pour ajouter lieu et année

- créer un dossier `finistRAA` dans `website>content>project`

- ajouter dans le dossier la photo de groupe ainsi qu'un fichier `index.md`

## Remarques :

-   Pour lancer un serveur localement `blogdown::serve_site()`

-   pour l'arrêter : `blogdown::stop_server()`

-   Pour récuperer uniquement le code R d'un rmarkdown: `knit::purl()`
