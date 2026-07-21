---
title: "Convierte texto seleccionado a enlaces en Google Docs"
summary: "Guía para crear un guión de AppsScript que transforme el texto seleccionado en un documento de Google Docs"
description: "Tutorial completo para crear un script de Google Apps Script que convierte texto seleccionado en enlaces automáticamente en Google Docs, ideal para procesar logs de Jenkins."
date: "2024-08-06"
categories: []
tags:
  - google docs
  - apps script
  - javascript
  - automation
image: "/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/six-assorted-geometrical-objects-besides-a-sheet-w.svg"
preview: "/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/apps-script-new-menu-registered.png"
locale: "es_MX"
keywords: []
---

## ¿Por qué quise convertir el texto seleccionado a enlaces?

Durante muchas semanas, todos los días, tuve que hacer una tarea bastante repetitiva en un documento de Google Docs: editar texto y convertirlo en links. Me cansé de hacerlo e hice un pequeño script para que lo haga por mi. Tal vez te sirva a ti también.

El proceso requeria copiar texto plano del log de un proceso en Jenkins y pegarlo en Google Docs. El texto lucia asi:

```
FAILED! process1 https://example.com/job_status/127435/32606664
FAILED! process2 https://example.com/job_status/127435/32606665
FAILED! process3 https://example.com/job_status/127435/32606666
FAILED! process4 https://example.com/job_status/127435/32606667
```

Luego hacia un proceso manual de edicion en cada cada linea:

1. Seleccionar y borrar la palabra FAILED.
2. Seleccionar y cortar el link
3. Seleccionar la palabra restante (por ejemplo, `process1`), presionar <kbd>Ctrl</kbd>+<kbd>K</kbd> (O <kbd>⌘</kbd>+<kbd>K</kbd> en mac) para abrir el dialogo para insertar links. Luego pegar el link que corté.

Si fueran 3 o 4 lineas no habria problema, pero a veces son docenas! Recientemente descubri que AppsScript esta disponible en Google Docs. Entonces pense en hacer un programa de JavaScript que por cada linea de texto hiciera lo siguiente:

1. Corta la cadena tomando los espacios delimitadores. Va a contener 3 elementos.
2. Reemplaza la linea de texto por el link con el segundo y tercer elemento del arreglo.

Ok. Manos a la obra! ... OK, Como empiezo?

### Breve intro a AppsScript

Le pregunte a ChatGpt que me describiera rapidamente que es AppScript. Esto es lo que me dijo:

> Google Apps Script es una plataforma basada en JavaScript que permite a los usuarios automatizar tareas y extender la funcionalidad de las aplicaciones de Google Workspace, como Google Docs, Sheets, Slides, y Forms. Los scripts se escriben en JavaScript. Puedes usar las APIs específicas de Google Apps Script para interactuar con Google Docs y otros servicios de Google. Puedes automatizar tareas repetitivas, como formatear texto, crear tablas, insertar imágenes, y mucho más.
También puedes extender la funcionalidad de Google Docs añadiendo menús personalizados, barras laterales, y cuadros de diálogo.

¿Ok, y cómo empiezo con el Editor de Scripts?: Puedes acceder al editor de scripts en *Google Docs* yendo a `Extensiones` > `Apps Script`.

![Acceso al menu de Apps Script desde Google Docs.](/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/apps-script-menu.png)

Esto abrirá el entorno de desarrollo de Apps Script donde puedes escribir y gestionar tus scripts.

![Entorno de desarrollo de Apps Script](/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/apps-script-ide.png)

Ya dentro de AppsScript tenemos acceso al API de Google Docs. En este ejemplo quiero un menú personalizado que ejecute la funcion que dsescribí anteriormente. En Apps Script existe una funcion especial `onOpen`. Esta funcion se va a ejecutarse automáticamente cuando se abre el documento de Google Docs. Cuando se ejecute, voy a registrar el menu que ejecutará la funcion que quiero. Gracias a ChatGPT, rapidamente pude saber la secuencia de comandos a ejecutar para registrar el menu:

1. Obtener la interfaz de usuario del documento:

```js
DocumentApp.getUi()
```

Esto obtiene la interfaz de usuario del documento de Google Docs actual.

2. Crear un nuevo menú personalizado:

```js
.createMenu('Mis Scripts')
```

Esto crea un nuevo menú en la barra de menús del documento con el título 'Mis Scripts'.

3. Añadir un elemento de menú para ejecutar mi función:

```js
.addItem('Crear links a partir del texto seleccionado', 'createLinksFromSelectedText')
```

Esto añade un elemento al menú personalizado creado en el paso anterior. El elemento del menú se llama **'Crear links a partir del texto seleccionado'**, y cuando se selecciona este elemento, se llamará a la función `createLinksFromSelectedText`.

4. Finalmente, se añade el menú personalizado a la interfaz de usuario:

```js
.addToUi();
```

Esto añade el menú personalizado a la interfaz de usuario del documento, haciendo que esté disponible para el usuario.

El codigo fuente se ve asi:

```js
function onOpen() {
  DocumentApp.getUi().createMenu('Mis Scripts')
      .addItem('Crear links a partir del texto seleccionado', 'createLinksFromSelectedText')
      .addToUi();
}

function createLinksFromSelectedText() {
}
```

Ahora es momento de ejecutar la funcion. Para eso, primero guardamos (1), y luego corremos la funcion (2):

![Guardar y correr la funcion](/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/apps-script-save-and-run.png)

**Nota**: Cuando ejecutas un script por primera vez, Google te pedirá que autorices el script para acceder a tus datos de Google Docs. Esto es para asegurar que el script tiene permiso para realizar las acciones necesarias.

![La primera vez que corres la funcion te pide autorizacion](/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/apps-script-auth-required.png)

Despues de correr la funcion, abrimos de nuevo nuestro documento y ya veremos que se registro el nuevo menu:

![El menu ya esta registrado](/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/apps-script-new-menu-registered.png)

Si hacemos click en el menu no va a pasar nada porque la funcion `createLinksFromSelectedText` aun no hace nada. Pero a continuacion vamos a solucionar esto.

### La funcion que genera los links

Ahora es momento escribir la funcion que genera los links. Aca va una explicacion de lo que hace:

1. Obtiene el documento activo y la selección:

```js
var doc = DocumentApp.getActiveDocument();
var selection = doc.getSelection();
```

2. Verifica si hay texto seleccionado: Si no hay ninguna selección, muestra una alerta al usuario y termina la ejecución de la función.

```js
if (!selection) {
  DocumentApp.getUi().alert('Primero selecciona algo de texto.');
  return;
}
```

3. Obtiene una lista de los elementos seleccionados:

```js
var selectedElements = selection.getRangeElements();
```

4. Itera sobre cada elemento seleccionado: Para cada elemento, verifica si puede ser editado como texto. Si no puede (por ejemplo, si es una imagen o una tabla), lo salta.

```js
selectedElements.forEach(function(element) {
  if (element.getElement().editAsText) {
    // Obtiene el texto seleccionado, solo una linea a la vez
    var text = element.getElement().asText().editAsText();
    var selectedText = text.getText();

    // Divide el texto seleccionado en partes usando espacios en blanco como delimitadores.
    var parts = selectedText.trim().split(/\s+/);


    // Si hay al menos dos partes, toma la segunda parte como el título y la tercera parte como la URL.
    if (parts.length >= 2) {
      var title = parts[1];
      var url = parts[2];
      // Reemplaza el texto seleccionado con el título y establece el enlace URL correspondiente
      text.setText(title);
      text.setLinkUrl(url);
    }
  }
});
```

Finalmente guardamos. Haremos tres pruebas. Primero vamos a ver que pasa cuando no seleccionas nada:

![Si no seleccionas texto te sale una alerta](/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/apps-script-no-selection.png)

Muy bien, ahora pondremos el texto que queremos que convierta:

![Texto para convertir](/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/apps-scripts-select-text.png)

**Nota**: No olvides seleccionar el texto.

Y vamos a ver el resultado:

![Texto convertido a links](/static/images/posts/convierte-texto-seleccionado-enlaces-en-google-docs/apps-scripts-converted-text.png)

!SI!

¿Qué te pareció? !Si te agrado o te sirvió te agradeceria me lo hicieras saber en los comentarios!
