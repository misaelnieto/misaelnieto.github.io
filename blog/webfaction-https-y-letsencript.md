---
title: Configuración de un sitio HTTPS en WebFaction con Let's Encrypt
date: 2018-02-05
description: 'Tutorial paso a paso para emitir y renovar certificados Let''s Encrypt en WebFaction usando letsencrypt_webfaction: registro A/AAAA, .htaccess para redirección http→https, cron y notificaciones.'
tags:
- https
- lets-encrypt
- webfaction
- ssl
- acme
- apache
extra:
  deprecated: true
  deprecated_reason: WebFaction fue adquirida por GoDaddy y cerró en 2023; letsencrypt_webfaction ya no se mantiene. El flujo canónico moderno es certbot o acme.sh sobre cualquier hosting moderno (Caddy trae ACME built-in). Credenciales redactadas.
---

## Configuración de un sitio HTTPS en WebFaction con Let's Encrypt

Estas son mis notas de configuración de HTTPS en WebFaction usando certificados de [Let's Encrypt](https://letsencrypt.org/).

Hasta el día de hoy (5 de febrero de 2018) sólo he probado dos métodos:

- [letsencrypt_webfaction](https://github.com/will-in-wi/letsencrypt-webfaction) (escrito en Ruby)
- [Acme.sh](https://github.com/Neilpang/acme.sh) (escrito en bash)

Inicialmente tenía planeado mostrar cómo usar ambos métodos, pero no he podido completarlo así que solo voy a cubrir `letsencrypt_webfaction` que es el que mejor se ha portado.

## Preparación del sitio

El sitio que voy a configurar es: [demos.noenieto.com](https://demos.noenieto.com). Este dominio ya está configurado en mi WebFaction de antemano:

![Screenshot-2018-1-6 Website list - WebFaction Control Panel.png](/static/images/posts/webfaction-https-y-letsencript/screenshot-2018-01-06-webfaction-control-panel.png)

La ruta hacia el directorio del sitio es: `~/webapps/demos_noenieto` y el sitio está configurado para **http** y **https** ya que es necesario acceso al sitio por **http** antes de poder emitir el certificado por primera vez.

También hay que configurar un sitio para redireccionar de **http** a **https**. Ambos son sitios estáticos.

En el sitio `demos_http` agregué un archivo `.htaccess` que contiene lo siguiente:

```apache
Options +FollowSymLinks
RewriteEngine on
RewriteBase /
RewriteCond %{REQUEST_URI} !^/.well-known
RewriteRule ^(.*)$ https://demos.noenieto.com/$1 [R=301,L]
```

El archivo `.htaccess` de arriba redireccionará todas las peticiones al sitio HTTPS excepto las del directorio `.well-known`.

Vale la pena comentar que tuve muchos problemas al correr `letsencrypt_webfaction`. La causa raíz es que el registro **demos.noenieto.com** era un `CNAME` que apunta al servidor de WebFaction. Después de la [ayuda del creador de letsencrypt_webfaction](https://github.com/will-in-wi/letsencrypt-webfaction/issues/104) decidí probar a configurar todo con registros `A` y `AAAA` y todo funcionó sin mayor problema.

## Instalación de `letsencrypt_webfaction`

Nota: esta entrada del mailblog de [Nick Doty](http://bcc.npdoty.name/directions-to-migrate-your-WebFaction-site-to-HTTPS) me sirvió mucho.

Para instalar hay que usar Ruby:

```bash
GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib gem2.2 install letsencrypt_webfaction
```

Luego hice un script (`~/bin/letsencrypt_webfaction`) que ya define las variables de entorno:

```bash
#!/bin/bash

PATH=$PATH:/usr/local/bin:$GEM_HOME/bin GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib ruby2.2 $HOME/.letsencrypt_webfaction/gems/bin/letsencrypt_webfaction $*
```

Ahora probamos:

```console
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

## Configuración final del sitio

La herramienta tiene muchos ajustes, así que es mejor guardar todo en un archivo.

```bash
mkdir ~/letsencrypt
vim ~/letsencrypt/demos_noenieto_com.yml
```

Acá está el contenido de mi archivo de configuración:

```yaml
domains: [demos.noenieto.com]
public: [/home/<usuario>/webapps/demos_http]
output_dir: /home/<usuario>/letsencrypt/
letsencrypt_account_email: <tu-correo>@<dominio>
username: <usuario-webfaction>
password: <password-webfaction>
cert_name: demos_noenieto_com
```

> **Nota**: el nombre de usuario y contraseña son los de la cuenta de WebFaction. Cámbialos por los tuyos.

Primero probamos con staging:

```console
$ letsencrypt_webfaction --endpoint https://acme-staging.api.letsencrypt.org/ --config=$HOME/letsencrypt/demos_noenieto_com.yml

Your new certificate is now created and installed.
You will need to change your application to use the demos_noenieto_com certificate.
Add the `--quiet` parameter in your cron task to remove this message.
```

Después de configurar el sitio con registros `A` y `AAAA` el programa funciona muy bien y justo después de esto podemos ver que en el panel de configuración de la cuenta de WebFaction se ha creado un certificado con el nombre `cert_demos_noenieto.com`.

![Screenshot-2018-2-5 SSL certificates list - WebFaction Control Panel.png](/static/images/posts/webfaction-https-y-letsencript/screenshot-2018-02-05-ssl-certificates.png)

Ya sólo falta configurar el sitio web para que use el certificado adecuado.

![Screenshot-2018-2-7 Edit website demos_https - WebFaction Control Panel.png](/static/images/posts/webfaction-https-y-letsencript/screenshot-2018-02-07-demos-https.png)

El comando final es este:

```bash
letsencrypt_webfaction --config=$HOME/letsencrypt/demos_noenieto_com.yml
```

### Renovación y cronjob

Los certificados de Let's Encrypt [duran sólo 90 días](https://letsencrypt.org/2015/11/09/why-90-days.html) así que lo configuraré para que se renueve todos los días 15 del mes a la medianoche.

```cron
# Let's encrypt
00 0 15 * * ~/bin/letsencrypt_webfaction --quiet --config=$HOME/letsencrypt/demos_noenieto_com.yml
```

### Notificación por email

Ahora quiero que cada vez que se actualicen los certificados me llegue una notificación a mi correo. Esto se puede hacer fácilmente desde el comando `letsencrypt_webfaction` agregándole lo siguiente hasta el final:

```bash
mail -s "Renovación de certificado" "<tu-correo>@<dominio>" <<EOF
Se renovó un certificado de Let's Encrypt.
Argumentos: $*
EOF
```

## Problemas encontrados

Como ya lo mencioné, esto no funciona bien usando CNAMEs. Acá un ejemplo del error:

```console
$ letsencrypt_webfaction --endpoint https://acme-staging.api.letsencrypt.org/ --config=$HOME/letsencrypt/demos_noenieto_com.yml
Failed to verify statuses.
demos.noenieto.com: Invalid response from http://demos.noenieto.com/.well-known/acme-challenge/nOAK22n3fuqyNxFRw37DwF1I02PlikLWU5_-jVtenGY: "<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <meta http-equi"
Make sure that you can access http://demos.noenieto.com/.well-known/acme-challenge/nOWK22n3fuqyNxFrasgva23123w37DwF1I02PlikLWU5_-jVtenGY
```

`dig` reporta que `demos.noenieto.com` es un `CNAME`:

```console
$ dig demos.noenieto.com
[...]

;; ANSWER SECTION:
demos.noenieto.com.	1799	IN	CNAME	web547.webfaction.com.
web547.webfaction.com.	3600	IN	A	207.38.86.18

[...]
```

Una vez que los cambios en el DNS se han propagado...

```console
$ dig demos.noenieto.com
[...]

;; ANSWER SECTION:
demos.noenieto.com.	1799	IN	A	207.38.86.18
[...]
```

... el registro del certificado funciona bien:

```console
$ letsencrypt_webfaction --endpoint https://acme-staging.api.letsencrypt.org/ --config=$HOME/letsencrypt/demos_noenieto_com.yml
Your new certificate is now created and installed.
You will need to change your application to use the demos_noenieto_com certificate.
Add the `--quiet` parameter in your cron task to remove this message.
```

**FIN**
