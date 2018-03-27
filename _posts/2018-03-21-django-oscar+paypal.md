---
published: true
category: django ecommerce django-oscar paypal español
tags:
  - django
  - ecommerce
  - django-oscar
  - paypal
  - español
layout: post
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

Ya tenemos toda la configuración; El siguiente paso es crear la base de datos.

```bash
./manage.py migrate
```

La creación de la base de datos es un proceso un poco largo, pero se ve parecido a esto:

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

Luego es necesario crear un superusuario para poder entrar al dashboard/panel de control de Oscar.

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

```
python manage.py oscar_populate_countries
```

Ahora es momento de arrancar Django:

```bash
./manage.py runserver
```

Y aqui tienes, una tienda de Oscar recien creada:

![Oscar sabor vainilla]({{site.baseurl}}/media/Screenshot-2018-3-21 Oscar -.png)


## Parte 2 - Instalación y configuración del plugin de PayPal

El nombre del paquete/Wheel es `django-oscar-paypal`:

```bash
pip install django-oscar-paypal
```
Nota: Este modulo tiene dos metodos de pago: _Express Checkout_ y _PayFlow Pro_. En esta ocasión solo voy a usar _Express Checkout_. 

Ahora es el momento de hacer la configuración del modulo de pagos para paypal. Primero modificamos `settings.py` y agregamos hasta abajo lo siguiente:

```python
INSTALLED_APPS.append('paypal')
PAYPAL_API_USERNAME = 'test_xxxx.gmail.com'
PAYPAL_API_PASSWORD = '123456789'
PAYPAL_API_SIGNATURE = 'A93x6mGy1E8MD85gDtAMJnvfVBZxBYE96KO1aoRnPezYvM4OGPaxNhAjB'
```

Voy a usar la consola de paypal para hacer las pruebas con el entorno _sandbox_. Primero hay que entrar a la consola de paypal para desarrolladores en https://developer.paypal.com/ . Es recomendable crear al menos dos usuarios en _Sandbox_->_Accounts_. Asegurate que el usuario que vas a usar como vendedor sea usuario _Business_ por que los usuarios personales no tienen credenciales para uso del API.

El email, la contraseña y la firma para el API los encuentras abriendo el perfil de usuario.

![Primero abre el usuario]({{site.baseurl}}/media/Screenshot-2018-3-25 Sandbox accounts - PayPal Developer.png)

![Luego encontrarás las credenciales]({{site.baseurl}}/media/Screenshot-2018-3-25 Sandbox accounts - PayPal Developer(1).png)

Despues de esto hay que modificar `urls.py` para agregar las urls de la aplicacion de paypal. El archivo queda asi:

``python
from django.conf.urls import include, url
from django.contrib import admin
from oscar.app import application as oscar_app
from paypal.express.dashboard.app import application as paypal_app

urlpatterns = [
    url(r'^i18n/', include('django.conf.urls.i18n')),
    url(r'^admin/', admin.site.urls),
    url(r'^checkout/paypal/', include('paypal.express.urls')),
    url(r'^dashboard/paypal/express/', include(paypal_app.urls)),
    url(r'', include(oscar_app.urls)),
]

``

El modulo de paypal tiene una pagina de reporte de transacciones. Sera muy util si incluimos un link a esa pagina desde el dashboard. Esto se logra agregando un elemento mas a `OSCAR_DASHBOARD_NAVIGATION`.

```python
from django.utils.translation import ugettext_lazy as _
OSCAR_DASHBOARD_NAVIGATION.append(
    {
        'label': _('Payments'),
        'icon': 'icon-globe',
        'children': [
            {
                'label': _('Paypal Express transactions'),
                'url_name': 'paypal-express-list',
            },
        ]
    })
```

Lo que sigue es modificar la plantilla del carrito para que aparezca el boton de pago con paypal. Pero primero hay que crear el directorio para las plantillas:

```bash
$ pwd
/home/nnieto/Code/Django-Oscar/frobshop_paypal
$ mkdir -p templates/basket/partials/
```

Hay que crear la plantilla `templates/basket/partials/basket_content.html` con el siguiente contenido:

```python
{% raw %}
{% extends 'oscar/basket/partials/basket_content.html' %}
{% load i18n %}
{% load url from future %}

{% block formactions %}
<div class="form-actions">
    {% if anon_checkout_allowed or request.user.is_authenticated %}
        <a href="{% url 'paypal-redirect' %}"><img src="https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif" align="left" style="margin-right:7px;"></a>
    {% endif %}
    <a href="{% url 'checkout:index' %}" class="pull-right btn btn-large btn-primary">{% trans "Proceed to checkout" %}</a>
</div>
{% endblock %}
{% endraw %}
```

No hay que olvidar correr las migraciones:

```bash
./manage.py migrate
```

Despues de arrancar Django podemos ver que en el dashboard ya se creó el menu `Payments`:

![Ahi esta funciona.]({{site.baseurl}}/media/qjQt4Md2pm.png)


Pero todavia queda varias tareas por hacer.

1. Agregar un usuario para compras: pedro.perez@dominio.com
2. Agregar un Agregar una categoria: Title: Psicohistoria
3. Agregar un Partner: Title: default
4. Agregar un producto:
   1. Title: Bruno, Leibnitz, Vico y Thoureau
   2. UPC: BLVT
   3. Description: Lo que sea, un lorem ipsum o algo asi.
   4. Is discountable: Si
   5. Categories: Selecciona la categoria que acabas de crear.
   6. Stock and Pricing:
      1. Partner: default
      2. SKU: BLVT
      3. Currency: USD
      4. Images: Sube una imagen
      5. Cost Price, Price excl. tax, Retail price: 10
      6. Variants: ninguna
      7. Upselling: nada

## Parte 3 - Pruebas

Una vez terminado todo esto podemos entrar al la tienda usando la cuenta de pedro perez y abres el producto y abrimos el producto que acabamos de crear.

![Listo a comprar el producto]({{site.baseurl}}/media/A8kFaYlaxL.png)

Despues de agrgegar el producto al carrito podemos ir al carrito para ver las opciones de pago y ahi en la ezquina inferior izquierda tenemos el boton de pago de paypal. Por el momento no nos preocuparemos mucho por lo estetico ya que estamos probando funcionalidad.

![Ahi esta el icono amarillo de Paypal]({{site.baseurl}}/media/Screenshot-2018-3-26 Cart Oscar -.png)

Pero antes de hacer click en el boton amarillo de Paypal es necesario poder recibir notificaciones de Paypal directamente en mi instancia de django en localhost, y esto se hace posible gracias a [ngrok](https://ngrok.com/). `ngrok` es un servicio gratuito para pruebas de este tipo. Y configurarlo es bastante fácil: `./ngrok`.

![ngrok haciendo un tunel.]({{site.baseurl}}/media/Screenshot from 2018-03-26 19-14-54.png)

Nota: hay que agregar 5603f7b3.ngrok.io a la lista de  ALLOWED_HOSTS por que si no Django va a fallar con el error `DisallowedHost at /`.

Ahora si, ya todo esta listo para hacer el pago, presionemos el botón de Paypal y nos vamos a la pantalla de 
login del sandbox de Paypal.

![Hay que usar alguna cuenta creada en la consola de pruebas de Paypal.]({{site.baseurl}}/media/Screenshot-2018-3-26 Pagar con mi cuenta PayPal - PayPal(1).png)

Para poder pagar hay que usar alguna cuenta creada en la consola de pruebas de Paypal. Despues de hacer login pasamos a revisar la informacion de cobro y pago.

![Ultima revision antes de pagar.]({{site.baseurl}}/media/Screenshot-2018-3-26 Revise su información.png)

Despues de presionar el boton amarillo de Continuar, paypal nos redirigirá de regreso a la tienda:

![De regreso a Oscar]({{site.baseurl}}/media/Screenshot-2018-3-26 Order preview Checkout Oscar -.png)

Ya solo falta presionar el boton azul de _Place Order_ y el proceso de compra y pago ha terminado.

Pheww!
