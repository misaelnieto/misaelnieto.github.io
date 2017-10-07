---
published: false
---
## Configuracion de un sitio HTTPS en webfaction con let's encrypt

Estas son mis notas de configuracion de HTTPS en webfaction, pero usando cretificados de [Let's Encrypt](https://letsencrypt.org/).

Hasta el dia de hoy (5 de Octubre de 2017) sólo he probado dos métodos:

* [letsencrypt_webfaction](https://github.com/will-in-wi/letsencrypt-webfaction) (escrito en Ruby)
* [Acme.sh](https://github.com/Neilpang/acme.sh) (escrito en bash)

## Probando Acme.sh

Este fue la primera herramiente que use, hace unos 6 meses. Después supe de letsencrypt_webfaction. Para instalar Acme.sh me basé en una [respuesta a una pregunta en el foro de webfaction](https://community.webfaction.com/questions/19988/using-letsencrypt).

### Instalacion

La instalación es bastante sencilla y viene con su propio _instalador_.

```bash
curl https://get.acme.sh | sh
```

Para acceder a la ayuda de `acme.sh` se debe de usar la opción `--help`: 

```bash
acme.sh --help
```

Las opciones son muchas, pero solo haremos uso de sólo unas cuantas a la vez. Lo primero que quiero hacer es emitir el certificado para un sitio por primera vez. Por ejemplo, el sitio www.pythonero.com ya esta configurado en mi webfaction:



### Configuracion

acme.sh --issue --test -d www.pythonero.com -w ~/webapps/kanboard
acme.sh --issue -d www.pythonero.com -w ~/webapps/kanboard
acme.sh --force --issue -d www.pythonero.com -w ~/webapps/kanboard
ls /home/fulano/.acme.sh/www.pythonero.com/
www.pythonero.com.cer
www.pythonero.com.key
ca.cer

### Renovacion y cronjob

acme.sh --cron --home /home/fulano/.acme.sh
/home/fulano/.acme.sh/acme.sh --cron --home /home/fulano/.acme.sh
acme.sh --renew-all
acme.sh --renew-all --force
/home/fulano/.acme.sh/acme.sh --cron --home /home/fulano/.acme.sh
/home/fulano/.acme.sh/acme.sh --cron --force --home /home/fulano/.acme.sh


acme.sh --list | tail -n +2 | cut -f 1 -d ' '

52 0 * * * /home/fulano/.acme.sh/acme.sh --cron --home /home/fulano/.acme.sh > /dev/null

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
domains = ['www.pythonero.com', ]

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
    
 



## Probando letsencrypt_webfaction

Docus chida::

http://bcc.npdoty.name/directions-to-migrate-your-WebFaction-site-to-HTTPS

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

mkdir ~/SSL_certificates/www.misitio.org/config.yml
vim ~/SSL_certificates/www.misitio.org/config.yml

Aca esta el contenido de mi archivo.

domains: [www.pythonero.org, pythonero.org]
public: [/home/fulano/webapps/misitio]
output_dir: /home/fulano/SSL_certificates/www.pythonero.com
letsencrypt_account_email: nnieto@noenieto.com
username: fulano
password: S00p3rp455
cert_name: myapp_ssl_cert

letsencrypt_webfaction --config=$HOME/SSL_certificates/www.pythonero.com/config.yml

### Renovacion y cronjob

Primero voy a hacer un script de bash para simplificar

```bash
#!/bin/bash
PATH=$PATH:$GEM_HOME/bin:/usr/local/bin
GEM_HOME=$HOME/.letsencrypt_webfaction/gems
RUBYLIB=$GEM_HOME/lib

ruby2.2 $HOME/.letsencrypt_webfaction/gems/bin/letsencrypt_webfaction \
    --config=$HOME/SSL_certificates/www.pythonero.com/config.yml \
    --domains [yourdomain.com,www.yourdomain.com] --public ~/webapps/[yourapp/your_public_html]/ \
    --quiet

```

Luegoi el Cron

Pero falta leer la documentacion.

