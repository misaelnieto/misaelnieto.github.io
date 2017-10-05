---
published: false
---
## Configuracion de un sitio HTTPS en webfaction con let's encrypt

Estas son mis notas de configuracion de HTTPS en webfaction, pero usando cretificados de [Let's Encrypt](https://letsencrypt.org/).

Hasta el dia de hoy se de dos sólo dos metodos:

* letsencrypt_webfaction escrito en Ruby
* Acme.sh escrito en bash

## Probando Acme.sh

### Instalacion
### Configuracion
### Renovacion y cronjob

## Probando letsencrypt_webfaction

### Instalacion

GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib gem2.2 install letsencrypt_webfaction

Agregar esto al final de .bash_profile
vim .bash_profile

function letsencrypt_webfaction {
    PATH=$PATH:$GEM_HOME/bin GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib ruby2.2 $HOME/.letsencrypt_webfaction/gems/bin/letsencrypt_webfaction $*
}

Si no quieres reiniciar sesion:
source .bash_profile

Probando ...

letsencrypt_webfaction

letsencrypt_webfaction --help


### Configuracion

La herramienta tiene muchos ajustes, asi que es mejor guardar todo en un archivo.

Aca esta el contenido de mi archivo.

domains: [www.misitio.org, misitio.org]
public: [/home/hklibros/webapps/misitio]
output_dir: /home/hklibros/SSL_certificates/www.misitio.org
letsencrypt_account_email: nnieto@noenieto.com
username: fulano
password: S00p3rp455
cert_name: myapp_ssl_cert


### Renovacion y cronjob




