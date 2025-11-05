# AGENTS.md — Resumen reutilizable para agentes LLM

Propósito
- Repositorio: `misaelnieto.github.io`
- Autor: Noe Nieto
- Tipo: Sitio personal / blog estático generado con Jekyll
- Descripción breve: Blog personal de Noe Nieto (ingeniero electrónico y dedicado a la ingeniería de software). Este sitio esta dedicado principalmente a contenidos técnicos (open source, Python) y personales. 

Estructura relevante del repositorio
- Archivos raíz importantes:
  - `_config.yml` — configuración principal de Jekyll (URL, título, plugins, tema, SEO, exclusiones, defaults, collections).
  - `Gemfile` — dependencias Ruby/Jekyll y plugins.
  - `watch.sh` — script simple para levantar el servidor en modo watch.
  - `README.md` — descripción general y enlaces (Netlify badge presente).
  - `about.md` — página "about" del autor.
  - `index.md` — landing/portada del sitio.
- Carpetas principales:
  - `_posts/` — entradas del blog (contenido cronológico).
  - `_data/` — datos en YAML (p. ej. `navigation.yml`, `portfolio.yml`).
  - `_layouts/`, `_includes/` — templates y fragmentos de Jekyll.
  - `_drafts/` — borradores.
  - `media/` — imágenes y recursos estáticos.
  - `_tutoriales/`, `_plugins/`, `_includes/` — otros recursos y plugins.

Tecnologías y dependencias
- Generador: Jekyll (en `Gemfile` especificado como `gem "jekyll", ">= 4.3.3"`).
- Plugins incluidos (Gemfile + `_config.yml`): jekyll-feed, jekyll-seo-tag, jekyll-sitemap, jekyll-toc, jekyll-paginate, jekyll-timeago, jekyll-thumbnail-img, jekyll-autolinks, jekyll-remote-theme.
- Tema: `bulma-clean-theme` (tema Bulma personalizado, declarado en `Gemfile` y `theme: bulma-clean-theme` en `_config.yml`).
- Analytics: Google Analytics (ID en `_config.yml`).
- Plataforma de despliegue observada: Netlify (badge en `README.md`). También hay `vercel.json` en el repo aunque `vercel_install.sh` está en `exclude`.

Configuración y valores útiles desde `_config.yml`
- `url`: https://noenieto.com
- `baseurl`: "" (sitio en dominio raíz)
- `title`: Noe Nieto
- `author` y redes (GitHub, LinkedIn, YouTube, etc.)
- `exclude`: muchos elementos de desarrollo (incluye `Gemfile`, `watch.sh`, `.jekyll-cache`, `node_modules`)
- Collections: `tutoriales` (output: true)
- Paginate: 10 por página en blog

Comandos útiles para agentes o desarrolladores
- Preparar entorno (suposición: Ruby + Bundler instalados):
  - bundle install
  - bundle exec jekyll build
  - bundle exec jekyll serve --watch
- `watch.sh` actual: `bundle exec jekyll serve --watch` (es recomendable usar `bundle exec jekyll serve --incremental --watch --verbose` si se desea más verbosidad/velocidad incremental).

Notas operativas y suposiciones
- La máquina de desarrollo debe tener Ruby (compatible con Jekyll 4.x) y Bundler.
- `bundle` parece haber funcionado recientemente en este entorno (último comando: `bundle` con exit code 0).
- `watch.sh` es muy simple; quizá faltan manejos de errores, verificación de `bundle` o `bundle exec` y permiso de ejecución (`chmod +x watch.sh`).

Puntos de interés para agentes LLM (qué pueden hacer automáticamente)
- Generar o actualizar contenido (por ejemplo `about.md`) respetando frontmatter y estilo del tema.
- Ejecutar una build Jekyll y reportar errores (analizar `bundle exec jekyll build` output).
- Añadir GitHub Actions o workflow CI para build y deploy (Netlify o GitHub Pages).
- Mejoras SEO (metadatos, schema.org) usando `jekyll-seo-tag` y `_config.yml`.
- Añadir scripts de desarrollo robustos (mejorar `watch.sh`, o crear `scripts/dev.sh` con comprobaciones).

Sugerencias rápidas / próximos pasos recomendados
1. Verificar permisos de `watch.sh` y agregar comprobaciones de entorno (Ruby/Bundler).  
2. Actualizar `about.md` para incluir los intereses concretos: Open Source, Python, Unitari Perception, Holokinetic Psychology.  
3. Añadir un archivo `DEVELOPMENT.md` o mejorar `README.md` con pasos para desarrollar localmente (comandos exactos).  
4. Implementar una workflow de CI (GitHub Actions) que ejecute `bundle install` y `bundle exec jekyll build` en cada PR.  
5. Opcional: agregar `Gemfile.lock` al repo si se desea bloquear versiones de gems para reproducibilidad.

Contacto del autor (extraído de `_config.yml`)
- Email: nnieto@noenieto.com
- Web: https://www.noenieto.com
- GitHub: https://github.com/misaelnieto
- LinkedIn: https://www.linkedin.com/in/noe-nieto-13529524

Fecha de generación: 2025-11-05

---

Archivo generado automáticamente por un agente para uso de agentes LLM y desarrolladores. Mantener actualizado si la configuración del proyecto cambia.
