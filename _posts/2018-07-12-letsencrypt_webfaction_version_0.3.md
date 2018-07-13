---
published: false
---
## Configuracion de un sitio HTTPS en webfaction con let's encrypt (Version 3)

Estas son mis notas de configuracion de HTTPS en webfaction usando certificados de [Let's Encrypt](https://letsencrypt.org/). Ya había publicado una guía anterior, pero hay una nueva version del letsencrypt_webfaction y trae cambios que requieren reconfigurar. Así que volvemos a empezar desde cero.

## Preparación del sitio

La preparación del sitio es [la misma](/2018/02/05/webfaction-https-y-letsencript.html) y no es necesario cubrirla de nuevo.

## Actualzación de `letsencrypt_webfaction`

La guía de instalación oficial está [en github](https://github.com/will-in-wi/letsencrypt-webfaction/blob/master/docs/upgrading.md).

El comando para instalar y actualizar es el mismo:

```bash
GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib gem2.2 install letsencrypt_webfaction
```

En esta ocasión voy a seguir las instrucciones al pie de la letra y voy a configurar el comando `/letsencrypt_webfaction` mediante `.bash_profile`. Así quedó el mio:

```bash
cat .bash_profile 
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

function letsencrypt_webfaction {
    PATH=$PATH:$GEM_HOME/bin GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib ruby2.2 $HOME/.letsencrypt_webfaction/gems/bin/letsencrypt_webfaction $*
}
```
El script anterior `~/bin/letsencrypt_webfaction` lo renombré a `~/bin/renew_certificates` y queda como está a continuación:

```bash
#!/bin/bash

PATH=$PATH:/usr/local/bin:$GEM_HOME/bin GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib ruby2.2 $HOME/.letsencrypt_webfaction/gems/bin/letsencrypt_webfaction $*

```

## Inicialización del archivo de configuración:

Una de las novedades de la versión 0.3 de `letsencrypt_webfaction` es que el script ya no acepta ningun parámetro en la línea de comando, excepto por `init` y `run`. Cuando corres el comando `init` se crea el archivo `letsencrypt_webfaction.toml`

## Reconfiguración

En la versión 0.2 de `letsencrypt_webfaction` tenía que tener un archivo de configuración por cada dominio/sitio. Ahora sólo se requiere un solo archivo (`letsencrypt_webfaction.toml`). La configuración anterior (`~/letsencrypt/demos_noenieto_com.yml`) era:

```yaml
domains: [demos.noenieto.com]
public: [/home/nnieto/webapps/demos_http]
output_dir: /home/nnieto/letsencrypt/
letsencrypt_account_email: nnieto@noenieto.com
username: noenieto
password: S0rpr354
cert_name: demos_noenieto_com
```

Ahora la configuración va a ser:

```toml
username = "nmnieto"
password = "S0rpr354"
letsencrypt_account_email = "nnieto@noenieto.com"
endpoint = "https://acme-staging.api.letsencrypt.org/" # Staging

[[certificate]]
domains = [
  "demos.noenieto.com",
]
public = "~/webapps/demos_noenieto/"
name = "demos_noenieto_com"
```

Primero probamos con staging

```bash
letsencrypt_webfaction --endpoint https://acme-staging.api.letsencrypt.org/ --config=$HOME/letsencrypt/demos_noenieto_com.yml 

Your new certificate is now created and installed.
You will need to change your application to use the demos_noenieto_com certificate.
Add the `--quiet` parameter in your cron task to remove this message.
```

Después de configurar el sitio con registros `A` y `AAA` el programa funciona muy bien y justo después de esto podemos ver que en el panel de configuración cuenta de de webfaction se ha creado un certificado con el nombre `cert_demos_noenieto.com`.

![Screenshot-2018-2-5 SSL certificates list - WebFaction Control Panel.png]({{site.baseurl}}/media/Screenshot-2018-2-5 SSL certificates list - WebFaction Control Panel.png)

Ya sólo falta configurar el sitio web para que use el certificadovadecuado.

![Screenshot-2018-2-7 Edit website demos_https - WebFaction Control Panel.png]({{site.baseurl}}/media/Screenshot-2018-2-7 Edit website demos_https - WebFaction Control Panel.png)


El comando final es este:

```bash
letsencrypt_webfaction --config=$HOME/letsencrypt/demos_noenieto_com.yml
```


### Renovacion y cronjob

Los certificados de Let's encrypt [duran sólo 90 días](https://letsencrypt.org/2015/11/09/why-90-days.html) asi que lo configuraré para que se renueve todos los días 15 del mes a la media noche.

```cron
# Let's encrypt
00 0 15 * * ~/bin/letsencrypt_webfaction --quiet --config=$HOME/letsencrypt/demos_noenieto_com.yml
```

### Notificacion por email

Ahora quiero que cada vez que se actualicen los certificados me llegue una notificación a mi correo. Esto se puede hacer fácilmente desde el comando `letsencrypt_webfaction` agregándole lo siguiente hasta el final.

```bash
mail -s "Renovacion de certificado" "nnieto@noenieto.com" <<EOF
Se renovó un certifcado de letsencrypt.
Argumentos: $*
EOF
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
demos.noenieto.com. 1799    IN  CNAME   web547.webfaction.com.
web547.webfaction.com.  3600    IN  A   207.38.86.18

[...]
```

Una vez que los cambios en el DNS se han propagado ...

```bash
$ dig demos.noenieto.com
[...]

;; ANSWER SECTION:
demos.noenieto.com. 1799    IN  A   207.38.86.18
[...]
```
... el registro del certificado funciona bien:

```bash
$ letsencrypt_webfaction --endpoint https://acme-staging.api.letsencrypt.org/ --config=$HOME/letsencrypt/demos_noenieto_com.yml 
Your new certificate is now created and installed.
You will need to change your application to use the demos_noenieto_com certificate.
Add the `--quiet` parameter in your cron task to remove this message.

```
