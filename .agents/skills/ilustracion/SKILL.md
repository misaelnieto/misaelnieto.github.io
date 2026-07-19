---
name: ilustracion
description: Genera prompts para ilustraciones hero/portrait en estilo grabado vintage para posts y páginas del blog.
temperature: 0.9
---

# Skill: Ilustración Vintage — Hero & Portrait Prompts

Genera prompts de ilustración para imágenes hero, portraits y thematic headers del blog, siguiendo un estilo unificado de grabado clásico.

## Estilo base del proyecto: MANDATORIO

Grabado vintage estilo siglo XIX, inspirado en enciclopedias antiguas y billetes de época.
Todas las ilustraciones del proyecto deben seguir esta estética coherente.

## Plantilla de prompt

Usa la siguiente estructura al generar un prompt para cualquier imagen del proyecto:

```
[SUBJECT], [COMPOSITION], in the style of a 19th-century engraving. Fine cross-hatching technique with dense interlocking lines creating shadows and depth. Monochromatic black ink on aged parchment background. Inspired by Gustave Doré and Albrecht Dürer. High detail, historical lithograph appearance. Hand-drawn pen stroke aesthetic. [EXTRA CONTEXT IF NEEDED].
```

### Componentes de la plantilla

| Campo | Descripción | Ejemplo |
|-------|-------------|---------|
| **SUBJECT** | Qué se ilustra | `a middle-aged man with glasses and beard`, `a vintage typewriter`, `a server rack` |
| **COMPOSITION** | Encuadre y ángulo | `close-up portrait looking slightly right`, `three-quarter view`, `front-facing bust` |
| **EXTRA** | Contexto temático del post | `surrounded by floating code snippets`, `with circuit board patterns in background` |

## Elementos técnicos obligatorios

Toda ilustración del proyecto debe incluir:

- **Técnica**: Cross-hatching, line art, engraving
- **Paleta**: Monocromática (negro sobre fondo claro/pergamino)
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

## Reglas de estilo

1. **Nunca usar color** — siempre monocromático o sepia
2. **Siempre incluir cross-hatching** — es la firma visual del proyecto
3. **Bordes decorativos** — scrollwork Victorian en corners o marco completo
4. **Fondo pergamino** — tono cálido claro, no blanco puro
5. **Consistencia** — todas las ilustraciones del blog deben ser reconocibles como parte de la misma serie

## Ejemplo completo generado

Prompt para hero image de un post sobre ingeniería de software:

```
A vintage engraving of a developer at a workstation surrounded by floating terminal windows and code fragments. Close-up composition, three-quarter view. 19th-century cross-hatching technique with dense interlocking lines. Monochromatic black ink on aged parchment background. Decorative Victorian scrollwork border. Inspired by Gustave Doré engravings. High detail, historical lithograph appearance. Hand-drawn pen strokes.
```
