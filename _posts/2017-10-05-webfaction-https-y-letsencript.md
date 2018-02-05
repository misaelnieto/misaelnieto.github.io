---
published: false
---
## Configuracion de un sitio HTTPS en webfaction con let's encrypt

Estas son mis notas de configuracion de HTTPS en webfaction, pero usando certificados de [Let's Encrypt](https://letsencrypt.org/).

Hasta el dia de hoy (7 de Enero de 2018) sólo he probado dos métodos:

* [letsencrypt_webfaction](https://github.com/will-in-wi/letsencrypt-webfaction) (escrito en Ruby)
* [Acme.sh](https://github.com/Neilpang/acme.sh) (escrito en bash)

## Preparación de los sitios

En este post voy a probar los dos metodos en el mismo sitio: [demos.noenieto.com](https://demos.noenieto.com). Este dominio ya esta configurado en mi webfaction de antemano:

![Sitio HTTPS ya configurado en webfaction]({{site.baseurl}}/media/Screenshot from 2017-10-13 12-38-50.png)

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


## Probando Acme.sh

Este fue la primera herramiente que use, hace unos 6 meses. Para instalar Acme.sh me basé en una [respuesta a una pregunta en el foro de webfaction](https://community.webfaction.com/questions/19988/using-letsencrypt).

El proceso de instalación es bastante sencillo por que acme.sh viene con su propio _instalador_.

```bash
curl https://get.acme.sh | sh
```

Al correr el instalador saca algunos mensajes de error: 

![It is recommended to install socat first. We use socat for standalone server if you use standalone mode. If you don't use standalone mode, just ignore this warning]({{site.baseurl}}/media/Screenshot from 2017-10-13 13-18-07.png)

Simplemente ignore el mensaje y segui con la tarea. Entonces, acme.sh ya esta instalado. Para acceder a la ayuda de `acme.sh` se debe de usar la opción `--help`: 

```bash
acme.sh --help
```

Las opciones son muchas, pero solo haremos uso de unas cuantas a la vez. Lo primero que quiero hacer es emitir el certificado para un sitio por primera vez; como es la primera vez que voy a hacer esto usaré la opción `--test` de acme.sh

```bash
acme.sh --issue --test -d demos.noenieto.com -w ~/webapps/demos_noenieto
```


```bash
acme.sh --issue --test -d demos.noenieto.com -w ~/webapps/demos_noenieto
acme.sh --issue -d demos.noenieto.com -w ~/webapps/demos_noenieto
acme.sh --force --issue -d demos.noenieto.com -w ~/webapps/demos_noenieto
ls /home/fulano/.acme.sh/demos.noenieto.com/
demos.noenieto.com.cer
demos.noenieto.com.key
ca.cer
```

### Renovacion y cronjob


```bash
acme.sh --cron --home /home/fulano/.acme.sh
/home/fulano/.acme.sh/acme.sh --cron --home /home/fulano/.acme.sh
acme.sh --renew-all
acme.sh --renew-all --force
/home/fulano/.acme.sh/acme.sh --cron --home /home/fulano/.acme.sh
/home/fulano/.acme.sh/acme.sh --cron --force --home /home/fulano/.acme.sh
```

acme.sh --list | tail -n +2 | cut -f 1 -d ' '
```cron
52 0 * * * /home/fulano/.acme.sh/acme.sh --cron --home /home/fulano/.acme.sh > /dev/null
```

```python
#!/usr/bin/env python
# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
from os.path import join as joinpath, expanduser
from xmlrpclib import ServerProxy


wf_api = ServerProxy('https://api.webfaction.com/')
session_id, account = wf_api.login(
    'fulano',
    'sup3rs4dr37',
    '',
    2
)

base_path = '~/.acme.sh'
domains = ['demos.noenieto.com', ]

for domain in domains:
    dpath = joinpath(base_path, domain)
    cert_path = joinpath(dpath, '{}.cer'.format(domain))
    privkey_path = joinpath(dpath, '{}.key'.format(domain))
    intermediates_path = joinpath(dpath, 'fullchain.cer')
    wf_api.update_certificate(
        session_id,
        open(expanduser(cert_path), 'r').read(),
        open(expanduser(privkey_path), 'r').read(),
        open(expanduser(intermediates_path), 'r').read()
    )
```


## Probando letsencrypt_webfaction

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

Nota: Tuve que configurar el DNS en IPv4 e IPv6 con registros `A` y `AAAA`. Tuve muchos problemas por que el registro era un `CNAME` a el servidor de webfaction. Despues de la ayuda del creador de letsencrypt_webfaction decidi probar a configurar todo con registros `A` y `AAAA`.

El comando final es este:

```bash
letsencrypt_webfaction --config=$HOME/SSL_certificates/demos.noenieto.com/config.yml
```

Despues de esto verifico que `demos` ya aparece en la lista de certificados de webfaction. Es solo cuestion de seleccionar el certificado para el sitio https adecuado.

### Renovacion y cronjob

Primero voy a hacer un script de bash para simplificar

```bash
#!/bin/bash
PATH=$PATH:$GEM_HOME/bin:/usr/local/bin
GEM_HOME=$HOME/.letsencrypt_webfaction/gems
RUBYLIB=$GEM_HOME/lib

ruby2.2 $HOME/.letsencrypt_webfaction/gems/bin/letsencrypt_webfaction \
    --config=$HOME/SSL_certificates/demos.noenieto.com/config.yml \
    --domains [yourdomain.com,www.yourdomain.com] --public ~/webapps/[yourapp/your_public_html]/ \
    --quiet

```

Luegoi el Cron

Pero falta leer la documentacion.
