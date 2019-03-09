---
title: "Efficient analysis of large-scale matrices with two R packages: bigstatsr and bigsnpr"
author: Florian Privé
date: '2019-01-25'
slug: bigstatsr
categories:
  - workshop
tags: 
  - bigstatsr
  - bigsnpr
header:
  caption: ''
  image: ''
---

<img src="https://raw.githubusercontent.com/privefl/bigstatsr/master/bigstatsr.png" align="right" width="100"/>

R package {bigstatsr} provides a special class of matrix whose data is stored on the disk instead of the RAM, but you can still access the data almost as if it were in memory. It is particularly useful is you have a large matrix to analyze but not enough RAM on your computer. It can still be useful for matrices that fit in your RAM because package {bigstatsr} provides very efficient and parallelized algorithms (have you ever found `cor` or `svd` too slow?).

I will present the statistical and helper functions that are provided by package {bigstatsr} for this kind of matrices. R package {bigsnpr}, on top of {bigstatsr}, provides some tools that are specific to the analysis of genetic data. We'll see what I can predict from your DNA using these two packages.

- https://privefl.github.io/bigstatsr/

