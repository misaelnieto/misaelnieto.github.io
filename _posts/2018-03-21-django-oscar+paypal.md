---
published: false
---
## Django Oscar con Paypal

Mis notas de cómo configurar Django Oscar con paypal.

## Parte 1 - Instalacíon y configuración de Django-Oscar

Recomiendo usar un virtualenv para oscar.

```bash
mkvirtualenv --python=python3 oscar
```

Si ya tienes un virtualenv o regresas a continuar con la tarea:

```bash
workon oscar
```

Luego creamos un directorio para guardar el proyecto y generamos un proyecto nuevo de Django con `manage.py`.

```bash
mkdir -p Documents/Django-Oscar/
cd Documents/Django-Oscar/
django-admin.py startproject frobshop
cd frobshop
```
Ahora es momento de configurar el proyecto; el proceso de instalación ya esta descrito en el [manual de Oscar](https://django-oscar.readthedocs.io/en/releases-1.5/internals/getting_started.html#django-settings), asi que no se si valga la pena compartirlo de nuevo. El proceso se resume en que dentro de `frobshop` se modifican `settings.py` y `urls.py`. Para conveniencia, pego el contenido de los archivos directamente.

El archivo `settings.py` es el siguiente:

```python
import os
from oscar.defaults import *
from oscar import OSCAR_MAIN_TEMPLATE_DIR
from oscar import get_core_apps


BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SECRET_KEY = ')_qry+6jku32tpqghn$!prp#mzb=!(d=c)jq!ezzw6!fc*a2ps'
DEBUG = True
ALLOWED_HOSTS = []
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'django.contrib.flatpages',
    'compressor',
    'widget_tweaks',
]+ get_core_apps()
SITE_ID=1
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'oscar.apps.basket.middleware.BasketMiddleware',
    'django.contrib.flatpages.middleware.FlatpageFallbackMiddleware',
]

ROOT_URLCONF = 'frobshop.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE_DIR, 'templates'),
            OSCAR_MAIN_TEMPLATE_DIR
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.template.context_processors.i18n',
                'django.contrib.messages.context_processors.messages',
                'oscar.apps.search.context_processors.search_form',
                'oscar.apps.promotions.context_processors.promotions',
                'oscar.apps.checkout.context_processors.checkout',
                'oscar.apps.customer.notifications.context_processors.notifications',
                'oscar.core.context_processors.metadata',
            ],
        },
    },
]
WSGI_APPLICATION = 'frobshop.wsgi.application'
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        'ATOMIC_REQUESTS': True,
    }
}
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_L10N = True
USE_TZ = True
AUTHENTICATION_BACKENDS = (
    'oscar.apps.customer.auth_backends.EmailBackend',
    'django.contrib.auth.backends.ModelBackend',
)
STATIC_ROOT = os.path.join(BASE_DIR, 'static')
STATIC_URL = '/static/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'

HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.simple_backend.SimpleEngine',
    },
}

OSCAR_INITIAL_ORDER_STATUS = 'Pending'
OSCAR_INITIAL_LINE_STATUS = 'Pending'
OSCAR_ORDER_STATUS_PIPELINE = {
    'Pending': ('Being processed', 'Cancelled',),
    'Being processed': ('Processed', 'Cancelled',),
    'Cancelled': (),
}
```
El archivo `urls.py` queda asi:

```python
from django.conf.urls import include, url
from django.contrib import admin
from oscar.app import application


urlpatterns = [
    url(r'^i18n/', include('django.conf.urls.i18n')),
    url(r'^admin/', admin.site.urls),
    url(r'', include(application.urls)),
]
```

Es momento de instalar las dependencias

```bash
pip install django-oscar django-compressor
```

Ahora que tenemos toda la configuración podemos crear la base de datos.

```bash
./manage.py migrate
```

Es un proceso un poco largo, pero se ve parecido a lo anterior:

```bash
(oscar) [nnieto@3c273 frobshop] $ ./manage.py migrate
Operations to perform:
  Apply all migrations: address, admin, analytics, auth, basket, catalogue, contenttypes, customer, flatpages, offer, order, partner, payment, promotions, reviews, sessions, shipping, sites, thumbnail, voucher, wishlists
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying address.0001_initial... OK
  [ ...] 
  Applying sites.0002_alter_domain_unique... OK
  Applying thumbnail.0001_initial... OK
  Applying voucher.0002_auto_20170418_2132... OK
  Applying wishlists.0001_initial... OK
  Applying wishlists.0002_auto_20160111_1108... OK
(oscar) [nnieto@3c273 frobshop] $
```

Es necesario crear un superusuario para poder entrar al dashboard/panel de control de Oscar.

./manage.py createsuperuser

```
(oscar) [nnieto@3c273 frobshop] $ ./manage.py createsuperuser
Username (leave blank to use 'nnieto'): admin
Email address: nnieto@noenieto.com
Password: 
Password (again): 
Superuser created successfully.

```

La guia dice que es buena idea crear la lista de paises. Esta lista se usa para cuando el cliente llena el formulario de dirección de envío.

python manage.py oscar_populate_countries

```
(oscar) [nnieto@3c273 frobshop] $ python manage.py oscar_populate_countries
Successfully added 249 countries.
(oscar) [nnieto@3c273 frobshop] $ 

```

Ahora es momento de arrancar Django:

```bash
./manage.py runserver
```

Y aqui tienes, una tienda de Oscar recien creada:

![Vainilla]({{site.baseurl}}/media/Screenshot-2018-3-21 Oscar -.png)


## Parte 2 - Instalación y configuración del plugin de PayPal

Ahora es el momento de hacer la configuración del modulo de pagos para paypal.

pip install django-oscar-paypal ??