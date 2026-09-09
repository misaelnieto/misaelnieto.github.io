# Plan 001 — Reestructuración del sitio noenieto.com

**Fecha:** 2026-09-07
**Estado:** Aprobado en sesión estratégica; pendiente de ejecución por fases
**Origen:** Conversación sobre línea editorial, arquitectura de información y datos reales de Umami

---

## 1. Contexto y decisiones estratégicas

### 1.1 Diagnóstico

El sitio era una colección dispersa ("dump de cerebro"): CV + blog + facetas de identidad
("As a professional / teacher / human being / AIPH instructor") sin cabecera que las
subordinara. Las etiquetas de las secciones eran de *identidad*, no de *contenido*.

### 1.2 Decisión de fondo (responde "¿qué quiero comunicar?")

No ser "un medio de comunicación" multi-sección. El sitio es el **puente** entre dos etapas:

```
Software (20 años, cerrando) ──► PUENTE (ahora) ──► Difusión AIPH / Percepción Unitaria (destino)
         ingresos                 senior + docencia        + posible doctorado (Bohm)
                                  + escritura
```

- La cara profesional (senior, toma las riendas) **financia la transición**: la AIPH requiere
  inversión, no la genera. No es vanidad, es el motor.
- El blog es el **gimnasio del destino**: la difusión AIPH es comunicación; escribir ahora
  entrena la habilidad del futuro.
- La línea editorial **no es un tema, es un arco narrativo**: "Ingeniero con 20 años de oficio,
  ahora enseñando y escribiendo mientras su horizonte se mueve hacia Bohm."

### 1.3 AIPH

- Es vocación de vida ("hasta la muerte"), no fuente de ingresos.
- En este sitio: **una mención digna del rol + enlaces a los canales oficiales de la AIPH**.
  Cualquier contenido sobre Percepción Unitaria se publica *con ellos*, no aquí.
- El doctorado Bohm-semiconductores (potencial de Bohm simulado) es la única zona futura
  donde este sitio y Bohm convergen legítimamente — como contenido técnico-científico.
  Puerta abierta, no se construye hoy.

### 1.4 Datos de Umami (export `breakdown.csv`, con ruido de auto-tráfico)

- Audiencia probada: **contacto profesional** (`/contact` 23 visitantes, ~8 min lectura,
  `/as-a-professional` 15, `/` 93).
- Alumnos ITM: pequeños pero reales (`/as-a-teacher` 10 visitantes).
- Posts recientes en EN: lo único con descubrimiento externo, pero bounce alto y cero
  conversación → la "audiencia imaginaria que discute" no existe.
- Cola larga 2010–2018: casi muerta (~1 visitante/post, patrón de crawler). Archivar no
  cuesta tráfico.
- `/as-aiph-instructor`: **1 vista orgánica**. No hay audiencia que perder al simplificar.
- `/tags/*`: nadie navega por tags.
- `/as-a-human`: 388 views de solo 11 visitantes (auto-tráfico: él + esposa). No hay
  público que perder al retirarla.

### 1.5 Reglas de idioma (decisión 2026-09-07: español primero)

- **Todo el sitio en español**, con excepciones puntuales en inglés:
  `as-a-professional.md` y el CV (`resume.html`) — función probada: reclutadores.
  Excepciones futuras: caso por caso.
- Justificación: la audiencia real es ES (alumnos ITM con inglés débil, contactos
  profesionales mexicanos); los traductores automáticos de 2026 cubren al lector EN
  ocasional; el experimento "escribir EN esperando discusión" quedó cortado (sin
  canales ni tiempo de feedback).
- Posts históricos en EN (`from-jekyll-to-seite`, `the-justfile-task-runner-guide`,
  `goodbye-world`, y la cola larga 2010–2018): quedan como están — no se reescribe
  historia. Traducir los dos posts EN de 2026: opcional, baja prioridad.
- Posts nuevos: siempre ES.

---

## 2. Estructura objetivo

| Pieza | URL | Idioma | Función |
|---|---|---|---|
| Cabecera profesional | `/`, `/as-a-professional`, `/resume` | EN (CV) / ES (home) | Financia la transición |
| Blog | `/blog` | ES | Gimnasio de escritura + oficio |
| Docencia | `/as-a-teacher` | ES | Audiencia real (alumnos ITM) |
| Mención AIPH | `/as-aiph-instructor` (simplificada) | ES | Honor + enlaces oficiales |
| Archivo | `/blog` (posts < 2025 marcados) | ES | Sin mantenimiento, sin culpa |
| ~~As a human being~~ | *(retirada)* | — | Riesgo OSINT; no había audiencia |

**No-goals (explícitos):**
- NO crear sitio separado para AIPH (por ahora; re-evaluar si la difusión crece).
- NO crear colección `teaching` nueva con nested dirs — `as-a-teacher.md` ya funciona;
  re-evaluar cuando haya materiales que no quepan ahí.
- NO borrar posts viejos (no hay razones de SEO ni de tráfico; el archivo es parte de la
  trayectoria).
- NO tocar `as-a-professional.md` / `resume.html` (ya está bien posicionado: "engineering
  rigor en la era agéntica").
- NO sistema de tags con vocabulario controlado (nadie navega tags; no over-engineering).

---

## 3. Fases de ejecución

### Fase 0 — Acción manual del usuario (no agente)

- [x] Umami (cloud.umami.is → sitio → Settings): excluir IP propia y la de Xochitl. (Update: umami no tiene ese filtro)
- [x] Decidir email canónico: `author.yaml` dice `noe@noenieto.com`, `contact.md` usa
  `nnieto@noenieto.com`. Unificar.

### Fase 1 — Privacidad (retiro de "As a human being")

- [x] `content/pages/as-a-human.md` → mover a `_unused_images/`-equivalente de contenido:
  archivar el markdown en `_unused_content/` (crear; fuera de `content/` para que no
  compile). NO borrar.
- [x] Cuarentena de imágenes asociadas → `_unused_images/`: `static/dogs/*` (10 imgs),
  `static/hero/familia.png`, `static/hero/familia-perruna.png`.
- [x] `content/pages/index.md`: eliminar la tarjeta de aspecto "As a human being".
- [x] `content/posts/2026-07-20-from-jekyll-to-seite.md:155`: editar el párrafo que enlaza
  a `/as-a-human` (enlace roto potencial + menciona a Xochitl y la saga de perros).
  Reescribir breve, sin nombres de terceros.
- [x] Auditoría de datos personales en contenido (grep + revisión humana):
  - Nombres de terceros: `Xochitl`, familiares.
  - Posts tipo bitácora: `semana-29` ("Mi bitacora de actividades"), series `lecturas-*`.
  - Decisión por pieza: dejar / suavizar. El tráfico de estos posts es ~0; sin urgencia.
- [x] `data/author.yaml`: revisar URL de Facebook `https://www.facebook.com/nmnieto/x`
  (sufijo `/x` sospechoso de typo).

### Fase 2 — Mención AIPH digna

- [ ] Reescribir `content/pages/as-aiph-instructor.md` como página corta **en español**:
  - Rol: associate instructor, AIPH (~7 integrantes).
  - Enlaces a canales oficiales de difusión (percepcionunitaria.org y afines).
  - Una línea sobre el interés futuro (Bohm, posible investigación/doctorado).
  - El contenido largo actual (explicación de Psicología Holokinética y Percepción
    Unitaria) → archivar en `_unused_content/` por si la AIPH lo quiere aprovechar;
  el contenido de difusión vive en sus canales, no aquí.
- [ ] `content/pages/index.md`: mantener tarjeta "Holokinetic Psychology" apuntando a la
  página simplificada (renombrada como mención, no como sección temática).

### Fase 3 — Homepage y navegación (la cabecera)

- [ ] `content/pages/index.md`:
  - `description`: del "Senior Software developer with 25+ years" hacia la postura de
    transición: ingeniero senior que toma las riendas de desarrollos para resolver
    problemas de cliente; rigor de ingeniería en la era agéntica; docencia al lado.
    (Alineado con la descripción de `as-a-professional.md`.)
  - Hero: "Senior Software Engineer" se mantiene como marca (mismo registro que el CV)
    o se traduce — decidir al ejecutar; revisar `caption`/`alt`.
  - Aspects finales: 3 tarjetas — Professional / Teaching / Holokinetic Psychology.
  - Modelo de portada (3 funciones): **declaración** (hero/posicionamiento),
    **enrutado suave** (3 puertas con descripciones — sin pedirle al visitante
    auto-identificarse), **prueba de vida** (últimas entradas). La home no es un
    portal de selección explícita; atiende el momento "quién es esta persona".
- [ ] Traducir a español las páginas hoy en EN (audiencia ES): `contact.md`,
  `demos.md`, `as-a-teacher.md` (crítico: sus lectores son alumnos sin inglés fuerte).
- [ ] Opcional: `templates/404.html` está en pseudo-inglés arcaico ("Behold the
  field…"); hispanizar manteniendo el tono lúdico.
- [ ] `data/nav.yaml`: añadir entrada "Teaching" → `/as-a-teacher` (los alumnos entran
  directo; hoy no está en nav). Hispanizar etiquetas de nav (About → Acerca,
  Contact → Contacto) — la audiencia por defecto es ES.
- [ ] Hispanizar el chrome de la UI en `data/i18n/es.yaml` (los defaults del tema son EN;
  hoy solo traduce `contents`). Claves usadas por los templates: `newer`, `older`,
  `search_placeholder`, `search_label`, `no_results`, `min_read`, `next_post`,
  `prev_post`, `page_n_of_total`. Nota: `language = "es"` ya está en `seite.toml`
  (html lang, og:locale, RSS); esto es solo la capa de strings visibles.
- [ ] Aceptado (no-goal): las páginas EN (resume, as-a-professional) emiten
  `lang="es"` — corregirlo exigiría el modo i18n completo de seite (`[languages]` +
  sufijos `.en.md`); no vale el costo para 2-3 páginas.

### Fase 4 — Marcar el archivo (posts < 2025-01-01)

- [ ] `templates/post.html`: nota de archivo condicional **por fecha** (no tocar 140
  archivos de contenido): si `page.date < 2025-01-01`, renderizar una línea discreta
  estilo monografía: "ARCHIVO — escrito en YYYY. Puede estar desactualizado."
  - Override opcional por frontmatter: `status: evergreen` para posts viejos que siguen
    vigentes (decidible caso por caso después).
  - Estilo según skill `design-system` (rubric `#E65100`, small caps, sin contenedor
    llamativo — regla no-contenedores).
- [ ] Verificar que `from-jekyll-to-seite` y `the-justfile-task-runner-guide` (2026) NO
  queden marcados.

### Fase 5 — Verificación

- [ ] `seite build` (o tool MCP `seite_build`) sin errores.
- [ ] Grep de enlaces internos rotos: `as-a-human`, `dogs/`, `familia` en `content/` y
  `templates/`.
- [ ] Verificación visual con `chrome-devtools` **y** `frefox-devtools` (ambos, según
  AGENTS.md): home, blog, un post archivado, un post 2026, as-a-teacher, AIPH simplificada,
  404. El usuario arranca `just watch` — el agente no lanza ni mata servidores.
- [ ] Lighthouse opcional (regresión de a11y/SEO) con `chrome-devtools_lighthouse_audit`.

### Fase 6 — Post-deploy (cuando el usuario decida)

- [ ] Recordatorio AGENTS.md: `base_url` ya apunta a producción — verificar antes de deploy.
- [ ] Deploy con `seite deploy` (GitHub Pages, `auto_commit = true`).
- [ ] Re-leer Umami en 30 días con IPs excluidas → cerrar la decisión de idioma con
  datos limpios.

---

## 4. Reglas editoriales a futuro (memoria para agentes)

1. Blog en español, cuando nazca escribir. Dos rieles válidos: el oficio (incluida la
   veta "ingeniero veterano que va cerrando") y, si llega el doctorado, lo
   cuántico-técnico.
2. AIPH: si escribe algo de Percepción Unitaria/Bohm-difusión → se publica con la AIPH,
   no aquí. Aquí solo la mención.
3. Español por defecto en todo. Excepciones EN: `as-a-professional` y CV. Posts
   nuevos: ES.
4. No crear secciones nuevas sin pasar por este plan. La fragmentación venía de fingir
   tres sitios en uno.
5. Metadatos mínimos por post: `title`, `description` (= qué se lleva el lector),
   `tags` opcional. Sin vocabulario controlado por ahora.
6. Privacidad por defecto: sin nombres de terceros, sin mascotas por nombre, sin
   rutinas/ubicación deducible. El toque humano se escribe sin datos identificables.

---

## 5. Referencias

- Skill de diseño: `.agents/skills/design-system/SKILL.md` (tokens, no-contenedores).
- Convenciones de plantillas e imágenes: `AGENTS.md`.
- MCP `seite` para build/docs: preferir `seite_build`, `seite_lookup_docs`.
- Export de datos: `~/Descargas/breakdown.csv` (Umami, path breakdown, con
  auto-tráfico sin filtrar).
