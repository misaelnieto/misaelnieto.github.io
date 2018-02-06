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

letsencrypt_webfaction requiere tener acceso a la raiz del sitio por medio del sistema de archivo
Como ultimo detalle, la ruta hacia el directorio del sitio es: `~/webapps/demos_noenieto` y el sitio esta configurado para **http** y **https** ya que es necesario acceso al sitio por **http** antes de poder emitir el certificado por primera vez.

Tambien hay que confugurar un sitio para redireccionar de **http** a **https**. Ambos son sitios estáticos.

![Screenshot-2018-1-6 Website list - WebFaction Control Panel.png]({{site.baseurl}}/media/Screenshot-2018-1-6 Website list - WebFaction Control Panel.png)

En el sitio demos_http agregamos un archivo `.htaccess` que contiene:

```apache
Options +FollowSymLinks
RewriteEngine on
RewriteBase /
RewriteCond %{REQUEST_URI} !^/.well-known
RewriteRule ^(.*)$ https://demos.noenieto.com/$1 [R=301,L]
```


## Instalando letsencrypt_webfaction

Al final decidí quedarme con letsencrypt_webfaction por que no tengo que mantener un script de python y al final funcionó bastante bien.

Me basé en este sitio:

http://bcc.npdoty.name/directions-to-migrate-your-WebFaction-site-to-HTTPS

### Instalacion

Para instalar corri esto:

```bash
GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib gem2.2 install letsencrypt_webfaction
```

Y agregué esto al final de `.bash_profile`:

```bash
function letsencrypt_webfaction {
    PATH=$PATH:$GEM_HOME/bin GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib ruby2.2 $HOME/.letsencrypt_webfaction/gems/bin/letsencrypt_webfaction $*
}

export -f letsencrypt_webfaction
```
Para no reiniciar sesion:

```bash
source ~/.bash_profile
```
Ahora probamos:

```bash
letsencrypt_webfaction
letsencrypt_webfaction --help
```

### Configuracion

La herramienta tiene muchos ajustes, asi que es mejor guardar todo en un archivo.

```bash
mkdir -p ~/SSL/demos_noenieto_com.yml/
vim ~/SSL/demos_noenieto_com.yml
```

Aca esta el contenido de mi archivo.

```
domains: [demos.noenieto.com]
public: [/home/fulano/webapps/demos_http]
output_dir: /home/fulano/SSL_certificates/demos.noenieto.com
letsencrypt_account_email: nnieto@noenieto.com
username: fulano
password: S00p3rp455
cert_name: demos
```

Es bien importante que el directorio public este bien configurado. El `.htacces` de arriba ya viene preparado. Redireccionara todas las peticiones al HTTPS excepto las del directorio `.well-known`.

Primero probamos con staging

```bash
$ letsencrypt_webfaction --endpoint https://acme-staging.api.letsencrypt.org/ --config=$HOME/SSL_certificates/www.holokineticpsychology.org/config.yml 
Your new certificate is now created and installed.
You will need to change your application to use the ichp_ssl_cert certificate.
Add the `--quiet` parameter in your cron task to remove this message.
```

Nota: 


Tuve que configurar el DNS en IPv4 e IPv6 con registros `A` y `AAAA`. Tuve muchos problemas por que el registro era un `CNAME` a el servidor de webfaction. Despues de la [ayuda del creador de letsencrypt_webfaction](https://github.com/will-in-wi/letsencrypt-webfaction/issues/104) decidi probar a configurar todo con registros `A` y `AAAA`.

El comando final es este:

```bash
letsencrypt_webfaction --config=$HOME/SSL_certificates/demos.noenieto.com/config.yml
```

Despues de esto verifico que `demos` ya aparece en la lista de certificados de webfaction. Es solo cuestion de seleccionar el certificado para el sitio https adecuado.

### Renovacion y cronjob

```cron
# Let's encrypt
00 0 * * * letsencrypt_webfaction --quiet --config=$HOME/SSL_certificates/demos.noenieto.com/config.yml
```
