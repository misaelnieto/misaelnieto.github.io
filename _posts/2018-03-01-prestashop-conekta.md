---
published: false
---
## Guia de instalacion del plugin de conekta en prestashop 1.7

Tengo instalado PS 1.7.x y soy nuevo usuario de prestashop. La instalacion del modulo de prestashop se me ha complicado un poco. Por eso estoy anotando los pasos a seguir.

1. Instala Prestashop (Link: como hacerlo en Fedora)
2. Configura el sitio con HTTPS (Link: como hacerlo con letsencrypt en webfaction)
3. Instala el plugin de prestashop.
	- Descargar el archivo zip con la ultima version del plugin.
	- Modules -> Modules and Services -> Upload Module
	- Instalar
4. Configura el plugin de prestashop
	- Modules -> Installed Modules -> Conekta prestasop -> Configure
	- Llenar el formulario de detalles de contacto.
    - Para empezar hay que poner el modo de funcionamiento en Sandbox.
    - Selecciona los métodos de pago habilitados. Yo sólo seleccioné _Card_ y _Cash_.
    - Ir al panel de administración de Conekta y ahí abrir la sección de las llaves del API.