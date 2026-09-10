---
title: Hola mundo de Flask en IIS 8.5 (Windows 10)
date: 2015-01-19
description: Guía completa para desplegar aplicaciones Flask en IIS 8.5 (Windows 10) usando FastCGI, wfastcgi y Visual Studio con PTVS.
tags:
- flask
- iis
- wfastcgi
- python
- windows
- ptvs
extra:
  deprecated_reason: Visual Studio 2013 y PTVS están obsoletos (PTVS se integró a VS como 'Python development workload'); wfastcgi.py ya no se mantiene y Microsoft recomienda HttpPlatformHandler o ASP.NET Core para Python; IIS 8.5 es de Windows 8/Server 2012 R2.
  deprecated: true
---

## Intro

Tuve el chance de probar Flask y echarlo a funcionar en IIS 8.5.

## Instalar Visual Studio (VS) y Python Tools for Visual Studio

Cuando escribí este artículo, la última versión disponible era Visual Studio
2013 (VS) edición community. Lo descargué de <http://www.visualstudio.com/>.

Después de instalar VS se instala el add-on `Python Tools for Visual Studio
(PTVS)`.

PTVS trae algunas plantillas de proyectos bastante útiles. Una de ellas es la
plantilla para un sitio basado en Flask.

Abre VS y selecciona: `File` → `New` → `Project`. En la ventana de diálogo, en
el panel de la izquierda, selecciona `Installed` → `Templates` → `Python` → `Web` y
finalmente `Flask Web Project` en el panel central. Click `Ok` para crear el
proyecto.

![Nuevo proyecto Flask — click en OK para guardar el proyecto](/static/images/posts/flask-IIS/screenshot-from-2015-01-19-15-51-37.png)

## Instalar Python

Para poder probar el sitio Flask es necesario un intérprete de Python.
Obviamente Windows no trae uno y hay que instalarlo desde la web de Python
[www.python.org](http://www.python.org).

![Instalador de Python — Next, Next, Next... zzz](/static/images/posts/flask-IIS/screenshot-from-2015-01-19-16-17-10.png)

Instalar Python en Windows es bastante sencillo. Hay que bajar el instalador,
abrirlo y pulsar el botón `Next` del asistente hasta que tengamos la
confirmación de que la instalación ha concluido. La versión instalada es
Python 3.4.2 de 32 bits.

## Configurar el entorno virtual

La mejor manera de configurar el entorno virtual es mediante `Solution
Explorer`.

![Nuevo entorno virtual. Seleccionar Add Virtual Environment](/static/images/posts/flask-IIS/screenshot-from-2015-01-20-11-57-03-0.png)

Luego hay que hacer click con el botón derecho del mouse en `FlaskWebProject1`
→ `Python Environments` y seleccionar la opción `Add Virtual Environment`. En
la ventana de diálogo rellena los campos con los siguientes valores:

* Location of the virtual environment: **Flask**
* Select an interpreter: **Python 3.4**
* Download and install packages: **Activado**

Luego solo falta picar en el botón `Create`.

![Solo falta picar en el botón Create](/static/images/posts/flask-IIS/screenshot-from-2015-01-20.png)

Tras bambalinas VS (bueno, en realidad es PTVS) creará el entorno virtual y lo
activará (lo que equivale al `mkvirtualenv` en Linux/Unix/Mac) y después
instalará todas las dependencias listadas en `requirements.txt`, lo cual
equivale al comando `pip install -r requirements.txt`. Al terminar este proceso
verás que el entorno virtual llamado **Flask** ya se encuentra listado en
`Solution Explorer`.

![Virtualenv Activado](/static/images/posts/flask-IIS/screenshot-2015-01-20-160923.png)

## Probando Flask en modo depuración

En VS solo será necesario hacer click en el botón de debug para arrancar el
pequeño servidor integrado de Flask.

![Botón para arrancar Flask en modo debug](/static/images/posts/flask-IIS/screenshot-from-2015-01-20-16-14-07.png)

VS lanzará un intérprete de Python (para ser exactos: el `Python.exe` del
entorno virtual `Flask`), correrá `runserver.py` y cuando termine de arrancar
abrirá una ventana de Firefox (en mi caso) para que cargue el sitio.

![Y aquí está la prueba: Flask corriendo en Windoge](/static/images/posts/flask-IIS/screenshot-from-2015-01-20-16-13-47.png)

## Ahora que corra en IIS

En [un artículo anterior](/blog/instalar-iis-windows-10) describí cómo instalar
IIS 8.5 en Windoze 10. Ahora voy a describir cómo instalar la aplicación de
Flask en IIS. Primero hay que instalar el *Web Platform Installer*. Este se
descarga desde <http://www.microsoft.com/web/downloads/platform.aspx>. El
proceso de instalación es bastante similar a cualquier otro software.

Ya instalado el *Web Platform Installer* hay que abrirlo e instalar `WFastCGI
Gateway for IIS and Python`.

![Buscar `Python` en el Web Platform Installer](/static/images/posts/flask-IIS/screenshot-from-2015-01-20-16-32-45.png)

Seleccioné `WFastCGI 2.1 Gateway for IIS and Python 3.4` y le piqué al botón
`Add`. Con eso se habilitó el botón Install (en la esquina inferior derecha).
Al picarle al botón se abrió una ventana modal con pasos. En el primer paso se
informa de los prerequisitos. Yo le piqué en `I Accept`.

![I accept](/static/images/posts/flask-IIS/screenshot-from-2015-01-20-16-37-58.png)

El segundo paso es la instalación.

![Proceso](/static/images/posts/flask-IIS/screenshot-from-2015-01-20-16-39-38.png)

Hay que esperar a que descargue Python y otras cosas.

![Así termina](/static/images/posts/flask-IIS/screenshot-from-2015-01-20-16-40-15.png)

Nota: Parece que el `Web Installer` detectó que existía una instalación de
Python 3, pero no estoy seguro. Pero de lo que sí estoy seguro es de que
instaló un script (`wfastcgi.py`) en `C:\Python34\Scripts\wfastcgi.py`.

![El script de WFastCGI](/static/images/posts/flask-IIS/screenshot-from-2015-01-21-15-46-02.png)

¿Y qué es [FastCGI](http://www.fastcgi.com/)? Es CGI pero con algunas
extensiones. El script `wfastcgi.py` [es una
pasarela](http://pytools.codeplex.com/wikipage?title=wfastcgi) entre `FastCGI`
de IIS y el protocolo WSGI en las aplicaciones Python.

## Instalar FastCGI en IIS

En lugar de copiar y pegar los comandos con Package Manager intentaré innovar
un poquito y usar DISM en su lugar, ya que parece que es la más nueva
tecnología para agregar características a un Windows.

Por ejemplo, para ver el status del módulo `IIS-CGI`:

```powershell
Dism /online /Get-FeatureInfo /FeatureName:IIS-CGI
```

Y sale esto:

![Usando DISM para saber el estatus de una característica de Windoge](/static/images/posts/flask-IIS/screenshot-from-2015-01-21-15-26-42.png)

El comando para instalar el CGI de IIS es:

```powershell
Dism /online /Enable-Feature /FeatureName:IIS-CGI
```

Ahora comienzo a pensar que me pude ahorrar tantos screenshots del proceso de
instalación y hacerlo desde la línea de comandos. pff!

![Instalación de característica IIS-CGI](/static/images/posts/flask-IIS/screenshot-from-2015-01-21-15-31-07.png)

Ahemmm... De regreso a lo que estaba haciendo...

Ahora es momento de usar
[appcmd](http://www.iis.net/learn/get-started/getting-started-with-iis/getting-started-with-appcmdexe)
para configurar todo el pipeline de `FastCGI` mediante Python en IIS. Por
comodidad primero cambiamos el directorio para no tener que escribir toda la
ruta a `appcmd.exe`.

```powershell
cd c:\Windows\System32\inetsrv\
```

Registrar el manejador de FastCGI a nivel servidor.

```powershell
appcmd set config /section:system.webServer/fastCGI "/+[fullPath='C:\Python34\python.exe', arguments='C:\Python34\Scripts\wfastcgi.py']"
```

*Nota*: Si te sale un error muy feo como el de abajo significa que ya estaba
configurado.

```powershell
ERROR ( message:New application object missing required attributes. Cannot add duplicate collection entry of type 'application' with combined key attributes 'fullPath, arguments' respectively set to 'C:\Python34\python.exe, C:\Python34\Scripts\wfastcgi.py' )
```

Ahora es momento de registrar/activar el módulo `FastCGI`:

```powershell
appcmd set config /section:system.webServer/handlers "/+[name='Python_via_FastCGI',path='*',verb='*',modules='FastCgiModule',scriptProcessor='c:\Python34\python.exe|C:\Python34\Scripts\wfastcgi.py',resourceType='Unspecified']"
```

Configura el Python path para que use Flask:

```powershell
appcmd set config -section:system.webServer/fastCgi /+"[fullPath='C:\Python34\python.exe', arguments='C:\Python34\Scripts\wfastcgi.py'].environmentVariables.[name='PYTHONPATH',value='C:\inetpub\apps\Flask']" /commit:apphost
```

Ahora hay que decirle al módulo de FastCGI el handler de WSGI.

----
Referencias:

* <http://flask.pocoo.org/docs/0.10/deploying/fastcgi/>
* <http://stackoverflow.com/questions/5072166/how-do-i-deploy-a-flask-application-in-iis>
* <http://azure.microsoft.com/en-us/documentation/articles/virtual-machines-python-django-web-app-windows-server/>
* <http://pytools.codeplex.com/wikipage?title=wfastcgi>

**FIN**
