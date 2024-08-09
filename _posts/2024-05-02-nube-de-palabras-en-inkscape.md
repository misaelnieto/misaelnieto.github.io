---
layout: post
title: Nube de palabras en Inkscape
categories:
   - Diseño
   - Español
tags: inkscape
summary: Pequeña guía para hacer una nube de palabras (o tag cloud) en Inkscape
image: https://unsplash.com/es/fotos/texto-manuscrito-00nHr1Lpq6w
published: true
hero_svg: /media/heroes/signal.svg
image: /media/card_images/wall-of-words.svg
language: es
date: 2024-05-02
---

## Nube de palabras en Inkscape

Este es una traducción al español, aumentada, de una 
[guia en stack exchange](https://graphicdesign.stackexchange.com/questions/64892/make-words-art-in-inkscape-how-can-i-cut-the-words-out-of-a-shape) 
de como hacer una nube de palabras con Inskcape.



### Paso 1: Abrir Inscape

Instala inkscape si es que no lo tienes instalado. Abre inkscape y crea un nuevo documento.

### Paso 2: Crear Palabras

El primer paso es generar las palabras. Lo que yo hice fue escribir **Lorem Ipsum** en dos fuentes diferentes 
(Sans y Sans Serif), diferentes orientaciones y tamaños. Mi ejemplo quedó así:

![Nube de palabras, Primera version](/media/nube-palabras-inkscape/01.png)

### Paso 3: Dibujar una forma

Ahora voy a dibujar una [forma cerrada](https://inkscape.org/es-mx/doc/tutorials/shapes/tutorial-shapes.html). 
El ejemplo de Stack overflow un corazoncito, yo voy a usar una estrella de cinco picos. No olvides mandar la forma hacia
el fondo.

Ahora queda así:

![Nube de palabras, Segunda version](/media/nube-palabras-inkscape/02.png)

### Paso 4: Ajustando el color

Voy a cambiar el color de la estrella y el texto para que el ejemplo quede más claro adelante.

1. Lo primero va a ser cambiar el color de la estrella. Va a ser de color verde. Solo necesito seleccionar la estrella y 
cambiarle el color con la herramienta de relleno y borde. El relleno sera `26ae00ff`. El borde esta desactivado.
2. Ahora, necesitamos seleccionar todo el texto. Una manera de hacerlo es seleccionar uno por uno, pero como verás, son 
muchos objetos de texto. Una manera de poder seleccionarlos fácil es mover la estrella fuera del area de trabajo para
poder seleccionar todos los objetos de texto con el mouse. Pero mi esposa me enseñó otra manera más fácil: Selecciono 
cualquier objeto de texto. Luego, en el menú contextual (que sale dando click con el botón derecho del mouse), escogí 
"Seleccionar mismo" ‣ "Tipo de objeto".
![Nube de palabras, seleccionando todos los objetos de texto](/media/nube-palabras-inkscape/03.png)
3. Ya que estan seleccionados todos los objetos de texto, aproveche para ajustar el color del trazo de las letras a 
negro (aunque el color no importa mucho después del recorte). Ahora se ve asi:
![Nube de palabras, cambio de colores](/media/nube-palabras-inkscape/04.png)
4. Finalmente voy a agrupar los objetos de texto seleccionados. El menú es **Objeto** ‣ **Agrupar**

### Paso 5 Aplicar recorte

El siguiente paso es seleccionar los dos objetos, la estrella y el texto. Como es lo único que hay en mi archivo 
puedo seleccionar todo con **Edición** ‣ **Seleccionar Todo** (O Ctrl+E en Windows en español, Ctrl+A en Windows en inglés y 
Linux o Cmd+A en Mac.)

Y llegamos a la parte la parte más importante: _El recorte_. Ya que estan seleccionados los dos objetos principales (la estrella 
y el bonche de texto), aplicamos el recorte con el menú **Objeto** ‣ **Recorte** ‣ **Aplicar Recorte**. El resultado 
es el siguiente:
![Nube de palabras, Texto recortado](/media/nube-palabras-inkscape/05.png)

### Paso 6: Agregando fondo a la estrella

Para agregar un fondo a la estrella tendremos que hacer un duplicado de la estrella verde original. !Pero ya no esta visible! 
Qué puedo hacer?

1. Deshacer el recorte temporalmente con **Objeto** > **Recorte** > **Liberar recorte**. También se puede hacer con el menú contextual.
    ![Nube de palabras, Liberar recorte](/media/nube-palabras-inkscape/06.png)
2. Selecciona la estrella y copiala. !Aun no la pegues!
   ![Nube de palabras, Copia la estrella](/media/nube-palabras-inkscape/07.png)
3. Selecciona de nuevo la estrella y el texto y vuelve a aplicar el recorte con el menú **Objeto** ‣ **Recorte** ‣ **Aplicar Recorte**.
4. Pega la estrella y ajusta el color de fondo, o el contorno, o las dos cosas!
   ![Nube de palabras, Texto recortado](/media/nube-palabras-inkscape/08.png)


### Resumen

Aprendí a generar nubes de texto aplicando un recorte de una forma cualquiera sobre un grupo de texto.

