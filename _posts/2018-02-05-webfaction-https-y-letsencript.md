---
published: false
title: Configuración de un sitio HTTPS en webfaction con let's encrypt
---
## Configuracion de un sitio HTTPS en webfaction con let's encrypt

Estas son mis notas de configuracion de HTTPS en webfaction, pero usando certificados de [Let's Encrypt](https://letsencrypt.org/).

Hasta el dia de hoy (5 de Febreo de 2018) sólo he probado dos métodos:

* [letsencrypt_webfaction](https://github.com/will-in-wi/letsencrypt-webfaction) (escrito en Ruby)
* [Acme.sh](https://github.com/Neilpang/acme.sh) (escrito en bash)

Inicialmente tenia planeado mostrar cómo usar ámbos métodos, pero no he podido completarlo así que sólo voy a cubrir `letsencrypt_webfaction`.

## Preparación del sitio

El sitio que voy a confgurar es: [demos.noenieto.com](https://demos.noenieto.com). Este dominio ya esta configurado en mi webfaction de antemano:

![Sitio HTTPS ya configurado en webfaction]({{site.baseurl}}/media/Screenshot from 2017-10-13 12-38-50.png)

`letsencrypt_webfaction` requiere tener acceso a la raiz del sitio por medio del sistema de archivo
Como ultimo detalle, la ruta hacia el directorio del sitio es: `~/webapps/demos_noenieto` y el sitio esta configurado para **http** y **https** ya que es necesario acceso al sitio por **http** antes de poder emitir el certificado por primera vez.

Tambien hay que confugurar un sitio para redireccionar de **http** a **https**. Ambos son sitios estáticos.

![Screenshot-2018-1-6 Website list - WebFaction Control Panel.png]({{site.baseurl}}/media/Screenshot-2018-1-6 Website list - WebFaction Control Panel.png)

En el sitio `demos_http` agregamos un archivo `.htaccess` que contiene:

```apache
Options +FollowSymLinks
RewriteEngine on
RewriteBase /
RewriteCond %{REQUEST_URI} !^/.well-known
RewriteRule ^(.*)$ https://demos.noenieto.com/$1 [R=301,L]
```
El archivo `.htacces` de arriba ya viene preparado redireccionar'a todas las peticiones al HTTPS excepto las del directorio `.well-known`.

Finalmente vale la pena comentar que tuve muchos problemas al correr letsencryp_webfaction. La causa raíz es que el registro demos.noenieto.com era un `CNAME` que apunta al servidor de webfaction. Despues de la [ayuda del creador de letsencrypt_webfaction](https://github.com/will-in-wi/letsencrypt-webfaction/issues/104) decidi probar a configurar todo con registros `A` y `AAAA` y todo funcionó sin mayor problema.

## Instalación de `letsencrypt_webfaction`

Nota: esta entrada en el mailblog de  [Nick Doty](http://bcc.npdoty.name/directions-to-migrate-your-WebFaction-site-to-HTTPS) me sirvio mucho.

Para instalar hay que usar ruby:

```bash
GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib gem2.2 install letsencrypt_webfaction
```

Es muy recomendable agregar esto al final de `.bash_profile` para no tener que especificar las variables de entorno cada vez que corre `letsencrypt_webfaction`:

```bash
function letsencrypt_webfaction {
    PATH=$PATH:$GEM_HOME/bin GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib ruby2.2 $HOME/.letsencrypt_webfaction/gems/bin/letsencrypt_webfaction $*
}

export -f letsencrypt_webfaction
```

Luego, para no reiniciar sesion:

```bash
source ~/.bash_profile
```

Ahora probamos:

```bash
$ letsencrypt_webfaction --version
2.2.1

$ letsencrypt_webfaction --help
Usage: letsencrypt_webfaction [options]
        --config=CONFIG              Path to config file. Arguments passed to the program will override corresponding directives in the config file.
    -h, --help                       Prints this help
        --key_size=KEY_SIZE          Size of private key (e.g. 4096)
        --endpoint=ENDPOINT          ACME endpoint (e.g. https://acme-v01.api.letsencrypt.org/)
        --domains=DOMAINS            Comma separated list of domains. The first one will be the common name.
        --public=PUBLIC              Locations on the filesystem served by the desired sites (e.g. "~/webapps/myapp/public_html,~/webapps/myapp1/public_html")
        --output_dir=OUTPUT_DIR      Location on the filesystem to which the certs will be saved.
        --letsencrypt_account_email=LETSENCRYPT_ACCOUNT_EMAIL
                                     The email address associated with your account.
        --api_url=API_URL            The URL to the Webfaction API.
        --username=USERNAME          The username for your Webfaction account.
        --password=PASSWORD          The password for your Webfaction account.
        --servername=SERVERNAME      The server on which this application resides (e.g. Web123).
        --cert_name=CERT_NAME        The name of the certificate in the Webfaction UI.
        --quiet                      Whether to display text on success.
        --version                    Show version

$
```

## Configuracion final del sitio

La herramienta tiene muchos ajustes, asi que es mejor guardar todo en un archivo.

```bash
mkdir ~/letsencrypt
vim ~/letsencrypt/demos_noenieto_com.yml
```

Aca esta el contenido de mi archivo de configuración

```
domains: [demos.noenieto.com]
public: [/home/nnieto/webapps/demos_http]
output_dir: /home/nnieto/letsencrypt/
letsencrypt_account_email: nnieto@noenieto.com
username: noenieto
password: S0rpr354
cert_name: demos_noenieto_com
```
Nota: El nombre de usuario y contraseña son las de la cuenta de webfaction. 

Primero probamos con staging

```bash
letsencrypt_webfaction --endpoint https://acme-staging.api.letsencrypt.org/ --config=$HOME/letsencrypt/demos_noenieto_com.yml 

Your new certificate is now created and installed.
You will need to change your application to use the ichp_ssl_cert certificate.
Add the `--quiet` parameter in your cron task to remove this message.
```

Después de configurar el sitio con registros A y AAA el programa funciona muy bien y justo después de esto podemos ver que en el panel de configuración cuenta de de webfaction se ha creado un certificado con el nombre `cert_demos_noenieto.com`.

![Screenshot-2018-2-5 SSL certificates list - WebFaction Control Panel.png]({{site.baseurl}}/media/Screenshot-2018-2-5 SSL certificates list - WebFaction Control Panel.png)

Es solo cuestion de seleccionar el certificado para el sitio https adecuado.


El comando final es este:

```bash
letsencrypt_webfaction --config=$HOME/SSL_certificates/demos.noenieto.com/config.yml
```


### Renovacion y cronjob

```cron
# Let's encrypt
00 0 * * * letsencrypt_webfaction --quiet --config=$HOME/SSL_certificates/demos.noenieto.com/config.yml
```

## Problemas encontrados

Como ya lo mencioné, esto no funciona bien usando CNAMES. Aca un ejemplo del error:

```bash
$ letsencrypt_webfaction --endpoint https://acme-staging.api.letsencrypt.org/ --config=$HOME/letsencrypt/demos_noenieto_com.yml 
Failed to verify statuses.
demos.noenieto.com: Invalid response from http://demos.noenieto.com/.well-known/acme-challenge/nOAK22n3fuqyNxFRw37DwF1I02PlikLWU5_-jVtenGY: "<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <meta http-equi"
Make sure that you can access http://demos.noenieto.com/.well-known/acme-challenge/nOWK22n3fuqyNxFrasgva23123w37DwF1I02PlikLWU5_-jVtenGY
```
Dig reporta que demos.noenieto.com es un `CNAME`.

```bash
$ dig demos.noenieto.com
[...]

;; ANSWER SECTION:
demos.noenieto.com.	1799	IN	CNAME	web547.webfaction.com.
web547.webfaction.com.	3600	IN	A	207.38.86.18

[...]
```

Una vez que los cambios en el DNS se han propagado ...

```bash
$ dig demos.noenieto.com
[...]

;; ANSWER SECTION:
demos.noenieto.com.	1799	IN	A	207.38.86.18
[...]
```
... el registro del certificado funciona bien:

```bash
$ letsencrypt_webfaction --endpoint https://acme-staging.api.letsencrypt.org/ --config=$HOME/letsencrypt/demos_noenieto_com.yml 
Your new certificate is now created and installed.
You will need to change your application to use the demos_noenieto_com certificate.
Add the `--quiet` parameter in your cron task to remove this message.

```




