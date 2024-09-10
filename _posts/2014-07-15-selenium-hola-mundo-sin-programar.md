---
title: Hola Mundo con Selenium - Una guía básica sin programación
summary: Aprende a realizar tus primeras pruebas automatizadas con Selenium IDE sin necesidad de escribir código.
language: es
comments: true
published: true
categories: 
    - Technology
tags:
    - Web
    - Devops
    - Programación
    - Selenium
    - Testing
image: /media/unsplash/spacex--p-KCm6xB9I-unsplash.jpg
hero_svg: /assets/img/heroes/happy-intersection.svg
date: 2014-07-15
---

## Introducción a Selenium: ¡Hola Mundo sin código!

¿Quieres adentrarte en el mundo de las pruebas automatizadas pero no sabes por dónde empezar? ¡Selenium IDE es la herramienta perfecta para ti! En esta guía, te mostraremos cómo crear tu primera prueba automatizada de forma sencilla y rápida, sin necesidad de escribir una sola línea de código.

La primera vez que quise entrarle a [Selenium](http://www.seleniumhq.org/) no
entendi cómo funcionaba ni cómo echarlo a andar; además tenía muy poco tiempo
disponible para aprender los detalles. En esta segunda oportunidad me propuse
un objetivo muy pequeño y fácil de lograr, pero muy didáctico: Hacer que
Selenium verifique que una página tenga el texto **Hola Mundo** como título Ya estas listo? ¡Manos a la obra!

### Preparando el entorno

Primero necesitamos una **página web de prueba:**. Asi que crearemos un HTML que cuando lo carges con el navegador diga `Hola Mundo`. Para lograr esi tienes que crear un simple archivo HTML llamado `index.html` con el siguiente contenido:

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

**¿Que, pero por qué un servidor web?**

Selenium te ayuda a probar páginas web y una página web puede
ser un HTML estático o una aplicación hecha en Ruby on Rails,
Django, Drupal o lo que se antoje. El servidor web no importa
tampoco, puede ser NGinx, Apache, IIS, amazon S3, Dropbox o el
que tu quieras. Si ya tienes un servidor web o un sitio web
entonces sube el hola mundo en HTML a tu sitio. Si no tienes
dónde, no te preocupes, si tienes Python o PHP la buena noticia
es que puedes arrancar un servidor web con una sóla línea de
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

Para probar si funciona abre el navegador y abre este URL:
<http://localhost:8000> Se debería ver algo así:

![Firefox probando el servidor web improvisado](/media/Screenshot_from_2014_07_15_16_42_54.png)

¿Qué tal? Este sitio es [sencillo, fácil, responsivo y minimalista](https://motherfuckingwebsite.com/) ...

Antes de que pases a la siguiente sección deberás poder acceder
al Hola mundo desde tu navegador. (Nota, tambien podrias usar
`file://` pero no lo he probado, te queda a ti de tarea a manera
de ejercicio).

## Pruebas con Selenium IDE

El siguiente paso es instalar [Selenium
IDE](http://docs.seleniumhq.org/projects/ide/) en Firefox.
Selenium IDE es un complemento de Firefox, asi que te pedirá
permiso para instalarlo. Tal vez tengas que reiniciar Firefox.

Abre la página de prueba y lanza el IDE mediante el menú
**Herramientas -> Selenium IDE**. Mi Firefox esta en inglés, pero no
debería cambiar demasiado para español u otro idioma.

![Cómo lanzar el IDE de Selenium](/media/Screenshot_from_2014_07_18_16_31_44.png)

**Nota**: Si la barra de menu esta oculta, presiona ALT para que aparezca.

La ventana de selenium se ve así

![La ventana del IDE de Selenium](/media/Screenshot_from_2014_07_18_16_45_02.png)

**Nota**: Si tienes suficiente espacio en pantalla, pon la ventana de firefox y
la del IDE de Selenium lado a lado para que trabajes más cómodo.

Cuando inicia el IDE el URL base esta puesto como <http://bugs.launchapd.net>,
deberás cambiarlo a <http://localhost:8000>. En la imagen anterior esta señalado
con el número 1 encerrado en un círculo rojo.

Ahora, abre la ventana de Firefox donde cargaste la página de *Hola Mundo*.
Selecciona el texto y presiona el botón derecho del mouse para sacar el menú
contextual. Luego selecciona la opcion **assertText** que está de color naranja.

![Selecciona la opcion `assertText` que está de color naranja.](/media/Screenshot_from_2014_07_18_17_16_20_0.png)

Cuando instalaste el IDE se añadieron algunas opciones en los menúes
contextuales que te ayudarán a hacer más fácil el proceso de programación de
pruebas. Una vez que hayas hecho click en la opción `AssertText css=h1 Hola Mundo`
la ventana del IDE registrará esta acción como la primera prueba de la
página.

![La primera prueba de Selenium - mira el área delimitada por el rectángulo verde-](/media/Screenshot_from_2014_07_18_17_16_45_0.png).

Presiona cualquiera de los botones verdes para iniciar/reiniciar la prueba automática.

![Botones para iniciar la prueba. Presiona cualquiera de los dos botones](/media/Screenshot_from_2014_07_21_08_35_17.png)

Cuando inicies la prueba, veras que se abre una nueva ventana de firefox (a
veces se usa una de las que ya estan abiertas), se abre el sitio
`http://localhost:8000/` y se realiza la prueba (verificar que el título de la
página sea "_Hola mundo_").

Ahora es momento de guardar las pruebas al disco duro. Deberás guardar 2
archivos, uno que contiene la suite de pruebas (`Test suite`) y otro con el
caso de prueba (`Test Case`). Una suite de pruebas puede contener muchos casos
de prueba. Selecciona el siguiente menú: `File-> Save Test Suite`. En este
momento se pedirá que des primero el nombre del caso de prueba (`MiPrueba.html`)
y posteriormente el nombre de la suite de pruebas (`MiSuitedePruebas.html`).

Yo guarde el archivo dentro de un subdirectorio (Llamado `Pruebas`) dentro del
directorio donde guarde el HTML de *hola mundo*. La cosa queda así:

```
.
├── index.html
└── Pruebas
    ├── HolaMundo.html
    └── MiSuitedePruebas.html

1 directory, 3 files
```

¿Cuál es la diferencia entre una suite de pruebas y un caso de prueba? La
suite de pruebas agrupa a casos de prueba y estas últimas agrupan varias
pruebas individuales.

## Ejecución de pruebas con Selenium Server

Descarga [Selenium Server de este link](http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar).

La última version de Selium Server(SS) al momento de escribir esta guía(Julio
del 2014) era la versión 2.42.2. Tal vez quieras pasar por la página de
[descargas de Selenium](http://www.seleniumhq.org/download/) para averiguar 
si hay alguna nueva versión disponible.

La descarga es un archivo `.jar` que puede ser invocado directamente desde la
consola:

```bash
java -jar selenium-server-standalone-2.42.2.jar
```

Si ejecutas el comando anterior, se lanzará el servidor de selenium en la
consola, pero no vamos a hacer uso de ese modo. SS tiene varias opciones que
se pueden configurar y ajustar. Para ver una lista completa de estas opciones
bastará con poner un `-h` como parámetro a SS.

```bash
java -jar selenium-server-standalone-2.42.2.jar -h
```

De todas esas opciones, sólo me interesa la opción `-htmlSuite`. Esta opción
hará que SS ejecute solamente una suite de pruebas (tambien llamada Suite
Selenese o HTML Selenese) usando Firefox.

Se requerirán 4 parámetros.

1. El primer parámetro es una cadena que especifica el navegador a usar; para
este ejemplo usaremos "`*firefox`"

2. El segundo parámetro es la URL de inicio (Start URL); para este ejemplo
será: `http://localhost:8000`.

    **NOTA**: No olvides arrancar el servidor con la página de prueba. O si ya
    tienes uno configurado entonces usa la url de tu servidor.

3. El tercer parámetro  es la ruta absoluta a la suite de pruebas; para este
ejemplo será: `./Pruebas/MiSuitedePruebas.html`
    **NOTA**: Estoy usando la ruta relativa al directorio actual.

4. El cuarto y último parámetro es la ruta a un archivo HTML donde se
escribirán los resultados de la prueba; en este caso será: `./Resultados.html`

El comando que deberás correr es algo parecido a esto:

```bash
java -jar ./selenium-server-standalone-2.42.2.jar -htmlSuite "*firefox" "http://localhost:8000" ./Pruebas/MiSuitedePruebas.html ./Resultados.html
```

Ejecútalo. Pronto aparecerán dos ventanas de Firefox, una de selenium y otra
con la página de "`Hola Mundo`". Como la prueba es tan pequeña, las ventanas
aparecerán y desaparecerán muy rápido. No te alarmes. En la consola podrás ver
lo que ha ocurrido:

```bash
$ java -jar ./selenium-server-standalone-2.42.2.jar -htmlSuite "*firefox" "http://localhost:8000" ./Pruebas/MiSuitedePruebas.html ./Resultados.html -singleWindow
Jul 21, 2014 11:16:03 AM org.openqa.grid.selenium.GridLauncher main
INFO: Launching a standalone server
11:16:03.167 INFO - Java: Oracle Corporation 25.5-b02
11:16:03.168 INFO - OS: Linux 3.15.4-200.fc20.x86_64 amd64
11:16:03.173 INFO - v2.42.2, with Core v2.42.2. Built from revision 6a6995d
11:16:03.224 INFO - Default driver org.openqa.selenium.ie.InternetExplorerDriver registration is skipped: registration capabilities Capabilities [{ensureCleanSession=true, browserName=internet explorer, version=, platform=WINDOWS}] does not match with current platform: LINUX
11:16:03.246 INFO - RemoteWebDriver instances should connect to: http://127.0.0.1:4444/wd/hub
11:16:03.246 INFO - Version Jetty/5.1.x
11:16:03.247 INFO - Started HttpContext[/selenium-server,/selenium-server]
11:16:03.259 INFO - Started org.openqa.jetty.jetty.servlet.ServletHandler@725bef66
11:16:03.259 INFO - Started HttpContext[/wd,/wd]
11:16:03.259 INFO - Started HttpContext[/selenium-server/driver,/selenium-server/driver]
11:16:03.259 INFO - Started HttpContext[/,/]
11:16:03.262 INFO - Started SocketListener on 0.0.0.0:4444
11:16:03.262 INFO - Started org.openqa.jetty.jetty.Server@30dae81
11:16:03.278 WARN - Caution: '/usr/bin/firefox': file is a script file, not a real executable.  The browser environment is no longer fully under RC control
jar:file:/home/nnieto/Code/Varios/HolaMundo%20con%20Selenium/selenium-server-standalone-2.42.2.jar!/customProfileDirCUSTFFCHROME
11:16:03.343 INFO - Preparing Firefox profile...
11:16:04.245 INFO - Launching Firefox...
11:16:04.840 INFO - Checking Resource aliases
11:16:05.875 INFO - Checking Resource aliases
11:16:05.875 INFO - Received posted results
HolaMundo.html
<a href="HolaMundo.html">Hola Mundo</a></td></tr>
</tbody></table>


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

Abre `Resultados.html`. Deberás poder ver algo asi:

![Resultado de la suite de pruebas](/media/Screenshot_from_2014_07_21_11_22_27.png)

He aquí el resultado:

```
| -------------- | -----|
| numTestTotal:  | + 1  |        |
| numTestPasses: | + 1  |
```

## Recapitulando

Lo que hicimos fue:

* Escribimos una página HTML con el texto "Hola Mundo"  y la montamos en un
servidor web (PHP o Python, pero bien pudo haber sido nginx o Apache).

* Instalamos Selenium IDE y creamos la primera y única prueba dentro de un
 caso de prueba (`Test case`), dentro de una suite de Pruebas.

* Descargamos Selenium Server y corrimos la prueba.

* Finalmente revisamos los resultados.

Espero que esta guía sea de utilidad para alguien más.
