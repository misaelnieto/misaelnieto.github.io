---
published: false
---
## Django Oscar con Paypal

Mis notas de cómo configurar Django Oscar con PayU

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
```

El archivo `urls.py` queda asi:

```python
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

Esta informacin la sacas del panel de control de pahyu

