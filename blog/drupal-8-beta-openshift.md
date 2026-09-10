---
title: Drupal 8 Beta en OpenShift
date: 2014-09-07
description: 'Instalación del core de Drupal 8 Beta en OpenShift Online v2 para crear un blog gratuito, paso a paso: cuenta, aplicación, CNAME y credenciales.'
tags:
- drupal
- drupal-8
- openshift
- paas
- mysql
- cname
extra:
  deprecated_reason: OpenShift Online v2 cerró en 2016 (reemplazado por v3 basado en Kubernetes/Docker); Drupal 8 EOL noviembre 2021. Ninguno de los dos servicios/existe en esta forma.
  deprecated: true
---

Decidí instalar el core de Drupal 8 Beta en OpenShift para hacerme un blog
gratis.

1. Primero abrí mi cuenta en [OpenShift](https://www.openshift.com/).

2. En el panel de control de OpenShift seleccioné `Applications -> Add Application`.

3. Puse Drupal en el cuadro de búsqueda. Como opciones se encuentra Drupal 7 y
   Drupal 8. Escogí el 8 porque me gusta complicarme la vida.

4. El siguiente paso es escoger el nombre de la aplicación. Elegí `mosaiko`
   (mosaico en esperanto) y dejé todas las demás configuraciones sin tocar. Solo
   faltó presionar el botoncito azul de `Create Application`.

5. Inmediatamente se desactiva el botoncito azul y sale una ruedita de esas
   que dan vueltas para indicarte que «no me molestes hasta que yo te diga que
   ya está listo». Y se tarda unos 5 minutos en crear el *gear* de Drupal.

6. Hasta el momento de escribir este post, no tengo la menor idea de lo que es
   un *gear* pero se parece mucho a un contenedor de Docker.

7. Cuando termina de crear el *gear*, el sitio te muestra un cuadrito verde con
   el nombre de usuario de MySQL, el password y la base de datos de Drupal, que
   es el mismo nombre que la instancia de Drupal: `mosaiko`.

8. Mi sitio Drupal quedó accesible desde `mosaiko-nnieto.rhcloud.com`. Este es
   el alias de la aplicación. Se pueden añadir muchos alias. En la página de
   *overview* de la aplicación se muestra el nombre de dominio que quedó
   configurado (`mosaiko-nnieto.rhcloud.com`).

    A un lado hay un link chiquito que dice *change*. Ahí es donde hay que
    picarle para dar de alta el alias para la aplicación. El alias no es otra
    cosa que el CNAME. Primero configuré el CNAME para que apunte a
    `mozaiko-nnieto.rhcloud.com`, luego puse el nombre de dominio completo en
    *Domain name*; en este caso el nombre es `mozaico.noenieto.com`.

9. Falta una cosa: la contraseña del administrador. Por default es
   `openshift_changeme`. Obviamente le cambié el `user_id`, el password y
   muchas otras cosas, así que no intentes hackear este sitio, ¿ok?

10. Inmediatamente después de entrar a Drupal y cambiar la contraseña del
    admin, me puse a escribir este post. El editor WYSIWYG que trae el Drupal 8
    es una maravilla ¡Me encanta!

Eso es todo. Es mi primera experiencia seria con OpenShift y Drupal 8.

* Foto de Elke Blok, CC BY-NC-SA 2.0

**FIN**
