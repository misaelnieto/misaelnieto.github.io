---
title: Celda solar sencilla con Silvaco TCAD
date: 2017-08-15
description: 'Tutorial introductorio para modelar y simular una celda solar de silicio simple con Silvaco TCAD Atlas: malla, regiones, dopados, contactos, iluminación AM1.5 y curva I-V.'
image: /static/images/posts/Celda-solar-sencilla-con-Silvaco/photovoltaik-2872071.svg
tags:
- silvaco
- tcad
- celda-solar
- fotovoltaica
- simulacion
- atlas
- semiconductores
---

![Photovoltaik](/static/images/posts/Celda-solar-sencilla-con-Silvaco/photovoltaik-2872071.svg)

## Intro

Silvaco es una compañía que hace un software llamado TCAD (Technology
Computer-Aided Design) para la simulación de procesos de fabricación de
dispositivos semiconductores y la simulación del comportamiento eléctrico,
óptico y térmico de tales dispositivos. En la maestría en ingeniería eléctrica
tomé la materia de simulación de semiconductores, dictada por el Dr. Julio
Molina, donde vimos los fundamentos del funcionamiento de Silvaco TCAD.

La herramienta se distribuye principalmente para dos grandes tareas: simulación
de **procesos** y simulación de **dispositivos**. Para la simulación de
dispositivos la herramienta principal se llama Atlas.

## El dispositivo

Vamos a simular una celda solar muy sencilla. Consta de:

* Un **sustrato** de silicio tipo *p*, dopado con boro (concentración uniforme
  de $1 \times 10^{16} \text{ cm}^{-3}$).
* Una **emisora** tipo *n*, formada por una implantación de fósforo cerca de
  la superficie superior.
* Dos **contactos metálicos**: uno frontal (grid) y uno trasero (full-area).

## Malla y regiones

Atlas trabaja con una malla rectangular; en cada nodo calcula las ecuaciones
de transporte. Definir la malla correctamente es un compromiso entre precisión
y tiempo de simulación: mallas finas donde hay gradientes fuertes (uniones,
contactos) y mallas gruesas en regiones homogéneas.

```
go atlas

# Malla
x.mesh loc=0   spacing=0.5
x.mesh loc=10  spacing=0.5
y.mesh loc=0    spacing=0.01
y.mesh loc=0.5  spacing=0.05
y.mesh loc=300  spacing=0.5
```

## Definir regiones y dopados

```
# Regiones
region num=1 ix.l=1 ix.h=2 iy.l=1 iy.h=2 silicon

# Dopado del sustrato (tipo p, boro)
base    imp=boron conc=1e16

# Dopado de la emisora (tipo n, fósforo)
# Perfil gaussiano con junta a 0.5 um
emitter imp=phosphorus conc=1e19 peak=0.5 depth=0.5
```

## Contactos e iluminación

```
# Contacto frontal (grid)
electrode num=1 x.l=1 x.h=2 top
# Contacto trasero
electrode num=2 bottom

# Iluminación AM1.5
beam num=1 x.origin=5 y.origin=-10 angle=90 wavel.start=0.3 wavel.stop=1.1 \
      am1.5 power=0.1
```

## Resolver y extraer la curva I-V

```
solve init
solve b1=1e-3 l.b1=0.0 h.b1=0.7 vstep=0.01 name=2 ac name=1

# Exportar I-V
save outf=solar_cell_IV.log
```

## Análisis de resultados

Atlas genera archivos `.log` con corrientes y tensiones. Con Tonyplot (el
visualizador incluido) se grafica $I$ vs $V$ y se obtiene el punto de máxima
potencia, la eficiencia y el factor de lleno.

$$
\eta = \frac{P_{max}}{P_{in}} = \frac{V_{mp} \cdot I_{mp}}{100 \text{ mW/cm}^2}
$$

## Próximo paso

Lo interesante viene cuando se añade texturización superficial, capas
antirreflejantes (SiN, TiO$_2$) y se modela la recombinación en los contactos.
Pero eso merece su propio artículo.

---

Créditos imagen:
[OpenClipart](https://openclipart.org/detail/2872071/photovoltaik) (dominio
público).

© Noe Nieto, 2017. Publicado bajo [Licencia Creative Commons Atribución 4.0
Internacional](https://creativecommons.org/licenses/by/4.0/).
