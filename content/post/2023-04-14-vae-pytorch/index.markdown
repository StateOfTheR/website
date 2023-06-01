---
title: Variational AutoEncoder with PyTorch
author: State of the R
date: '2023-04-14'
slug: vae-pytorch
categories: ["workshop"]
bibliography: biblio.bib
tags: ["Python", "VAE", "PyTorch"]
subtitle: ''
summary: ''
authors: []
lastmod: '2023-06-01T15:56:44+02:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

Hugo Gangloff nous a concocté une séance sur l’utilisation des auto-encodeurs variationnels pour le traitement de données single-cell RNA-Seq en Python avec PyTorch.

Résumé :

Cet atelier Happy R est divisé en trois parties dédiées aux autoencodeurs variationnels (VAE) (Kingma and Welling 2014) pour le traitement de données scRNA-seq. Nous abordons des concepts de base mais également des concepts plus avancés en deuxième partie de session.

1)  Nous débutons par la reproduction pas à pas d’architectures simples de VAE avec comme objectif l’application à l’identification de cellules via une analyse de l’espace latent du modèle (voir par exemple (Zhao et al. 2020))

2)  Nous étudions ensuite le reparametrization trick (Kingma and Welling 2014; Jang, Gu, and Poole 2017), technique de calcul au coeur des modèles de VAE.

3)  Nous codons enfin un Gaussian Mixture VAE, semblable à celui proposé dans (Grønbech et al. 2020).

Le langage de programmation utilisé est Python et la librairie d’apprentissage profond est Pytorch.

## Part 0: Set-up the Python environment

    Create a new Anaconda environment conda create --name VAE_HappyR_2023 python=3.10
    Activate the environment conda activate VAE_HappyR_2023
    Install the required packages pip install torch jupyter jupyter-cache scanpy
    Clone the repository git clone git@forgemia.inra.fr:mia-paris/formations/vae_happyr_2023.git

## Contenu

Le dépôt de l’atelier est sur la forgemia https://forgemia.inra.fr/mia-paris/formations/vae_happyr_2023

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Gronbech2020" class="csl-entry">

Grønbech, Christopher Heje, Maximillian Fornitz Vording, Pascal N Timshel, Casper Kaae Sønderby, Tune H Pers, and Ole Winther. 2020. “<span class="nocase">scVAE: variational auto-encoders for single-cell gene expression data</span>.” *Bioinformatics* 36 (16): 4415–22. <https://doi.org/10.1093/bioinformatics/btaa293>.

</div>

<div id="ref-JangGP17" class="csl-entry">

Jang, Eric, Shixiang Gu, and Ben Poole. 2017. “Categorical Reparameterization with Gumbel-Softmax.” In *5th International Conference on Learning Representations, ICLR 2017, Toulon, France, April 24-26, 2017, Conference Track Proceedings*. OpenReview.net. <https://openreview.net/forum?id=rkE3y85ee>.

</div>

<div id="ref-KingmaWelling2014" class="csl-entry">

Kingma, Diederik P., and Max Welling. 2014. “Auto-Encoding Variational Bayes.” In *2nd International Conference on Learning Representations, ICLR 2014, Banff, AB, Canada, April 14-16, 2014, Conference Track Proceedings*, edited by Yoshua Bengio and Yann LeCun. <http://arxiv.org/abs/1312.6114>.

</div>

<div id="ref-zhao20c" class="csl-entry">

Zhao, He, Piyush Rai, Lan Du, Wray Buntine, Dinh Phung, and Mingyuan Zhou. 2020. “Variational Autoencoders for Sparse and Overdispersed Discrete Data.” In *Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics*, edited by Silvia Chiappa and Roberto Calandra, 108:1684–94. Proceedings of Machine Learning Research. PMLR. <https://proceedings.mlr.press/v108/zhao20c.html>.

</div>

</div>
