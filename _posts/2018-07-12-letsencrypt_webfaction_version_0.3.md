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
El script anterior `~/bin/letsencrypt_webfaction` lo dejé de usar y lo borré.


## Inicialización del archivo de configuración:

Una de las novedades de la versión 0.3 de `letsencrypt_webfaction` es que el script ya no acepta ningun parámetro en la línea de comando, excepto por `init` y `run`. Cuando corres el comando `init` se crea el archivo `~/letsencrypt_webfaction.toml`

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
## Pruebas

Primero probamos con staging

```bash
 letsencrypt_webfaction run
-64 days until expiration of demos_noenieto_com. Renewing...
Your new certificate is now created and installed.
You will need to change your application to use the demos_noenieto_com certificate.
Add the `--quiet` parameter in your cron task to remove this message.
```

Después de correr el comando pude ver que el certificado ya se había actualizado en el panel de control de webfaction y además mi sitio ya estaba usando el nuevo certificado (aunque es inválido por que usé el servidor staging de letsencrypt.

Ahora sólo falta configurar el sitio web para que use el endpoint de producción (editando el archivo .toml)

### Cronjob para renovación de certificados

Con esta nueva version todo va a estar concentrado en un solo archivo de configuración, así que todos los certificados se van a renovar al mismo tiempo. Otro cambio importante con esta nueva version es que esta pensada para que el cronjob de renovación de certificados se corra una vez al día. 

Como en la ocasión anterior, los certificados de Let's encrypt sólo [duran sólo 90 días](https://letsencrypt.org/2015/11/09/why-90-days.html). El servidor de producción de letsencrypt te limita a 5 certificados por dominio cada 7 días. Pero parece que no va a haber problema si `letsencrypt_webfaction` corre diariamente por que detecta cuánto falta para renovar cierto certificado. Corrí el comando de nuevo como proueba y ahora el resultado fue distinto:

```bash
$ letsencrypt_webfaction run
90 days until expiration of demos_noenieto_com. Skipping...
```

Habiendo considerado todo esto, el crojob va a quedar así:

```cron
# Let's encrypt
18 3 * * *     PATH=$PATH:$GEM_HOME/bin:/usr/local/bin GEM_HOME=$HOME/.letsencrypt_webfaction/gems RUBYLIB=$GEM_HOME/lib ruby2.2 $HOME/.letsencrypt_webfaction/gems/bin/letsencrypt_webfaction run --quiet
```

Con esto se correrá letsencrypy_webfaction rodos los dias a las 3:18 am.

### Notificacion por email

En este momento no voy programer notificacion mediante email, por que se estaría enviando diariamente y no tiene caso.

## Fin
Eso es todo amigos.