# AGENTS.md

Sitio personal de Noe Nieto, generado con [seite](https://seite.sh). Migrado de Jekyll (~148 posts). Bilingüe es/en, idioma por defecto `es`.

## Comandos

```bash
just watch    # dev: seite serve (port 4000) + tailwind watch en paralelo
just build    # producción: compila CSS y luego sitio (ordena importa)
```

- **El pipeline de CSS es independiente de seite.** `seite serve` **no** recompila CSS. En dev necesitas `just watch` (ambos procesos), no `seite serve` solo, o tus cambios de CSS no se verán.
- `just build` ejecuta `tailwindcss` primero y luego `seite build` — respetar ese orden.
- Para builds puntuales sin tocar CSS: `seite build` (o la tool MCP `seite_build`).

## Servidor de desarrollo — no lanzar ni matar procesos

El usuario trabaja en varios proyectos a la vez; los puertos 4000 (este proyecto) y 3000 pueden estar ocupados por **otros** servicios. **Nunca** lances `seite serve` / `just watch` ni mates procesos que ocupen esos puertos por tu cuenta.

Antes de asumir que el dev server está activo, verifica el puerto (p. ej. `curl -sS -o /dev/null -w "%{http_code}" http://localhost:4000/` o un `fetch` rápido). Si:

- el puerto **no responde**, o
- responde pero el contenido **no es de este sitio** (otra app, otro proyecto),

**para y pide al usuario** que arranque o reinicie `just watch`. No intentes diagnosticar rebotando procesos: podrías tirar el trabajo de otra tarea del usuario.

## Flujo de trabajo del agente

- **Examen de imágenes/screenshots**: si actúas como agente principal y necesitas inspeccionar o entender una captura de pantalla, imagen o salida visual, **siempre** delega al subagente `chango-visual` (modelo especializado en visión). No intentes interpretar imágenes directamente.
- **Preguntas técnicas sobre seite**: consulta primero el MCP `seite` (`seite_lookup_docs`, `seite_search`) antes de la búsqueda web. El MCP refleja la versión instalada; la documentación web puede estar desfasada.
- **Verificación visual final**: antes de dar por buena una tarea que toque UI/templates/CSS, verifica el render en navegadores reales con las tools `chrome-devtools` **y** `frefox-devtools` (ambos, no solo uno) para cazar glitches o regresiones visuales.

## Arquitectura

**Tres capas que no mezclar:**

1. `static/css/{atoms,molecules,organisms}.css` — CSS escrito a mano, en `@layer` separadas. **Aquí se edita el CSS del proyecto.**
2. `static/css/main.css` — entry point: `@import "tailwindcss"` + los tres archivos en sus capas. Define los tokens en `@theme` (colores, tipografía, spacing).
3. `static/styles.css` — **generado** por tailwind CLI. No editar a mano; se sobreescribe en cada build.

`templates/base.html` enlaza `/static/styles.css` (el compilado), no `main.css`.

**Tokens de diseño** (definidos en `static/css/main.css`, `@theme`): paper `#FDFCF0`, ink `#1C1C19`, rubric `#E65100`, fuente body `Newsreader`. Antes de tocar cualquier estilo, consultar el skill `design-system` (`.agents/skills/design-system/SKILL.md`) — es la fuente autoritativa del sistema visual (estética de monografía/letterpress del s. XIX, regla de "no-contenedores", etc.).

## Convenciones de plantillas

seite usa **Tera** (Jinja2-compatible). Todo extiende `base.html`.

- **`partials/entry-header.html` y el hero**: `base.html` **no** renderiza el hero globalmente. Cualquier template que extienda `base.html` y pueda tener `page.extra.hero` debe incluir el partial al inicio de su `{% block content %}`:
  ```tera
  {% include "partials/entry-header.html" %}
  ```
  Plantillas que ya lo incluyen: `page.html`, `post.html`, `resume.html`, `index.html`. Si añades un template nuevo con hero, incluye el partial o el hero no aparecerá.
- **Cómo activar el hero en un post/page**: definir `extra.hero` en el frontmatter. Sin ese bloque, el partial renderiza solo el `<h1>` + description (sin imagen). Con él, renderiza la figura del hero. Campos:
  ```yaml
  image: "/static/images/posts/mi-post/hero.png"   # OG/Twitter metadata — seite lo expone como URL absoluto en page.image
  extra:
    hero:                                       # su mera existencia activa el branch del hero
    image: "/static/images/posts/mi-post/hero.png"  # opcional — path relativo para el <img> visible (ver nota abajo)
      alt: "Texto alt descriptivo para screen readers."   # obligatorio — sin esto el <img> queda sin alt
      caption: "Texto al pie de la figura."              # opcional — si se omite, no renderiza <figcaption>
  ```
  Notas:
  - **`image:` es solo metadata SEO** (OG/Twitter/JSON-LD en `base.html`). seite lo expone como URL absoluto en la variable `page.image`. **NO usarlo directo como `src` de un `<img>` visible** — el post-procesador de imágenes de seite no lo matchea (espera `/static/...` relativo) y queda sin WebP/srcset.
  - **`extra.hero.image:` es el src del `<img>` visible**. Si se omite, el partial usa `image:` como fallback quitándole `site.base_url` para obtener el path relativo — los posts existentes que solo tienen `image:` siguen funcionando.
  - `extra.hero.caption` se renderiza como texto plano (sin `| safe` en el partial). Si necesitas énfasis (cursivas, enlaces), hay que editar el partial.
  - Para un hero sin imagen (solo título grande + tagline), basta con declarar `extra.hero:` sin más campos — el partial entra al branch hero pero omite la rama `if page.image`.
- **El 404 se customiza por plantilla**, no por markdown: `templates/404.html` extiende `base.html` y sobreescribe el bundle por defecto.
- **Shortcodes** son markdown-only (`{{< figure(...) >}}`). No funcionan dentro de plantillas `.html`.
- **Imágenes**: seite procesa `<img src="/static/...">` automáticamente (WebP + `srcset` responsive, widths 480/800/full). No hace falta escribir `<picture>` a mano — el build lo inyecta. Convención de organización:
  - **Bundles por post**: las imágenes de un post viven en `static/images/posts/<post-slug>/`. Un bundle por post, sin namespace compartido. Una imagen usada en varios posts se duplica en cada bundle.
  - **Naming**: kebab-case limpio. Patrones:
    - Screenshots automáticos: `screenshot-YYYY-MM-DD-HHMMSS.png` (sin título) o `screenshot-YYYY-MM-DD-descriptive.png` (con título del alt/heading)
    - Descriptivos: `mi-post-paso-1.png`, `arquitectura-overview.png`
    - Stock Unsplash/Flickr: preservar filename original (`*-unsplash.jpg`, `NNNN_hash_o.jpg`)
  - **Extensiones**: `.png`, `.jpg`, `.svg`, minúsculas siempre.
  - **Cuarentena**: imágenes sin referencias van a `_unused_images/` (fuera de `static/`, para que seite no las procese). No se eliminan.

## Contenido

- **Colecciones** (`seite.toml`): `posts` → `/blog`, `pages` → raíz (sin `url_prefix`). Frontmatter YAML.
- `content/pages/index.md` es el frontpage. Su `index.html` renderiza aspects + latest musings si `page.extra.aspects` está presente; si no, vuelca `page.content`.
- `data/{nav,author}.yaml` alimenta nav y metadatos JSON-LD en `base.html`.
- Idioma: la mayoría del contenido histórico está en español; los posts recientes y pages (`as-a-*`) en inglés.

## Deploy

- `deploy.target = "github-pages"`, `auto_commit = true`.
- **`base_url` en `seite.toml` está en `http://localhost:4000`** (la URL de producción está comentada). Antes de cualquier deploy/productivo, descomentar `https://noenieto.com` y comentar la de localhost, o los canonical/RSS/sitemap apuntarán a localhost.

## Fuentes de instrucción existentes

- `.agents/skills/` — `design-system` (tokens visuales, autoritativo), `ilustracion` (prompts de ilustración), `redaccion` (corrección de artículos es/en).
- `.claude/skills/` — `brand-identity`, `landing-page`, `theme-builder` (workflows generativos).
- `.claude/rules/*.md` — documentación de seite extraída por path scope (templates, shortcodes, seo, i18n, etc.). Se carga contextualmente según la ruta que se edita.
- MCP `seite` configurado en `opencode.json`: preferir `seite_build`, `seite_search`, `seite_lookup_docs` a equivalentes en bash.

## Notas operativas

- `dist/`, `public/`, `.seite/`, `node_modules/` y `seite.log` están en `.gitignore` (generados).
- `post.md` en la raíz es un draft/plantilla suelta, no parte del build.
- `REPORTE.md` es una auditoría de diseño de abril 2026, en gran parte desfasada — tratar como histórico, no como estado actual.
