Mini tutorial de AngularJS
==========================

.. author:: default
.. categories:: none
.. tags:: none
.. comments::

Intro
-----

AngularJS es un framework para crear aplicaciones web del lado del cliente y está escrito en
JavaScript. AngularJS funciona mediante la extensión del vocabulario HTML del navegador web. Lo que
resulta de este proceso es una aplicación web que resulta fácil de programar, entender y desarrollar.

El sitio oficial del framework se encuentra en http://angularjs.org

Enseñándole nuevos trucos al navegador
--------------------------------------

Una de las nociones principales detrás del diseño de AngularJS es que HTML no fue diseñado para
construir aplicaciones dinámicas, sino para describir documentos estructurados y estáticos. Los
desarrolladores de AngularJS diseñaron el framework para que puediera extender el vocabulario
disponible de HTML para que se ajuste a cualquier aplicación web.


Modelo, vista y controlador
---------------------------

AngularJS es un framework MVC para JavaScript, y solo corre en el navegador web. La vista es el DOM
(Document Object Model), que ha sido extendido por AngularJS para hacer nuevos trucos. El modelo es
cualquier primitiva, lista u objeto de JavaScript y el controlador es una simple función que toma,
al menos, un parámetro llamado ``$scope``.

Pongamos manos a la obra.

.. code-block :: html

    <doctype html>
    <html ng-app>
    <head>
        <title>AngularJS - MVC</title>
        <meta charset="utf-8" />
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.0.6/angular.min.js"></script>
        <script type="text/javascript">
        function Controlador($scope) {
            $scope.modelo = {
                texto: 'Hola mundo',
                numero: 3.1416
            }
        }
        </script>
    </head>
    <body ng-controller="Controlador">
        <h1>AngularJS es un framewrok MVC</h1>
        <h3>El HTML DOM se convierte en la vista/plantilla</h3>
        <ul>
            <li>Texto: {{modelo.texto}}</li>
            <li>Número: {{modelo.numero}}</li>
        </ul>
    </body>
    </html>

AngularJS se carga en la línea 2. Conecta una retrollamada para el evento ``document.onLoad`` para
recorrer todo el DOM (que ya ha sido compilado por el navegador en ese momento) en busca de
*directivas*. La primera *directiva* que encontrará será en la línea 2: ``<html ng-app>``. La
directiva ``ng- app`` le indica a AngularJS que se trata de una aplicación de AngularJS, así que
prepara todo lo necesario.

Luego, en la línea 7 se declara la función ``Controlador``. En ese script no hay nada que la
ejecute, así que se queda cargada en memoria.

En la línea 16, se encuentra la directive ``ng-controller`` como un atributo del elemento
``<body>``. El valor de ese elemento es el nombre del controlador, que en nuestro caso es
``Controlador`` y ya se ha declarado previamente. AngularJS creará una ``scope`` y lo pasará como
parámetro a una nueva instancia de ``Controlador``.

``$scope`` es un objeto que nos permitirá enlazar el controlador con el modelo de datos. Eso es
justamente lo que se hace en la llamada de la función: crear un objeto llamado ``modelo`` dentro de
``$scope``. AngularJS pondrá a disposición de la vista todas las propiedades del objeto ``$scope``.

Y justamente eso es lo que se hace en las líneas 20 y 21

