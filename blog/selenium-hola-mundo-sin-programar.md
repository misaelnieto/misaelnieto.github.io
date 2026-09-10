---
title: Hola Mundo con Selenium - Una guía básica sin programación
date: 2014-07-15
description: Guía paso a paso para crear tu primera prueba automatizada con Selenium IDE en Firefox sin escribir una sola línea de código, desde el HTML de prueba hasta la ejecución vía Selenium Server.
image: /static/images/posts/selenium-hola-mundo-sin-programar/spacex--p-KCm6xB9I-unsplash.png
tags:
- selenium
- selenium-ide
- testing
- qa
- automatizacion
---

## Introducción a Selenium: ¡Hola Mundo sin código!

¿Quieres adentrarte en el mundo de las pruebas automatizadas pero no sabes por dónde empezar? ¡Selenium IDE es la herramienta perfecta para ti! En esta guía te muestro cómo crear tu primera prueba automatizada de forma sencilla y rápida, sin necesidad de escribir una sola línea de código.

La primera vez que quise entrarle a [Selenium](http://www.seleniumhq.org/) no
entendí cómo funcionaba ni cómo echarlo a andar; además tenía muy poco tiempo
disponible para aprender los detalles. En esta segunda oportunidad me propuse
un objetivo muy pequeño y fácil de lograr, pero muy didáctico: hacer que
Selenium verifique que una página tenga el texto **Hola Mundo** como título. ¿Ya estás listo? ¡Manos a la obra!

### Preparando el entorno

Primero necesitamos una **página web de prueba**. Así que crearemos un HTML que cuando lo cargues con el navegador diga `Hola Mundo`. Para lograr eso tienes que crear un simple archivo HTML llamado `index.html` con el siguiente contenido:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Hola Mundo</title>
</head>
<body>
    <h1>Hola Mundo</h1>
</body>
</html>
```

Ahora necesitamos un servidor web.

**¿Qué, pero por qué un servidor web?**

Selenium te ayuda a probar páginas web y una página web puede
ser un HTML estático o una aplicación hecha en Ruby on Rails,
Django, Drupal o lo que se antoje. El servidor web no importa
tampoco, puede ser nginx, Apache, IIS, Amazon S3, Dropbox o el
que tú quieras. Si ya tienes un servidor web o un sitio web
entonces sube el hola mundo en HTML a tu sitio. Si no tienes
dónde, no te preocupes: si tienes Python o PHP la buena noticia
es que puedes arrancar un servidor web con una sola línea de
comandos.


Desde la terminal o línea de comandos, cambia el directorio al
directorio donde se aloja el HTML de arriba (asumamos que se
llama `index.html`).

Para Python 2.x tienes que ejecutar:

```bash
python -m SimpleHTTPServer 8000
```

Para Python 3.x tienes que ejecutar:

```bash
python3 -m http.server 8000
```

Para PHP:

```bash
php -S localhost:8000
```

Para probar si funciona, abre el navegador y abre esta URL:
<http://localhost:8000>. Se debería ver algo así:

![Firefox probando el servidor web improvisado](/static/images/posts/selenium-hola-mundo-sin-programar/screenshot-from-2014-07-15-16-42-54.png)

¿Qué tal? Este sitio es [sencillo, fácil, responsivo y minimalista](https://motherfuckingwebsite.com/) ...

Antes de que pases a la siguiente sección deberás poder acceder
al Hola mundo desde tu navegador. (Nota: también podrías usar
`file://` pero no lo he probado, te queda a ti como tarea a manera
de ejercicio).

## Pruebas con Selenium IDE

El siguiente paso es instalar [Selenium
IDE](http://docs.seleniumhq.org/projects/ide/) en Firefox.
Selenium IDE es un complemento de Firefox, así que te pedirá
permiso para instalarlo. Tal vez tengas que reiniciar Firefox.

Abre la página de prueba y lanza el IDE mediante el menú
**Herramientas → Selenium IDE**. Mi Firefox está en inglés, pero no
debería cambiar demasiado para español u otro idioma.

![Cómo lanzar el IDE de Selenium](/static/images/posts/selenium-hola-mundo-sin-programar/screenshot-from-2014-07-18-16-31-44.png)

**Nota**: Si la barra de menú está oculta, presiona <kbd>Alt</kbd> para que aparezca.

La ventana de Selenium se ve así:

![La ventana del IDE de Selenium](/static/images/posts/selenium-hola-mundo-sin-programar/screenshot-from-2014-07-18-16-45-02.png)

**Nota**: Si tienes suficiente espacio en pantalla, pon la ventana de Firefox y
la del IDE de Selenium lado a lado para que trabajes más cómodo.

Cuando inicia el IDE, el URL base está puesto como <http://bugs.launchpad.net>,
deberás cambiarlo a <http://localhost:8000>. En la imagen anterior está señalado
con el número 1 encerrado en un círculo rojo.

Ahora, abre la ventana de Firefox donde cargaste la página de *Hola Mundo*.
Selecciona el texto y presiona el botón derecho del mouse para sacar el menú
contextual. Luego selecciona la opción **assertText** que está de color naranja.

![Selecciona la opción `assertText` que está de color naranja.](/static/images/posts/selenium-hola-mundo-sin-programar/screenshot-from-2014-07-18-17-16-20-0.png)

Cuando instalaste el IDE se añadieron algunas opciones en los menús
contextuales que te ayudarán a hacer más fácil el proceso de programación de
pruebas. Una vez que hayas hecho click en la opción `AssertText css=h1 Hola Mundo`
la ventana del IDE registrará esta acción como la primera prueba de la
página.

![La primera prueba de Selenium - mira el área delimitada por el rectángulo verde-](/static/images/posts/selenium-hola-mundo-sin-programar/screenshot-from-2014-07-18-17-16-45-0.png).

Presiona cualquiera de los botones verdes para iniciar/reiniciar la prueba automática.

![Botones para iniciar la prueba. Presiona cualquiera de los dos botones](/static/images/posts/selenium-hola-mundo-sin-programar/screenshot-from-2014-07-21-08-35-17.png)

Cuando inicies la prueba, verás que se abre una nueva ventana de Firefox (a
veces se usa una de las que ya están abiertas), se abre el sitio
`http://localhost:8000/` y se realiza la prueba (verificar que el título de la
página sea "_Hola mundo_").

Ahora es momento de guardar las pruebas al disco duro. Deberás guardar dos
archivos: uno que contiene la *suite* de pruebas (`Test suite`) y otro con el
caso de prueba (`Test Case`). Una *suite* de pruebas puede contener muchos casos
de prueba. Selecciona el siguiente menú: `File → Save Test Suite`. En este
momento se pedirá que des primero el nombre del caso de prueba (`MiPrueba.html`)
y posteriormente el nombre de la *suite* de pruebas (`MiSuitedePruebas.html`).

Yo guardé el archivo dentro de un subdirectorio (llamado `Pruebas`) dentro del
directorio donde guardé el HTML de *hola mundo*. La cosa queda así:

```
.
├── index.html
└── Pruebas
    ├── HolaMundo.html
    └── MiSuitedePruebas.html

1 directory, 3 files
```

¿Cuál es la diferencia entre una *suite* de pruebas y un caso de prueba? La
*suite* de pruebas agrupa a casos de prueba, y estas últimas agrupan varias
pruebas individuales.

## Ejecución de pruebas con Selenium Server

Descarga [Selenium Server de este link](http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar).

La última versión de Selenium Server (SS) al momento de escribir esta guía
(julio de 2014) era la 2.42.2. Tal vez quieras pasar por la página de
[descargas de Selenium](http://www.seleniumhq.org/download/) para averiguar
si hay alguna nueva versión disponible.

La descarga es un archivo `.jar` que puede ser invocado directamente desde la
consola:

```bash
java -jar selenium-server-standalone-2.42.2.jar
```

Si ejecutas el comando anterior, se lanzará el servidor de Selenium en la
consola, pero no vamos a hacer uso de ese modo. SS tiene varias opciones que
se pueden configurar y ajustar. Para ver una lista completa de estas opciones
bastará con poner un `-h` como parámetro a SS.

```bash
java -jar selenium-server-standalone-2.42.2.jar -h
```

De todas esas opciones, sólo me interesa la opción `-htmlSuite`. Esta opción
hará que SS ejecute solamente una *suite* de pruebas (también llamada *Suite
Selenese* o *HTML Selenese*) usando Firefox.

Se requerirán 4 parámetros.

1. El primer parámetro es una cadena que especifica el navegador a usar; para
   este ejemplo usaremos "`*firefox`".

2. El segundo parámetro es la URL de inicio (*Start URL*); para este ejemplo
   será: `http://localhost:8000`.

    **NOTA**: No olvides arrancar el servidor con la página de prueba. O si ya
    tienes uno configurado entonces usa la URL de tu servidor.

3. El tercer parámetro es la ruta absoluta a la *suite* de pruebas; para este
   ejemplo será: `./Pruebas/MiSuitedePruebas.html`.

    **NOTA**: Estoy usando la ruta relativa al directorio actual.

4. El cuarto y último parámetro es la ruta a un archivo HTML donde se
   escribirán los resultados de la prueba; en este caso será: `./Resultados.html`.

El comando que deberás correr es algo parecido a esto:

```bash
java -jar ./selenium-server-standalone-2.42.2.jar -htmlSuite "*firefox" "http://localhost:8000" ./Pruebas/MiSuitedePruebas.html ./Resultados.html
```

Ejecútalo. Pronto aparecerán dos ventanas de Firefox, una de Selenium y otra
con la página de "`Hola Mundo`". Como la prueba es tan pequeña, las ventanas
aparecerán y desaparecerán muy rápido. No te alarmes. En la consola podrás ver
lo que ha ocurrido:

```bash
$ java -jar ./selenium-server-standalone-2.42.2.jar -htmlSuite "*firefox" "http://localhost:8000" ./Pruebas/MiSuitedePruebas.html ./Resultados.html -singleWindow
Jul 21, 2014 11:16:03 AM org.openqa.grid.selenium.GridLauncher main
INFO: Launching a standalone server
...
11:16:06.246 INFO - Killing Firefox...
11:16:06.299 INFO - Shutting down...
```

Y en el directorio actual aparecerá el archivo con los resultados:

```bash
$ tree
.
├── index.html
├── Pruebas
│   ├── HolaMundo.html
│   └── MiSuitedePruebas.html
├── Resultados.html
└── selenium-server-standalone-2.42.2.jar
```

Abre `Resultados.html`. Deberás poder ver algo así:

![Resultado de la suite de pruebas](/static/images/posts/selenium-hola-mundo-sin-programar/screenshot-from-2014-07-21-11-22-27.png)

He aquí el resultado:

```
| -------------- | -----|
| numTestTotal:  | + 1  |
| numTestPasses: | + 1  |
```

## Recapitulando

Lo que hicimos fue:

* Escribimos una página HTML con el texto "Hola Mundo" y la montamos en un
servidor web (PHP o Python, pero bien pudo haber sido nginx o Apache).

* Instalamos Selenium IDE y creamos la primera y única prueba dentro de un
caso de prueba (`Test case`), dentro de una *suite* de pruebas.

* Descargamos Selenium Server y corrimos la prueba.

* Finalmente revisamos los resultados.

Espero que esta guía sea de utilidad para alguien más.

**FIN**
