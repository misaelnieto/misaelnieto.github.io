---
published: false
---
Esta es mi guia de instalacion de payu en django-oscar.

## Paso 1 - Instalar Django-Oscar

Link al post anterior.

## Paso 2 - instalacion de django-oscar-payu

Instalar django-oscar-payu/ con pip no da buenos resultados. Lo mejor por el momento es instalar directamente desde el [repo git](https://github.com/SalahAdDin/django-oscar-payu/).

git clone git@github.com:SalahAdDin/django-oscar-payu.git

workon oscar

cd django-oscar-payu
python setup.py develop

Esto instala django-oscar-payu con la ultima version delplugin.

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