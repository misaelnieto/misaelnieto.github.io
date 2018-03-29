---
published: false
---
## Django Oscar con Paypal

Mis notas de cómo configurar Django Oscar con PayU

## Parte 1 - Instalación y configuración de Django-Oscar

Recomiendo usar un virtualenv para oscar.

```bash
mkvirtualenv --python=python3 oscar
```

Si ya tienes un virtualenv o regresas a continuar con la tarea:

```bash
workon oscar
```

Es momento de instalar las dependencias

```bash
pip install django-oscar django-compressor
```

Luego creamos un directorio para guardar el proyecto y generamos un proyecto nuevo de Django con `manage.py`.

```bash
mkdir -p Documents/Django-Oscar/
cd Documents/Django-Oscar/
django-admin.py startproject frobshop
cd frobshop
```

Ahora procedemos a configurar el proyecto; el proceso de instalación ya esta descrito en el [manual de Oscar](https://django-oscar.readthedocs.io/en/releases-1.5/internals/getting_started.html#django-settings), asi que no se si valga la pena compartirlo de nuevo. El proceso se resume en que dentro de `frobshop` se modifican `settings.py` y `urls.py`. Para conveniencia, pego el contenido de los archivos directamente.

El archivo `settings.py` es el siguiente:

```python
import os
from oscar.defaults import *
from oscar import OSCAR_MAIN_TEMPLATE_DIR
from oscar import get_core_apps


BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SECRET_KEY = '$1c_o*5bszwvjzel-brpfqx!+4t==fjwrpa!xtj-^8-#=q1m56'
DEBUG = True
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
    'debug_toolbar',
] + get_core_apps()
SITE_ID = 1
MIDDLEWARE = [
    'debug_toolbar.middleware.DebugToolbarMiddleware',
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
            OSCAR_MAIN_TEMPLATE_DIR,
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.template.context_processors.i18n',
                'django.contrib.messages.context_processors.messages',
                # Oscar
                'oscar.apps.checkout.context_processors.checkout',
                'oscar.apps.customer.notifications.context_processors.notifications',
                'oscar.apps.promotions.context_processors.promotions',
                'oscar.apps.search.context_processors.search_form',
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
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
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

# PayU

```

El archivo `urls.py` queda asi:

```python
from django.conf.urls import include, url
from django.contrib import admin
from django.conf import settings

from oscar.app import application as oscar_app

urlpatterns = [
    url(r'^i18n/', include('django.conf.urls.i18n')),
    url(r'^admin/', admin.site.urls),
    url(r'', include(oscar_app.urls)),
]

if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        url(r'^__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns

```

Antes de crear la base de datos hay que instalar y configurar django-oscar-payu.


## Paso 3 - instalacion de django-oscar-payu

Instalar django-oscar-payu con pip no da buenos resultados. Parece que al momento de escribir esta guia la ultima version de django-oscar-payu en pypi no es la misma que esta en el repositorio git. Es por esto que lo mejor por el momento es instalar directamente desde el [repo git](https://github.com/SalahAdDin/django-oscar-payu/).

```bash
git clone git@github.com:SalahAdDin/django-oscar-payu.git
cd django-oscar-payu
python setup.py develop
```

Esto instala django-oscar-payu con la ultima version del plugin.

Ahora agregar lo siguiente hasta abajo de settings.py

```python
INSTALLED_APPS.append('payu')
PAYU_INFO = {
    'INR': {
        'merchant_key': "1287123",
        'merchant_salt': "pCsDoLxi",
        # for production environment use 'https://secure.payu.in/_payment'
        'payment_url': 'https://test.payu.in/_payment',
    }
}
```

Esta información la sacas del panel de control de payu
