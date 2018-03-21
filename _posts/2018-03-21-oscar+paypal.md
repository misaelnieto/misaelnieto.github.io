---
published: false
---
## Django Oscar con Paypal

Mis notas de cómo configurar una pagina de ecommerce con Django Oscar.


mkdir -p Documents/Django-Oscar/
cd Dopcuments/Django-Oscar/
pip install django-oscar django-compressor
django-admin.py startproject frobshop
cd frobshop

Configurar frobshop/settings.py y frobshop/urls.py


./manage.py migrate

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
