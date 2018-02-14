#! /bin/bash
# Script para crear los accesos a las imágenes de la galería

root="gallery"

echo '---
layout: page
title: "La Mirada"
description: "archive"
active: gallery
header-img: "img/gallery-bg.jpg"
images:' > index.html

# Listado de las galerías, comentar el comando sort para evitar
# el ordenamiento numérico
for dir in `ls -d ./archive/*/ | sed 's/\.\/archive\///g' | sed 's/\///g' | sort -nr`

do
# Index del raiz de la galería
echo " - image_path: /$root/albums/$dir.jpg
   gallery-folder: /$root/$dir/
   gallery-name: $dir
   gallery-date: $dir" >> index.html

# Index de cada galería
echo "---
layout: page
title: \"$dir\"
description: \"$dir\"
active: gallery
header-img: \"img/gallery-bg.jpg\"
album-title: \"$dir\"
images:" > $dir/index.html

# Listado de imágenes
    for imga in `ls archive/$dir/*.{jpg,png,gif,JPG,PNG,GIF}`
    do
        img=$(echo $imga | awk -F "/" '{print $3}')
        name=$(echo $img | awk -F "." '{print $1}')
        echo " - image_path: /$root/archive/$dir/$img
   caption: $name
   mfp-title: $name
   copyright: © Tomás Senabre" >> $dir/index.html
    done
# Cierro el listado de imágenes
echo '---

<html class="no-js" lang="es">
<head>
        <meta content="charset=utf-8">
</head>

    <body>

        <section id="content" role="main">
                <div class="wrapper">
        <br><br>
                        <h2>{{page.album-title}}</h2>


                        <!-- Gallery __-->
                        <div class="gallery masonry-gallery">

{% for image in page.images %}

                                <figure class="gallery-item">
                                        <header class='"'"'gallery-icon'"'"'>

<a href="{{ site.url }}{{ site.baseurl }}{{ image.image_path }}" class="popup" title="{{ image.caption }}" data-caption="{{ image.copyright }}">
<img src="{{ site.url }}{{ site.baseurl }}{{ image.image_path }}"></a>

                                        </header>
                                        <figcaption class='"'"'gallery-caption'"'"'>
                                                <div class="entry-summary">
                                                        <h3>{{image.caption}}</h3>
                                                        <p>{{image.copyright}}</p>
                                                </div>
                                        </figcaption>
                                </figure>

{% endfor %}

                        </div>

                </div><!-- END .wrapper -->
        </section>

<!-- jQuery -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<!-- include image popups -->
<script src="{{ site.baseurl }}/js/jquery.magnific-popup.js"></script>
<script src="{{ site.baseurl }}/js/retina.min.js"></script>
<!-- include Masonry -->
<script src="{{ site.baseurl }}/js/isotope.pkgd.min.js"></script>
<!-- include mousewheel plugins -->
<script src="{{ site.baseurl }}/js/jquery.mousewheel.min.js"></script>
<!-- include carousel plugins -->
<script src="{{ site.baseurl}}/js/jquery.tinycarousel.min.js"></script>
<!-- include svg line drawing plugin -->
<script src="{{ site.baseurl }}/js/jquery.lazylinepainter.min.js"></script>
<!-- include custom script -->
<script src="{{ site.baseurl }}/js/scripts.js"></script>
<!-- Modernizr -->
 <script src="{{ site.baseurl }}/js/modernizr.js"></script>

    <script type="text/javascript">
      $(document).ready(function($) {
        $('"'"'a.popup'"'"').magnificPopup({
          type: '"'"'image'"'"',
          gallery:{
         enabled:true,
         navigateByImgClick: true,
         preload: [0,1] // Will preload 0 - before current, and 1 after the current image
       },
      image: {
         titleSrc: function(item) {
              return item.el.attr('"'"'title'"'"') + '"'"'&nbsp;'"'"' + item.el.attr('"'"'data-caption'"'"');
            }
        }
          // other options
      });
});
    </script>

</body></html>' >> $dir/index.html

done

# Cierro el Index del raiz de la galería
echo '---

<html class="no-js" lang="es">
<head>
        <meta content="charset=utf-8">
    <link rel="stylesheet" href="{{ "/css/selena.css" | prepend: site.baseurl }}">
</head>


    <body class="gallery">

        <section id="content" role="main">
                <div class="wrapper">

                        <h2>{{page.title}}</h2>

                        <!-- Gallery __-->
                        <div class="gallery masonry-gallery">

{% for image in page.images %}

                       <figure class="gallery-item">
                         <figure class="effect-selena">
                                        <header class='"'"'gallery-icon'"'"'>

<a href="{{ site.url }}{{ site.baseurl }}{{ image.gallery-folder }}">
<img src="{{ site.url }}{{ site.baseurl }}{{ image.image_path }}"></a>

                                        </header>
                                        <figcaption class='"'"'gallery-caption'"'"'>
                                                <div class="entry-summary">
                                                        <h3>{{image.gallery-name}}</h3>
                                                        <p>{{image.gallery-date}}</p>
                                                </div>
                                        </figcaption>
                       </figure>
                                </figure>

{% endfor %}

                        </div>

                </div><!-- END .wrapper -->
        </section>


<br>
<h6><p>Image Source: <a href="https://unsplash.com/photos/YOT6kS8YtEA/">Unsplash</a></p></h6>

<!-- jQuery -->

<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="{{ site.baseurl }}/js/retina.min.js"></script>
<!-- include Masonry -->
<script src="{{ site.baseurl }}/js/isotope.pkgd.min.js"></script>
<!-- include mousewheel plugins -->
<script src="{{ site.baseurl }}/js/jquery.mousewheel.min.js"></script>
<!-- include carousel plugins -->
<script src="{{ site.baseurl}}/js/jquery.tinycarousel.min.js"></script>
<!-- include svg line drawing plugin -->
<script src="{{ site.baseurl }}/js/jquery.lazylinepainter.min.js"></script>
<!-- include custom script -->
<script src="{{ site.baseurl }}/js/scripts.js"></script>
<!-- Modernizr -->
 <script src="{{ site.baseurl }}/js/modernizr.js"></script>

</body></html>' >> index.html
