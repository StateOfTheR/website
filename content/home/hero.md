+++
# Hero widget.
widget = "hero"
headless = true  # This file represents a page section.
active = true

title = "State of The R"

# Order that this section will appear in.
weight = 1

[design.background]
  # Apply a background color, gradient, or image.
  # Uncomment (by removing `#`) an option to apply it.
  # Choose a light or dark text color by setting `text_color_light`.
  # Any HTML color name or Hex value is valid.

  # Background color.
  # color = "navy"
  
  # Background gradient.
  gradient_start = "#4bb4e3"
  gradient_end = "#2b94c3"
  
  # Background image.
  image = "headers/bannerSOTR.jpg"  # Name of image in `static/media/`.
  image_darken = 0.1  # Darken the image? Range 0-1 where 0 is transparent and 1 is opaque.
  image_size = "cover"  #  Options are `cover` (default), `contain`, or `actual` size.
  image_position = "center"  # Options include `left`, `center` (default), or `right`.
  image_parallax = true  # Use a fun parallax-like fixed background effect? true/false
  
  # Text color (true=light or false=dark).
  text_color_light = true

[cta]
  url = "mailto:sympa@agroparistech.fr?subject=SUSCRIBE%20stateofther"
  label = "Liste de diffusion"
  icon_pack = "fab"
  icon = "r-project"

[cta_alt]
  url = "#about"
  label = "En savoir plus"  
+++

<span style="text-shadow: none;">
Groupe de chercheurs et d'ingénieurs se réunissant pour approfondir leur savoir-faire, perfectionner la diffusion de leurs méthodes statistiques et échanger autour des dernières innovations de `R` et `RStudio`.</span>

<a href="http://www.github.com/StateOftheR" class="github-button"><script async defer src="https://buttons.github.io/buttons.js"></script> groupe github</a> 
