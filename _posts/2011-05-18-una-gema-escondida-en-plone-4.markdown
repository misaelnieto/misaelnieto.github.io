---
title: Una gema escondida en Plone 4
layout: post
categories: Plone
---

Hoy me encontré con una gema escondida en Plone 4. Se trata de la posibilidad
de abrir imágenes en un overlay, pipbox o facebox.

El editor de texto enriquecido de Plone es muy poderoso, pero me hacía falta
una opción para que si un usuario hace click sobre una imágen, esta apareciera
en un overlay, justo como lo hacen algunos formularios.

Investigando un poco, me encontré con la fantástica noticia de que es muy
sencillo hacerlo gracias a [`plone.app.jquerytools`](http://plone.org/products/plone.app.jquerytools/#examples). 
La documentación contiene varios ejemplos y uno de esos se enfoca
principalmente a las imágenes que incrusta el editor de texto enriquecido de
Plone (Que definen 3 diferentes estilos).

El código de JavaScript que activa el overlay es éste:

```js
/*****************
http://plone.org/products/plone.app.jquerytools/#examples
*****************/

jQuery(function ($) {
$('img.image-right, img.image-left, img.image-inline')
    .prepOverlay({
        subtype: 'image',
        urlmatch: '/image_.+$',
        urlreplace: ''
        });

});
```

Y para incluirlo en todas las páginas hay dos maneras:

* Añadir un archivo en la raíz de Plone, usando el ZMI, pegar el código y añadir
la referencia al nuevo archivo en portal_javascript (Tuve problemas con la
compresión y lo quité. Esta es la manera más rápida (te tardas 2 minutos),
pero es la menos recomendable, pues se te olvida que está ahi y no es
replicable. Pero es muy rápido para sitios en línea.

* Añadir el script a un tema de Plone y registrarlo en portal_javascript
mediante GenericSetup. Esto tarda más, pero es la manera adecuada de hacerlo.

Y listo si visitas este sitio directamente (y no mediante un planet o un rss), 
y haces click sobre la imagen que pongo a continuación, verás la magia.
