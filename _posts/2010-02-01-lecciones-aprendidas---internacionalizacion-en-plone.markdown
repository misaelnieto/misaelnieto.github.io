---
title: Lecciones aprendidas - internacionalización en Plone
layout: post
categories: Programacion Plone
---

## Intro

Este es un resúmen de lo que he aprendido acerca de cómo se hacen las
traducciones tanto para productos de terceros, mis propios productos y hasta
completar o cambiar algunas traducciones del mismo plone.

En este documento intento concentrar lo poco que he aprendido acerca del
proceso de internacionalización en productos en Plone.

## Placeless Translation Service

El componente de software encargado de administrar todas las traducciones de
las docenas de diferentes paquetes o huevos que componen Plone se llama
Placeless Translation Service. Se encuentra dentro del Panel de control de
Zope (No de Plone). Por ejemplo :
`http://localhost:8080/Control_Panel/TranslationService/manage_main`

Encuentro varios casos en la que es necesario tomar ventaja de la maquinaria
de traducción de Plone:

1. Se ha integrado un CMS Plone con productos de terceros y alguno de esos productos no tiene traducción al español.
2. Alguno de los productos tiene traducción deficiente o incompleta. Por deficiente quiero decir que lo que ya está traducido expresa conceptos muy técnicos, rebuscados o abstractos que hacen que la experiencia del usuario sea difícil.
3. Partes de plone no están traducidas o la traducción no se ajusta a las necesidades del usuario final.

También puedo listar, ahora de manera mas técnica, los casos de traducción:

* Traducir mensajes de las plantillas de Plone
* Traducir mensajes de archivos de python (Restricted Python)
* Traducir mensajes de archivos de python
    - Schemas y Archetypes
    - Todo lo demás
* Traducir ZCML
    - User actions
    - Archetypes
    - Workflows

Lo que aprendí en [este post](http://maurits.vanrees.org/weblog/archive/2007/09/i18n-locales-and-plone-3.0)
de [Maurits van Rees](http://maurits.vanrees.org/) es el por qué se
usan los directorios **i18n** y **locales** y cuál es la diferencia entre usar uno u
otro. Después de leer esto presento mis 2 centavos con los scripts que uso
para mantener múltiples idiomas de las traducciones.

## Internacionalización en iServices

En iServices nos dedicamos principalmente al e-Learning. Hemos escogido a
Python como nuestra plataforma de desarrollo. Plone es usado como la base para
el LCMS eduintelligent y hay planes para liberarlo al mundo pero aún hay mucho
código que depurar y mejorar antes de liberarlo.

Por lo que he visto, la manera de añadir traducciones a un determinado
producto es, a groso modo:

* Identificar y marcar las cadenas candidatas a traducción. El lenguaje que se usa en código fuente es inglés y después se traduce al español, que es el idioma que maneja la vasta mayoría de nuestros clientes.
* Se usó un script para extraer las cadenas de traducción por primera vez, y después se fueron añadiendo y manteniendo a mano.
* Hay muchas veces que se escribe contenido y/o mensajes en español y las cadenas no se marcan para traducción o símplemente no se traducen. No estoy condenando, yo mismo lo he hecho ante la presión de las fechas de entrega o simplemente por que el programador fué perezoso o por alguna extraña razón, a Plone o a Zope, no le dió la gana tomar las traducciones.

## Haciendo uso de i18ndude

`i18ndude` es la herramienta preferida para extraer cadenas de traducción de
los productos de plone (de terceros o propios). Se puede instalar a nivel de
sistema o mediante buildout. Aquí muestro una receta para usar `i18ndude` desde
buildout:

```ini
[buildout]
parts =
    ...
    i18ndude

...

[i18ndude]
recipe = zc.recipe.egg
eggs = i18ndude
```

Al añadir lo de arriba a `buildout.cfg` y después de ejecutar `bin/buildout`,
encontraremos la orden `bin/i18ndude` lista para ser usada y de manera
independiente del sistema.

Ahora, para poder usar i18ndude, dentro de nuestros productos, modifiqué un
script que tomé de `p4a.video`. Luce así:

```bash
#!/bin/bash 

DOMAIN="edutrainingcenter"
DOMAIN_PLONE="plone"
I18NDUDE=../../bin/i18ndude
# If you want to add another language create folders and empty file:
#   mkdir -p locales/<lang_code>/LC_MESSAGES
#   touch locales/<lang_code>/LC_MESSAGES/$DOMAIN.po
# and run this script
# Example: locales/hu/LC_MESSAGES/$DOMAIN.po

touch locales/$DOMAIN.pot
$I18NDUDE rebuild-pot --pot locales/$DOMAIN.pot --create $DOMAIN ./
$I18NDUDE rebuild-pot --pot locales/$DOMAIN-$DOMAIN_PLONE.pot --create $DOMAIN_PLONE ./

# sync all locales
find locales -depth -type d   \
     | grep -v .svn \
     | grep -v LC_MESSAGES \
     | sed -e "s/locales\/\(.*\)$/\1/" \
     | xargs -I % $I18NDUDE sync --pot locales/$DOMAIN.pot locales/%/LC_MESSAGES/$DOMAIN.po

# sync all locales
find locales -depth -type d   \
     | grep -v .svn \
     | grep -v LC_MESSAGES \
     | sed -e "s/locales\/\(.*\)$/\1/" \
     | xargs -I % $I18NDUDE sync --pot locales/$DOMAIN-$DOMAIN_PLONE.pot locales/%/LC_MESSAGES/$DOMAIN-$DOMAIN_PLONE.po
```

## Diferentes datos (sin orden aparente)

Aquí agrupo diferentes datos que he encontrado que estan relacionados con este
tema, pero que no he encontrado alguna forma de estructurar.

### El origen de la directiva registerTransations

 El origen de la directiva:
```xml
<i18n:registerTranslations directory="locales" />
```
Probablemente viene de aqui:

<https://mail.zope.org/pipermail/zope3-dev/2006-May/019494.html>

### Notas de internacionalización con PTS en el wiki de zope

Aquí: <http://wiki.zope.org/zope2/HowToInternationaliseWithPTS>P

### Problema al traducir actions.xml

Me puse a traducir `actions.xml` que puse dentro de un tema. Pero lo primero que
ocurrió es que habia fallos al instalar el tema. Al final del traceback
teniamos esto:

```
BadRequest: The property i18n_domain does not exist
```

Esto fue por que al añadir el soporte de internacionalizacion, especifique el
dominio en el sitio equivocado. Osea que fue así:

```xml
 <object name="user" meta_type="CMF Action Category"
         i18n:domain="iservicestheme.domain">
  <property name="title"></property>
  <object name="perfil" meta_type="CMF Action" >
   <property name="title" i18n:translate="">Profile</property>
   <property name="description" i18n:translate="">Access to my profile</property>
   <property name="url_expr">string:${member/absolute_url}</property>
   <property name="icon_expr"></property>
   <property name="available_expr">python:member is not None</property>
   <property name="permissions"/>
   <property name="visible">True</property>
  </object>
</object>
```

Pero la manera correcta es así:

```xml
 <object name="user" meta_type="CMF Action Category">
  <property name="title"></property>
  <object name="perfil" meta_type="CMF Action" i18n:domain="iservicestheme.domain">
   <property name="title" i18n:translate="">Profile</property>
   <property name="description" i18n:translate="">Access to my profile</property>
   <property name="url_expr">string:${member/absolute_url}</property>
   <property name="icon_expr"></property>
   <property name="available_expr">python:member is not None</property>
   <property name="permissions"/>
   <property name="visible">True</property>
  </object>
</object>
```

Y la solucion la pude encontrar gracias a esta página:

<http://banyan.usc.edu/log/plone-old/plone-logs>

Eso es todo
