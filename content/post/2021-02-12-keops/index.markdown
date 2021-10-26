---
title: keops
author: State of the R
date: '2021-02-12'
slug: keops
categories: ["workshop"]
tags: ["optimizeR","optimisation","SPAMS","benchopt","KeOps", "RKeops"]
subtitle: ''
summary: ''
authors: []
lastmod: '2021-10-26T16:22:45+02:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

[Ghislain Durif](https://gdurif.perso.math.cnrs.fr/) a animé un premier atelier pratique autour des problèmes de l'optimisation et de leur résolution (résumé ci-dessous) le 12 février 2020.

Les instructions pour installer les différents packages pour les tutoriels sont disponibles [ici] (https://github.com/gdurif/optimizeR#requirements-for-the-tutorials). Il y a 3 fichiers différents : un pour chaque partie.

Les packages **{SPAMS}** et **{KeOps}** ne sont pas fonctionnels sous Windows.
On vous recommande d'installer et d'utiliser WSL (Windows Subsystem for Linux) et d'y installer une distribution Linux quelconque (Ubuntu au hasard), tout est très bien détaillé [ici] (https://lecrabeinfo.net/installer-wsl-windows-subsystem-for-linux-sur-windows-10.html).

Description de l'atelier :

During this second part, we will focus on KeOps (https://www.kernel-operations.io), a library to run seamless Kernel Operations on GPU (but not only), with possible auto-differentiation and without memory overflows. It provides routines to compute generic reductions of large 2d arrays whose entries are given by a mathematical formula. Using a C++/CUDA-based implementation with GPU support, it combines a tiled reduction scheme with an automatic differentiation engine. Relying on online map-reduce schemes, it is perfectly suited to the scalable computation of kernel dot products and the associated gradients, even when the full kernel matrix does not fit into the GPU memory.

**KeOps** is all about breaking through this memory bottleneck and making GPU power available for seamless standard mathematical routine computations. As of mid-2020, this effort has been mostly restricted to the operations needed to implement Convolutional Neural Networks: linear algebra routines and convolutions on grids, images and volumes. **KeOps** provides GPU support without the cost of developing a specific CUDA implementation of your custom mathematical operators.

To ensure its verstility, **KeOps** can be used through Matlab, Python (NumPy or PyTorch) and R backends (package **{RKeOps}** available on CRAN).
