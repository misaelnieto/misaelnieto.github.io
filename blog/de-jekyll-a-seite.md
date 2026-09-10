---
title: 'De Jekyll a Seite: catorce años, tres generadores de sitios estáticos'
date: 2026-07-20
description: Cómo migré mi sitio personal de Jekyll a Seite, un SSG AI-first. Stack, skills, bugs, soluciones alternativas y por qué abandoné BulmaCSS por un sistema de diseño atómico hecho a mano.
image: /static/images/posts/2026-07-20-de-jekyll-a-seite/seite-1.png
tags:
- seite
- jekyll
- ssg
- tailwindcss
- opencode
- atomic-design
- migracion
extra:
  hero:
    image: /static/images/posts/2026-07-20-de-jekyll-a-seite/seite-1.png
    alt: Una flota de veleros de madera del siglo XIX migrando a través de un mar agitado hacia un faro lejano. Grabado en madera al estilo de Gustave Doré, con acentos de rubricación bermellón a mano en el estandarte del barco líder y el haz del faro.
    caption: 'La migración de 2026: catorce años, tres generadores de sitios estáticos.'
---

En junio de 2012 [escribí un post](/blog/primer-post-blog-estatico) anunciando que abandonaba [Plone](http://plone.org/) y mudaba mi sitio personal a Jekyll. Catorce años después, en junio de 2026, volví a hacer las maletas: dejé Jekyll y moví todo el sitio a [Seite](https://seite.sh), un generador de sitios estáticos que se define como *AI-first* (n.t. IA primero).

Este post es la historia de esa migración — el stack, los hacks, los bugs que reporté, las partes de las que estoy orgulloso y las que no. Si estás pensando en mover un blog antiguo a un SSG moderno, o simplemente te da curiosidad qué significa en la práctica un generador de sitios estáticos "AI-first", esto es para ti.

> **Una nota sobre autoría.** La mayor parte del código de este sitio — el CSS, las plantillas Tera, el JSON-LD, los hacks con regex — no lo escribí yo. Lo escribieron LLMs. Mi trabajo fue dirigir, revisar y corregir la salida hasta que coincidiera con lo que tenía en la cabeza. Las decisiones de diseño son mías. Los bugs también. El archivo `organisms.css` de 2.300 líneas es algo que simplemente no podría haber escrito a mano en un plazo razonable. Los agentes fueron mis mecanógrafos, mis desarrolladores junior, mis patitos de goma. Yo era el que los apuntaba a las cosas correctas — y, más a menudo de lo que me gustaría admitir, primero a las incorrectas y luego de vuelta a las correctas.

## El sitio anterior

La versión anterior del sitio funcionaba con [Jekyll](https://jekyllrb.com/) sobre el framework [BulmaCSS](https://bulma.io), usando un tema comunitario llamado `bulma-clean-theme`. Funcionaba. También fue, durante años, un proyecto inacabado — porque **no soy diseñador**, y ningún framework CSS va a hacerme diseñador, por mucho que eso me duela.

Así es como se veía:

![La antigua portada, con una foto de mi boda como imagen hero.](/static/images/posts/2026-07-20-de-jekyll-a-seite/nnoenieto-jekill-bulma1.png)
*La portada. Sí, ese soy yo el día de mi boda. No era exactamente la primera impresión profesional que esperaba dar.*

![La antigua página de currículum, sosa y gris.](/static/images/posts/2026-07-20-de-jekyll-a-seite/nnoenieto-jekill-bulma2.png)
*Mi currículum. Aburrido, sin estilo ni personalidad.*

![El antiguo índice del blog, colorido pero visualmente ruidoso.](/static/images/posts/2026-07-20-de-jekyll-a-seite/nnoenieto-jekill-bulma3.png)
*El índice del blog. Mucho color, sin jerarquía, sin ritmo.*

![Una sección "sobre mi vida" inacabada.](/static/images/posts/2026-07-20-de-jekyll-a-seite/nnoenieto-jekill-bulma4.png)
*Donde supuestamente iba a escribir sobre mi vida. Nunca la terminé.*

El sitio tenía muchos problemas de visual. La tipografía era genérica, el layout no tenía sistema, y cada página era su propio desastre. Catorce años de parches después, era hora de sacudirse el polvo y reconstruirlo de cero.

## Por qué Seite

Me encantan los generadores de sitios estáticos. Durante mucho tiempo, publicar en la web significaba mantener un servidor con scripting — PHP, Python, Ruby, lo que fuera — más una base de datos, más un servidor de aplicaciones, más todas las vulnerabilidades, actualizaciones y dolores de cabeza que vienen incluidos. Todo eso para generar un poco de HTML. Entonces llegó Jekyll en 2008 y popularizó una idea radical: y si solo necesitamos un servidor web estático. Sin scripting, sin runtime, sin base de datos. Si puedes correr un servidor HTTP en un zapato, un SSG puede generar tu sitio entero y meterlo ahí.

Desde entonces, cada lenguaje de programación importante ha lanzado su propio SSG. Hugo, Eleventy, Astro, Pelican, Zola, Hexo — puedes elegir el que quieras.

De todos ellos, el que me sorprendió fue Seite. Lo que llamó mi atención fue una sola afirmación en su homepage: **AI-first** (n.t. IA primero). La idea es que, en lugar de pelear con un editor de administración web(como ocurre con Drupal, Wordpress, Ghost, etc.), o ajustar a manoplantillas y escribir el contenido tú mismo, diriges a un agente de IA — Claude, en el flujo de trabajo previsto por Seite — para que haga el trabajo pesado. El SSG deja de ser una herramienta que operas y pasa a ser una herramienta que *diriges*.

Eso me pareció interesante, porque yo ya vivo dentro de [opencode](https://opencode.ai) todo el día. Si Seite estaba diseñado para ser conducido por un agente, podría por fin deshacerme de los editores frontend caprichosos y simplemente ayudarme del agente LLM a construir las plantillas y a generar el contenido.

Había, por supuesto, un pero. Seite 0.16 está fuertemente atado a Claude Code, y Claude es caro — especialmente cuando lo usas para escribir 150 posts de blog y 2.000 líneas de CSS de organismos. Así que antes de comprometerme, tuve que averiguar si podía conducir Seite con las herramientas que ya tenía.

## Usar Seite sin Claude

Lo primero que tuve que resolver fue: ¿puedo ejecutar Seite a través de opencode, con LLMs más baratos (o gratuitos), en lugar de pagar por Claude?

La respuesta resultó ser sí, pero requirió algo de fontanería. Seite 0.16 distribuye su servidor MCP y sus skills integrados bajo `.claude/`, porque asume que estás ejecutando Claude Code. Los skills son módulos precargados: un generador de logos, un constructor de landing pages, un constructor de temas. Copié la misma configuración del servidor MCP a mi `opencode.json`, lo apunté a [Z.ai](https://z.ai) y OpenRouter, y empecé a usar el mismo MCP de Seite desde opencode.

Además de los tres skills integrados de Seite, escribí tres propios bajo `.agents/skills/` (la ubicación nativa de opencode):

- **`design-system`** — una biblia de diseño de 133 líneas que llamé *"El Artefacto Intelectual"*. Codifica toda la identidad visual del sitio: una estética de monografía/impresión tipográfica del siglo XIX, una "Regla de No-Contenedores", una jerarquía de encabezados que bauticé como *Cadencia del Erudito*, y la ley absoluta de **0px de radio en todas partes**. Cualquier agente que toque CSS tiene que leer este archivo primero.
- **`ilustracion`** — genera prompts en tres modos (litografía, grabado en madera, híbrido) —siempre en inglés— para generadores de imágenes con IA. Piensa en Doré, Dürer, Haeckel. Alimento los prompts a Gemini para el renderizado final.
- **`redaccion`** — un skill de coaching de escritura que me enseña el vocabulario del oficio (progressive disclosure, kicker, anáfora, scannability) mientras edita mis borradores. Este mismo post pasó por él.

El resultado final: estoy ejecutando un SSG "AI-first" que oficialmente apunta a Claude, con un stack de LLMs en planes gratuitos, y un pipeline creativo de tres skills personalizados. Esa fue la primera gran victoria.

## Construyéndolo: diseño atómico + Tailwind v4

Aquí es donde tuve que desviarme más de lo que Seite espera por defecto.

Los temas integrados de Seite se distribuyen como un único `base.html` con **todo el CSS inline en un bloque `<style>`**. Esa es una elección deliberada — hace que los temas sean autocontenidos y portables. El skill integrado `theme-builder` incluso lo impone como regla: *"Sin hojas de estilo externas."*

Pero yo no quería un tema. Quería un **sistema de diseño**: CSS en capas, tokens, una escala tipográfica, componentes reutilizables, una fuente única de verdad para colores y espaciado. El CSS inline en una sola plantilla nunca me iba a dar eso.

Así que me salté por completo la historia CSS de Seite y le acoplé una compilación paralela de [Tailwind CSS](https://tailwindcss.com) v4. El pipeline se ve así:

```
static/css/main.css        ← entry point: @import "tailwindcss" + @theme tokens
        │
        ├── atoms.css      (layer atoms)       — resets, elementos base
        ├── molecules.css  (layer molecules)   — utilidades, botones, filetes, tags
        └── organisms.css  (layer organisms)   — ~2.300 líneas de composiciones
                │
                ▼   (bunx tailwindcss CLI, zero-config)
        static/styles.css   ← generado, luego fingerprinted por seite
```

Las tres capas son una división de [Diseño Atómico](https://atomicdesign.bradfrost.com/), la metodología de Brad Frost donde compones interfaces desde átomos → moléculas → organismos. El entry point (`main.css`) es donde defino todos los tokens de diseño a través del bloque `@theme` de Tailwind v4 — `--color-paper: #FDFCF0`, `--color-ink: #1C1C19`, `--color-rubric: #E65100`, la fuente del cuerpo `Newsreader`, una escala tipográfica apropiada para monografías, y los radios de 2 píxeles que refuerzan la sensación de impresión tipográfica.

La orquestación vive en un `justfile` de 17 líneas conducido por [just](https://just.systems/):

```makefile
seite_watch:    seite serve --port 4000
tailwind_watch: bunx tailwindcss -i static/css/main.css -o static/styles.css --watch --minify

[parallel]
watch: seite_watch tailwind_watch

build:
    bunx tailwindcss -i static/css/main.css -o static/styles.css --minify --minify
    seite build
```

Algunas cosas que vale la pena señalar de esta configuración:

1. **El servidor de desarrollo de Seite no recompila CSS.** No es un bug, simplemente no es su trabajo. Para desarrollar en local tengo que ejecutar `just watch`, que levanta `seite serve` y `tailwindcss --watch` en paralelo. (Mi `AGENTS.md` codifica esto como regla para cualquier agente de IA que toque el proyecto, porque es muy fácil olvidarlo.)
2. **El orden de compilación importa.** `just build` ejecuta Tailwind primero y luego Seite, porque Seite aplica fingerprinting al `styles.css` que Tailwind acaba de producir.
3. **Cero dependencias de JavaScript.** No hay `package.json`, no hay `tailwind.config.js`, no hay `node_modules/` comprometido. Tailwind v4 se configura enteramente a través del bloque `@theme` en CSS, y se invoca bajo demanda vía `bunx` (el `npx` de Bun). Las únicas dependencias de runtime son el binario Rust de Seite y Bun.
4. **Sí, hay un typo en la receta de compilación de producción.** Paso `--minify` dos veces. Es inofensivo — un flag idempotente — pero sigo dejándolo ahí porque a estas alturas es parte del folclore del proyecto.

El resultado final es que Seite trata todo mi sistema de diseño como un simple recurso estático. No sabe nada de Tailwind, no sabe nada de capas atómicas, no sabe nada de mis tokens. Solo ve un archivo `styles.css`, le aplica fingerprinting, y lo distribuye.

## Golpes y moretones

Toda migración deja golpes y moretones. Estos son los míos.

### Issue #86: un bug real, corregido rápido

Mientras cableaba la compilación me tropecé con un bug genuino en Seite y reporté el [issue #86](https://github.com/seite-sh/seite/issues/86). Los mantenedores lo corrigieron rápido. Esa es toda la historia — a veces el software simplemente funciona como esperas.

### Issue #87: Mermaid no está integrado

Seite no integra [Mermaid.js](https://mermaid.js.org/) por defecto. Tengo un par de posts antiguos con diagramas `gitGraph` que quería seguir renderizando, así que reporté el [issue #87](https://github.com/seite-sh/seite/issues/87) y luego construí mi propia solución alternativa.

En lugar de incluir Mermaid globalmente, lo puse detrás de un flag de frontmatter por post. Una línea en el frontmatter lo activa:

```yaml
extra:
  mermaid: true
```

Cuando ese flag está activado, `base.html` carga Mermaid de forma lazy desde el CDN de jsDelivr y ejecuta una regex sobre cada bloque `<pre><code>` para detectar tipos de diagrama (`gitGraph`, `sequenceDiagram`, `flowchart`, ...) y convertirlos en `<div class="mermaid">`. Cuando el flag está desactivado — que es el 99% de los posts — no hay ninguna carga de Mermaid. Me gusta ese compromiso. (**Actualización:** ya lo integraron en [Seite v0.17.0](https://seite.sh/changelog/v0-17-0), así que este workaround ya no es necesario.)

### La trampa de `base_url`

`seite.toml` tiene actualmente la URL de producción (`https://noenieto.com`) comentada y `http://localhost:4000` activa, porque desarrollo en local la mayor parte del tiempo. El deploy con `auto_commit` de Seite no cambia esto por mí. Si alguna vez hago deploy sin descomentar la URL de producción, cada enlace canónico, cada entrada de RSS y cada URL del sitemap apunta a `localhost`. No lo he hecho todavía, pero lo haré. (**Actualización:** ya lo corrigieron en [Seite v0.16.1](https://seite.sh/changelog/v0-16-1).)

## Los logros

Esta es la parte donde puedo presumir un poco. Estos son los trozos de la reconstrucción de los que estoy más orgulloso.

### Los tres skills que la reconstrucción me obligó a escribir

Ninguno de los tres skills estaba planificado. Fueron emergiendo de las necesidades concretas que la reconstrucción del sitio iba sacando a la superficie. Cada vez que me estrellaba contra un muro, la respuesta era: escribe un skill, para que el siguiente agente no tenga que reaprender la lección.

- **`ilustracion`** nació porque necesitaba generar imágenes hero con una estética coherente — cross-hatching al estilo Doré, tinta sobre pergamino del siglo XIX — y seguía regenerando prompts a mano. Sistematizarlos en un skill fue la única forma de que la salida fuera consistente.
- **`redaccion`** nació porque escribir ciertas piezas del sitio — contenido con carga emocional, reflexiones personales — era difícil sin un editor que no se inmutara. El skill me dio distancia editorial suficiente para redactar sin paralizarme.
- **`design-system`** nació porque nada de lo visual funcionaba sin reglas. Las notas al margen flotantes, las notas al pie tipo sidenote, la tipografía, los radios — todo necesitaba una fuente única de verdad, o los agentes producían resultados inconsistentes.

La lección: los skills no se diseñan de antemano. Cristalizan.

### Dejar que el agente lea mi GitHub

Las otras dos páginas donde el agente trabajó en serio son [Demos & Tools](/demos) y [As a teacher](/as-a-teacher). El flujo de trabajo fue el mismo en ambos casos: apunté al agente a mi perfil de GitHub, le dije qué repositorios mirar, y le pedí que produjera un resumen curado en markdown de cada uno.

Para `as-a-teacher` leyó mis repositorios de cursos y produjo un desglose estructurado por semestre y por clase, con enlaces a los materiales del curso. Para `demos` categorizó aproximadamente veinticinco repositorios en *Demos*, *Tools* y *Archived*, con descripciones de una línea en mi voz.

Esa categoría *Archived* es donde las cosas se pusieron inesperadamente productivas. Mientras el agente ya estaba ahí catalogando, le pedí que me ayudara a archivar un montón de repositorios que no había tocado en años — plugins de LFS, un Flatpak viejo de Haroopad, una herramienta de deploy con hooks en PHP, una app de Android Calculadora Gasolinazo de 2013. Deuda técnica que había estado sentada en mi perfil durante más de una década, limpiada en una tarde.

Hablemos en serio: escribir esas tres páginas a mano — la sección personal, `demos`, `as-a-teacher` — me habría llevado meses. Honestamente, probablemente nunca lo hubera terminado. El costo emocional solo habría matado el proyecto. Con el agente, cada página tomó un par de rondas de 15 minutos en las que yo dirigía y corregía. Esa es toda la tesis de este post en una sola frase.

### Mi currículum es literalmente un grafo de commits de git

Mi [página de currículum](/as-a-professional) renderiza mi carrera como un diagrama `gitGraph` de cuatro carriles — uno para mi trabajo principal, otro para consultoría, otro para mi startup anterior (Holokinesis) y otro para la enseñanza. Cada puesto es un punto de commit. Cada puesto tiene un hash de siete caracteres. Cada puesto en curso recibe un marcador `▲ HEAD`. Todo se renderiza en plantilla pura [Tera](https://keats.github.io/tera/docs/) + CSS — **sin JavaScript**.

La plantilla Tera literalmente calcula qué ramas están "activas" en cada fila comparando fechas de inicio/fin parseadas como enteros. El CSS de soporte tiene más de 500 líneas, con tres breakpoints responsivos que colapsan los carriles elegantemente en móvil. Estoy irracionalmente orgulloso de ello.

### Notas al pie al estilo Tufte, a mano

Siempre me ha encantado la forma en que [Edward Tufte](https://edwardtufte.github.io/tufte-css/) flota las notas al pie en el margen derecho en lugar de tirarlas al fondo de la página. Quería eso. Lo construí. Las notas al pie ahora flotan en el margen derecho con `margin-right: -45%` en escritorio y colapsan a inline al fondo en móvil.

### El índice del blog con puntos de líder

El listado de [/blog](/blog) está estilizado como la página de índice de un libro impreso antiguo — título a la izquierda, fecha a la derecha, y una fila de puntos conectándolos. Los puntos son un `radial-gradient`, y hay un comentario en el CSS explicando por qué usé la palabra clave `circle`: sin ella, un artefacto de antialiasing en Chrome hacía que los puntos parecieran pequeños diamantes. Detalle diminuto, pero es exactamente el tipo de detalle que marca la diferencia entre *casi bien* y *bien*.

### El footer animado

El footer tiene un SVG de un barco meciéndose en un mar ondulante. Tres animaciones por keyframes — `sway`, `float`, `wobble` — conducen el barco sobre una ola SVG, y todo es CSS puro. El aviso de copyright está en números romanos: `© MCMXXIV NOE NIETO` (1924, una fecha de fundación ficticia). Es absurdo. Me encanta.

### JSON-LD hecho a mano que supera las especificaciones integradas

Los temas integrados de Seite distribuyen un bloque JSON-LD. Mi `base.html` distribuye cuatro: un bloque `Person` incondicional, y luego condicionalmente un `BlogPosting`, un `Article` o un `WebSite` (con un `SearchAction`), más un `BreadcrumbList`. Quiero los rich snippets. Quiero las tarjetas. No me disculpo por ello.

## Generación de imágenes

Mi skill `ilustracion` produce un prompt en inglés — cross-hatching al estilo Doré, simetría inspirada en Haeckel, litografía de piedra caliza bávara — y ese prompt lo alimento a [Gemini](https://gemini.google.com/) (el modelo que internet ha apodado *"nano-banana"*). La salida va directo a las imágenes hero y a las cabeceras de los posts. Me encanta absolutamente. Es lo más cerca que he estado de tener un ilustrador a disposición.

## Lo que aprendí

La mayor lección es una que básicamente ya sabía: **el agente es el mecanógrafo, no el arquitecto**. Cada línea de CSS, cada plantilla Tera, cada campo de frontmatter en este sitio fue escrito por un LLM — pero nada de eso entró sin que yo lo leyera, lo entendiera, y lo aceptara o lo devolviera. El skill `design-system` existe precisamente para que *yo* decida las reglas visuales una vez, y cada agente después de eso tenga que seguirlas. Dirigir a un LLM para que produzca código detrás del cual puedas pararte es una habilidad real, y diferente a escribir el código tú mismo. Tienes que saber qué quieres, tienes que reconocer cuando el modelo está equivocado, y tienes que ser honesto sobre qué partes entiendes realmente y cuáles estás aprobando con un sello de goma. Intenté mantener esa honestidad durante todo el proyecto.

La segunda lección es que **las herramientas AI-first no son lo mismo que las herramientas AI-only**. Seite es AI-first en el sentido de que está diseñado para ser dirigido por un agente. No es AI-only en el sentido de que el agente haga todo. Los mejores resultados vinieron de que yo supiera exactamente lo que quería (una estética de monografía/impresión tipográfica del siglo XIX, una arquitectura CSS de diseño atómico, un currículum con grafo de commits) y de apuntar al agente como un misil buscador de calor.

## El remate

Catorce años, tres generadores de sitios estáticos, y sigo sin ser diseñador. Pero al menos el sitio parece que lo soy.

Si alguna vez te topas con Seite, dale una oportunidad. Y si el precio de Claude te echa para atrás — ahora ya sabes que se puede usar con otros agentes, con un poquto de creatividad. Nos vemos en el próximo post. 👋

![Un pequeño barco de madera meciéndose en un mar agitado al atardecer. Grabado en madera al estilo de Gustave Doré.](/static/images/posts/2026-07-20-de-jekyll-a-seite/seite-2.png)
