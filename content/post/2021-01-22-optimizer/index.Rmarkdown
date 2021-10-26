---
title: optimizer
author: State of the R
date: '2021-01-22'
slug: optimizer
categories: ["workshop"]
tags: ["optimizeR","optimisation","SPAMS","benchopt","KeOps"]
subtitle: ''
summary: ''
authors: []
lastmod: '2021-10-26T16:15:25+02:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

[Ghislain Durif](https://gdurif.perso.math.cnrs.fr/) a animé un premier atelier pratique autour des problèmes de l'optimisation et de leur résolution (résumé ci-dessous) le 22 janvier.

Les instructions pour installer les différents packages pour les tutoriels sont disponibles [ici] (https://github.com/gdurif/optimizeR#requirements-for-the-tutorials). Il y a 3 fichiers différents : un pour chaque partie.

Le package **{BenchOpt}** pourrait fonctionner sous Windows, en utilisant Anaconda. Les packages **{SPAMS}** et **{KeOps}** ne sont pas fonctionnels sous Windows.
On vous recommande d'installer et d'utiliser WSL (Windows Subsystem for Linux) et d'y installer une distribution Linux quelconque (Ubuntu au hasard), tout est très bien détaillé [ici] (https://lecrabeinfo.net/installer-wsl-windows-subsystem-for-linux-sur-windows-10.html).

Description de l'atelier :

The first part will focus on efficiently solving standard statistics or machine learning related optimization problems in R. We will talk about several R packages, in particular the following estimation and benchmark libraries:

- **{SPAMS}** (SPArse Modeling Software, http://spams-devel.gforge.inria.fr), an optimization toolbox that was developed to solve various sparse estimation problems, such as dictionary learning and matrix factorization (NMF, sparse PCA, ...), but also sparse decomposition problems with LARS, coordinate descent, OMP, SOMP, proximal methods, and structured sparse decomposition problems (l1/l2, l1/linf, sparse group lasso, tree-structured regularization, structured sparsity with overlapping groups,...).

- **{BenchOpt}** (https://benchopt.github.io/), a package to simplify, to make more transparent and more reproducible the comparisons of optimization algorithms. It is written in Python but it is available with many programming languages. So far it has been tested with Python, R, Julia and compiled binaries written in C/C++ available via a terminal command. **{BenchOpt}** is used through a command line tools and you can easily add your own solvers. Ultimately the purpose is to be able to run and replicate an optimization benchmark in the most simple and fair way when designing and programming algorithms as well as when reviewing existing methods.

