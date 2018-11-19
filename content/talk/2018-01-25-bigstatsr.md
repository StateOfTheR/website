+++
title = "Efficient analysis of large-scale matrices with two R packages: bigstatsr and bigsnpr"
date = 2019-01-25T00:00:00  # Schedule page publish date.
draft = false

# Talk start and end times.
#   End time can optionally be hidden by prefixing the line with `#`.
time_start = 2019-01-25T14:00:00
# time_end = 2018-09-10T15:00:00

abstract = "R package {bigstatsr} provides a special class of matrix whose data is stored on the disk instead of the RAM, but you can still access the data almost as if it were in memory. It is particularly useful is you have a large matrix to analyze but not enough RAM on your computer. It can still be useful for matrices that fit in your RAM because package {bigstatsr} provides very efficient and parallelized algorithms (have you ever found `cor` or `svd` too slow?). I will present the statistical and helper functions that are provided by package {bigstatsr} for this kind of matrices. R package {bigsnpr}, on top of {bigstatsr}, provides some tools that are specific to the analysis of genetic data. We'll see what I can predict from your DNA using these two packages."
abstract_short = ""
event = "Florian Privé"
event_url = ""
location = "salle ACTIA, AgroParisTech"

# Is this a selected talk? (true/false)
selected = false

# Links (optional).
url_pdf = ""
url_slides = ""
url_video = ""
url_code = "https://github.com/privefl/bigstatsr"

# Does the content use math formatting?
math = true

# Does the content use source code highlighting?
highlight = true

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
[header]
image = ""
caption = ""

+++
