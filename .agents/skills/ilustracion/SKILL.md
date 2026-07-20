---
name: ilustracion
description: "Genera prompts para ilustraciones (hero images, portraits, avatares, headers temáticos) en estilo grabado vintage del siglo XIX — cross-hatching estilo Doré/Dürer, tinta negra sobre pergamino. Para posts y páginas del blog. La paleta cromática y los tokens visuales del proyecto están definidos en el skill `design-system`; consúltalo para los tonos paper/ink/rubric antes de fijar colores."
compatibility: opencode
metadata:
  audience: designers
---

# Skill: Ilustración Vintage — Hero & Portrait Prompts (Litografía vs. Xilografía)

Genera prompts de ilustración para imágenes de ilustraciones temáticas y retratos permitiendo elegir entre Litografía en Piedra Caliza, Grabado en Madera/Buril o una Mezcla de Ambos.

## Reglas Globales Mandatorias

* **Paleta:** Los tonos exactos del proyecto — paper `#FDFCF0`, ink `#1C1C19`, rubric `#E65100` — están definidos en el skill **`design-system`**; consúltalo antes de fijar valores de color o de desviarte del monocromo.
* **Proporción / Orientación:** Por defecto, generar imágenes en **portrait (3:4 o 2:3)** o **cuadradas (1:1)**. Las horizontales/banners están **prohibidas** salvo escenas panorámicas genuinas (paisajes, procesiones, vistas arquitectónicas). El layout del sitio — `.hero-figure` es una columna del 45%, `.figure-left/right` flotan al 40%, `.figure-grid` es de 2 columnas — hace que el horizontal siempre pierda impacto. Las reglas completas de formato viven en el skill **`design-system`** (sección "8. Illustration Format"); consúltalo antes de fijar dimensiones.
* **Fondo:** Nunca blanco puro digital; siempre papel envejecido, pergamino o textura de piedra caliza. La textura de fondo no debe ser mas promiente que el dibujo.
* **Idioma del Prompt Generado:** Siempre en inglés para máxima compatibilidad con las IAs.
* **Bordes decorativos** — De acuerdo al estilo principal seleccionado.
* **Sin letras o descripciones** - El prompt debe pedir explicitamente que no se generen letras, letreros o descripciones de la ilustración, a menos que el usuario lo pida explicitamente.


## Selección de Estilo (Parámetro de Entrada)

El usuario (o tú al invocar el skill) puede especificar el estilo deseado. Si no se especifica, el skill generará las 3 variantes de prompt para comparar.

- **MODO LITO**: Litografía Científica sobre Piedra Caliza: Trazo suave de lápiz graso, punteado (stippling), degradados de sombra (tusche wash), textura de grano de piedra, estilo museo de historia natural (Haeckel, Giltsch).
- **MODO XILO**: Grabado Clásico en Madera / Buril: Líneas duras, tallado profundo, tramado cruzado (cross-hatching), alto contraste, estilo enciclopedia victoriana / billete (Doré, Dürer).
- **MODO HÍBRIDO**: Fusión Litografía + Xilografía: Estructura de líneas entrelazadas combinada con sombras suaves de lápiz graso y textura de papel/piedra antiguo.


| Parámetro | [MODO LITO] Litografía en Piedra | [MODO XILO] Grabado en Madera | [MODO HÍBRIDO] Fusión |
| --- | --- | --- | --- |
| **Técnica** | `lithographic crayon, soft stippling, tusche ink wash` | `dense cross-hatching, fine line art, engraving` | `cross-hatching with soft litho-crayon shading` |
| **Textura** | `Bavarian limestone matrix grain, velvety dark shadows` | `deep carved woodcut lines, high contrast ink` | `textured paper with subtle stone matrix grain` |
| **Inspiración** | Ernst Haeckel, Adolf Giltsch, Joseph Wolf | Gustave Doré, Albrecht Dürer, currency engravings | 19th-century scientific encyclopedias |
| **Borde** | Marco doble fino de lámina científica (`thin double-line scientific border`) | Filigrana victoriana o marco decorativo (`Victorian scrollwork border`) | Marco fino con esquinas decorativas |

## Plantilla de prompt

### A. Plantilla [MODO LITO] (Litografía en Piedra Caliza)

```text
[SUBJECT], [COMPOSITION], in the style of an antique Bavarian limestone lithographic scientific illustration. Fine lithographic crayon shading, soft stippling technique, and velvety tusche ink wash shadows. Monochromatic dark ink (#1C1C19) on aged cream parchment (#FDFCF0). Thin double-line scientific plate border. Inspired by Ernst Haeckel and 19th-century natural science plates. High detail, authentic limestone matrix grain, soft hand-drawn pencil aesthetic. [EXTRA CONTEXT].

```

### B. Plantilla [MODO XILO] (Grabado en Madera / Buril)

```text
[SUBJECT], [COMPOSITION], in the style of a 19th-century woodcut engraving. Fine cross-hatching technique with dense interlocking lines creating deep contrast and sharp shadows. Monochromatic black ink (#1C1C19) on aged parchment background (#FDFCF0). Decorative Victorian scrollwork border. Inspired by Gustave Doré, Albrecht Dürer, and vintage currency engravings. High detail, historical encyclopedia print appearance, crisp pen stroke aesthetic. [EXTRA CONTEXT].

```

### C. Plantilla [MODO HÍBRIDO] (Fusión)

```text
[SUBJECT], [COMPOSITION], 19th-century scientific illustration combining woodcut engraving and limestone lithography. Fine cross-hatching blended with soft lithographic crayon shading for complex tonal depth. Monochromatic black ink on warm parchment paper (#FDFCF0). Delicate vintage border. Inspired by Gustave Doré and Ernst Haeckel. High detail, subtle stone texture with defined hand-drawn ink lines. [EXTRA CONTEXT].

```

### Componentes de la plantilla

Si el usuario no ha dado pautas especificas para alguno de los componentes de la plantilla, usa el contexto de la pagina o seccion del sitio y genera de 2 a 3 opciones pertinentes para cada uno de los componentes, luego pide al usuario que escoja. Ademas de lo anterior, permite decidir el nivel de detalle de la ilustración al usuario de entre tres niveles: bajo, medio, alto.


| Campo | Descripción | Ejemplo |
|-------|-------------|---------|
| **SUBJECT** | Qué se ilustra | `a middle-aged man with glasses and beard`, `a vintage typewriter`, `a server rack` |
| **COMPOSITION** | Encuadre y ángulo | `close-up portrait looking slightly right`, `three-quarter view`, `front-facing bust` |
| **EXTRA** | Contexto temático del post | `surrounded by floating code snippets`, `with circuit board patterns in background` |


## Elementos técnicos obligatorios

Toda ilustración del proyecto debe incluir:

- **Técnica**: Cross-hatching, line art, engraving
- **Paleta**: Los tonos exactos del proyecto están definidos en el skill **`design-system`**; consúltalo antes de fijar valores de color o de desviarte del monocromo.
- **Detalle**: Alto nivel de intrincado, trazo de plumilla manual
- **Borde**: Elementos decorativos (scrollwork, filigrana, o patrón de red) — como en el profile.png del proyecto
- **Inspiración**: Gustave Doré, Albrecht Dürer, grabados de billetes y enciclopedias Victoriana

## Casos de uso en el proyecto

### 1. Avatar / Profile portrait
```
Portrait of [DESCRIPTION], close-up, three-quarter view looking slightly right. 19th-century engraving style with dense cross-hatching creating defined shadows. Monochromatic black ink on parchment. Decorative Victorian border with scrollwork and net pattern. Inspired by currency engravings and historical book illustrations. High contrast, intricate hand-drawn pen strokes.
```

### 2. Hero image para posts
```
[SCENE DESCRIPTION], in the style of a Victorian-era woodcut engraving. Fine cross-hatching with interlocking lines. Monochromatic on aged paper. Detailed lithograph aesthetic, Doré-inspired. [THEMATIC ELEMENTS relevant to the post topic].
```

### 3. Thematic illustration para secciones
```
[SBJECT] with [THEMATIC DETAILS], engraved in 19th-century cross-hatching style. Black ink monochrome, high contrast. Hand-drawn pen illustration. Vintage encyclopedia aesthetic.
```


## Ejemplo de Salida del Skill (Sin Modo Especificado)

Si solicitas: *"Genera una hero image para un post sobre Algoritmos de Inteligencia Artificial"*:

### opción 1: Litografía en Piedra Caliza [MODO LITO]

```markdown
An intricate mechanical brain surrounded by mathematical formulas and abstract node networks, close-up centered composition, in the style of an antique Bavarian limestone lithographic scientific illustration. Fine lithographic crayon shading, soft stippling technique, and velvety tusche ink wash shadows. Monochromatic dark ink (#1C1C19) on aged cream parchment (#FDFCF0). Thin double-line scientific plate border. Inspired by Ernst Haeckel and 19th-century natural science plates. High detail, authentic limestone matrix grain.
```

### opción 2: Grabado en Madera / Buril [MODO XILO]

```
An intricate mechanical brain surrounded by mathematical formulas and abstract node networks, close-up centered composition, in the style of a 19th-century woodcut engraving. Fine cross-hatching technique with dense interlocking lines creating deep contrast and sharp shadows. Monochromatic black ink (#1C1C19) on aged parchment background (#FDFCF0). Decorative Victorian scrollwork border. Inspired by Gustave Doré and Albrecht Dürer. High detail, historical encyclopedia print appearance.
```

### opción 3: Híbrido Litografía + Grabado [MODO HÍBRIDO]

```
An intricate mechanical brain surrounded by glowing mathematical formulas and abstract node networks, close-up centered composition, 19th-century scientific illustration combining woodcut engraving and limestone lithography. Fine cross-hatching blended with soft lithographic crayon shading for complex tonal depth. Monochromatic black ink on warm parchment paper (#FDFCF0). Delicate vintage border. Inspired by Gustave Doré and Ernst Haeckel. High detail, subtle stone texture with defined hand-drawn ink lines.
```
