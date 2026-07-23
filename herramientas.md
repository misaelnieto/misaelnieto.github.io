Basándome en mi investigación, aquí está un análisis exhaustivo de herramientas modernas para auditoría SEO que se integran bien con agentes LLM como OpenCode/Claude Code:

## **🏆 HERRAMIENTAS DE ALTO SCORING**

### **1. RustySEO (Cli + TUI)** ⭐⭐⭐⭐⭐
**Puntuación: +16 pts** | CLI/TUI | Rust | Open-source

RustySEO CLI es una herramienta de análisis SEO basada en terminal construida con Rust, que ofrece análisis de sitios web, verificación de enlaces rotos, auditoría de redirecciones y exportación de reportes directamente desde la línea de comandos, siendo ideal para tuberías CI/CD como GitHub Actions, GitLab CI y Jenkins.

**Ventajas:**
- ✅ CLI/TUI nativos (menú interactivo)
- ✅ Escrito en Rust (velocidad excepcional para sitios grandes 30k+ páginas)
- ✅ Funciona con localhost/sistemas de archivos
- ✅ Análisis de logs de servidores (Nginx/Apache)
- ✅ Sin límites de crawl

**Detalles:** +5 (CLI) +5 (Rust) = **+10 pts base**

---

### **2. seofordev** ⭐⭐⭐⭐
**Puntuación: +11 pts** | CLI | Go | Especializado localhost
https://seofor.dev/docs/

seofordev es una herramienta CLI de código abierto para auditorías SEO de localhost que detecta páginas renderizadas con JavaScript, respeta robots.txt, genera mensajes de optimización listos para IA, e incluye integración con IndexNow.

**Ventajas:**
- ✅ **Específicamente diseñado para localhost** (`.`/3000/8080)
- ✅ Exporta en formato listo para IA (AI-Ready Exports)
- ✅ Rápido (Go/Playwright)
- ✅ Zero-config
- ✅ Integración con IndexNow

**Detalles:** +5 (CLI) +2 (Go es similar a Rust) +4 (localhost-first) = **+11 pts**

Nota: Ya esta instalado en esta maquna

---

### **3. SEOmator/seo-audit-skill** ⭐⭐⭐⭐⭐
**Puntuación: +13 pts** | CLI + Claude Code Skill | Node.js

SEOmator es una herramienta de auditoría SEO completa que escanea contra 251 reglas en 20 categorías incluyendo SEO técnico, Core Web Vitals, datos estructurados, accesibilidad, encabezados de seguridad y preparación para búsqueda de IA/GEO, disponible como herramienta CLI, aplicación Electron y skill de Claude Code, con formato --format llm que produce XML optimizado para agentes de IA.

**Ventajas:**
- ✅ **-1 (Node.js)** pero **+2 (MCP-like via Claude Skills)**
- ✅ 251 reglas en 20 categorías (cobertura excepcional)
- ✅ Integración nativa con Claude Code
- ✅ Output en formato LLM-optimizado (XML inyección-seguro)
- ✅ Mide Core Web Vitals (LCP, CLS, FCP, TTFB, INP)
- ✅ Opción `--no-cwv` para análisis rápido

**Detalles:** +5 (CLI) +2 (skill/agent) -1 (Node) +5 (integración LLM) = **+11 pts**

---

### **4. Black SEO Analyzer** ⭐⭐⭐
**Puntuación: +12 pts** | CLI + GUI | Rust

Black SEO Analyzer es una herramienta CLI profesional que analiza 300+ tipos de problemas, soporta aplicaciones de una sola página (SPA), y ofrece análisis impulsado por Claude API con salida en formatos JSON, XML, CSV e HTML, con opciones de solicitudes concurrentes y limitación de tasas.

**Ventajas:**
- ✅ Rust (aunque GUI es Electron = -2.5)
- ✅ 300+ tipos de problemas detectados
- ✅ Integración con Claude/OpenAI para análisis AI
- ✅ SPA support (JavaScript rendering)
- ✅ Versión CLI sin licencia: funciona pero con límites de crawl

**Detalles:** +5 (CLI) +5 (Rust) -2 (GUI Electron disponible) +2 (integración AI) = **+10 pts**

https://github.com/sethblack/black-seo-analyzer

---

## **🔧 HERRAMIENTAS ESPECIALIZADAS**

### **5. Link Checkers**

**Lychee (Rust)** ⭐⭐⭐⭐⭐
```bash
lychee https://example.com  # o localhost:3000
lychee ./docs               # archivos locales
```
**Puntuación: +10 pts** | +5 (CLI) +5 (Rust) | Específico para broken links

**Alternativa Go:**
**Broken Link Checker** - Similar performance, CLI nativo

Nota: Lychee ya esta instalado en esta maquina
---

### **6. MCPs para SEO**

**SiteAudit MCP** ⭐⭐⭐⭐
**Puntuación: +4 pts** | MCP | No requiere API keys

SiteAudit MCP es un servidor MCP que proporciona auditoría instantánea de SEO, rendimiento y seguridad sin necesidad de claves API, configuración o costo, con 20+ verificaciones de SEO incluyendo título, meta descripción, encabezados, imágenes, enlaces, canónico, Open Graph, Twitter Cards y datos estructurados.

**Ventajas:**
- ✅ +2 (MCP)
- ✅ Zero-config (sin API keys)
- ✅ Integración con Claude Code/Cursor/Windsurf
- ✅ 8 herramientas: auditoría completa, análisis SEO, headers de seguridad, Core Web Vitals

---

**SEO-MCP (anurag-kalita)** ⭐⭐⭐
**Puntuación: +6 pts** | MCP | 19 herramientas

Un servidor MCP de código abierto que convierte Claude en consultor SEO completo, proporcionando 19 herramientas para análisis de página, Core Web Vitals, validación de datos estructurados, investigación de palabras clave y análisis de backlinks, con 12 de 19 herramientas funcionando sin claves API.

---

**DataSEO MCP** ⭐⭐⭐
**Puntuación: -8 pts** | MCP | Usa Ahrefs (ver advertencia abajo)

DataSEO MCP es un servidor de Protocolo de Contexto de Modelo para investigación SEO práctica que combina datos SEO gratuitos de Ahrefs con respaldo de proveedor de CAPTCHA y planificación de consultas impulsada por OpenRouter.

⚠️ **Advertencia:** Requiere CAPTCHA solver (CapSolver/Anti-Captcha) para eludir detección - **-10 pts por versión paga requerida efectivamente**

---

**mcp-gsc (Google Search Console)** ⭐⭐
**Puntuación: +2 pts** | MCP | Conecta GSC a Claude

Servidor MCP que conecta Google Search Console a asistentes de IA, permitiendo analizar datos SEO mediante conversaciones en lenguaje natural, funciona con Claude Desktop, Cursor, Codex CLI y otros clientes compatibles con MCP.

---

## **📊 HERRAMIENTAS COMPLEMENTARIAS**

### **7. Validadores de Schema/Structured Data**

**Apify Schema Validator (CLI)** ⭐⭐⭐
**Puntuación: +2 pts** | API wrapper | Valida JSON-LD

- Extrae/valida JSON-LD, Microdata, RDFa
- Interfaz web + CLI via Apify
- Requiere Apify account (free tier available)

---

### **8. Content Analysis (Python)**

**py-readability-metrics** ⭐⭐⭐
```bash
pip install py-readability-metrics
python -m readability --file content.txt
```
**Puntuación: +5 pts** | +5 (Python, CLI-compatible)

Métricas:
- Flesch-Kincaid Grade Level
- Gunning Fog Index
- Coleman-Liau Index
- Dale-Chall Readability

---

**textstat** (Python) ⭐⭐⭐
Librería más completa con soporte multiidioma

---

### **9. SEO Analyzers (Python)**

**seo-analyzer** ⭐⭐⭐
```bash
pip install seo-analyzer
seo-analyzer -u https://localhost:3000
```
**Puntuación: +8 pts** | +5 (CLI) +5 (Python) -2 (usa headless chrome = dependencia pesada)

Cubre: On-page, Technical, Content, Site Audit completo

**SEOaudit** ⭐⭐
```bash
pip install seoaudit
seoaudit -u http://localhost:3000 -p  # Parse sitemap
```

---

**SEO Bhishma CLI** ⭐⭐
```bash
pip install seo-bhishma-cli
seo-bhishma-cli
```
Funciones: LinkSniper, SiteMapper, IndexSpy

---

## **📈 MATRIZ DE PUNTUACIÓN RESUMIDA**

| Herramienta | CLI | Lenguaje | Localhost | LLM-Ready | Core Web Vitals | Puntos |
|---|---|---|---|---|---|---|
| **RustySEO** | ✅ | Rust | ✅ | Media | ❌ | **+16** |
| **seofordev** | ✅ | Go | ✅✅ | Alto | ❌ | **+11** |
| **SEOmator** | ✅ | Node/-1 | ✅ | ✅✅ | ✅ | **+11** |
| **Black SEO** | ✅ | Rust | ✅ | ✅ | ❌ | **+10** |
| **Lychee** | ✅ | Rust | ✅ | Media | ❌ | **+10** |
| **SiteAudit MCP** | MCP | TS/-1 | ✅ | Alto | ✅ | **+4** |
| **SEO-MCP** | MCP | TS/-1 | ✅ | Alto | ✅ | **+6** |
| **seo-analyzer** | ✅ | Python | ✅ | Media | ❌ | **+8** |

---

## **🎯 RECOMENDACIÓN PARA TU SETUP**

### **Para auditoría completa:**
```bash
# Stack recomendado
1. seofordev              # Localhost-first, IA-ready
2. SEOmator CLI           # 251 reglas exhaustivas
3. Lychee                 # Link checking rápido
4. SiteAudit MCP          # Integración MCP nativa
```

### **Para integración OpenCode:**
```toml
# config.toml (Claude Code)
[skills]
seo-audit = "seo-skills/seo-audit-skill"
seo-mcp = "anurag-kalita/seo-mcp"
siteaudit = "vdalhambra/siteaudit-mcp"
```

### **Para Zola/Jekyll:**
```bash
# Pre-build checks
seofordev --port 3000 --build
seo audit run > ./reports/seo-baseline.json

# Link validation
lychee ./dist --offline

# MCP integration
npx skills add seo-skills/seo-audit-skill
```

---

## **⚠️ ADVERTENCIAS**

- **Evitar:** Herramientas que solo ofrecen versión paga de APIs (Ahrefs, Semrush, Moz) = **-10 pts**
- **Evitar:** Herramientas basadas en web pura (UI = -5 pts cada una)
- **Considerar:** Puppeteer/Playwright como dependencia = rendimiento lento en máquinas pequeñas
- **Nota:** Google PageSpeed Insights API requiere key pero tier gratuito disponible

---

Aquí están los **5 AI Skills/Prompts más recientes (2025-2026)** para auditoría y mejora de SEO, enfocados en tendencias emergentes como **AEO (Answer Engine Optimization)** y **GEO (Generative Engine Optimization)**:

---

## **🏆 1. claude-seo-ai (Hainrixz) — Dual Scoring SEO + AI Visibility** ⭐⭐⭐⭐⭐

**GitHub:** `github.com/Hainrixz/claude-seo-ai` | **v2.0 | Junio 2026**

### Qué hace:
Audita tu sitio en **dos ejes independientes**: Google SEO clásico + AI Visibility (GEO/AEO), cada uno con su propia puntuación. Un página puede rankear bien en Google pero ser no-citable por Claude, ChatGPT, Perplexity.

### Prompts clave:

```bash
# Auditoría completa dual
/claude-seo-ai:audit https://mi-sitio.com

# Solo AI readiness
/claude-seo-ai:audit https://mi-sitio.com --aeo-only

# Con fixes automáticos (read-only auditors, write-only one fixer subagent)
/claude-seo-ai:fix https://mi-sitio.com
```

### Qué evalúa:
- **SEO Clásico:** Crawlability, indexability, Core Web Vitals, rendering (CSR/SSR/SSG)
- **AI Visibility (GEO/AEO):**
  - ✅ **Self-contained answer blocks** (120-180 palabras)
  - ✅ **Fact density & original data** (criterio Princeton/Georgia Tech 2025)
  - ✅ **Entity linking** (Wikipedia, Reddit, YouTube, LinkedIn)
  - ✅ **AI crawler access** (OAI-SearchBot, Claude-SearchBot, PerplexityBot)
  - ✅ **llms.txt compliance** (marca de confianza para AI crawlers)

### Ejemplo de prompt:
```
"Audit my blog at localhost:3000 for both traditional SEO and AI answer engines. 
Tell me:
1. Will Perplexity cite my content?
2. Can Claude extract my answers for follow-up questions?
3. Are my entity definitions clear enough for LLM retrieval?"
```

**Lenguaje:** Python/Node | **Lanzamiento:** 1 Junio 2026 | **9k+ stars**

---

## **📝 2. claude-blog (AgriciDaniel) — Content Strategy + Dual Optimization** ⭐⭐⭐⭐⭐

**GitHub:** `github.com/AgriciDaniel/claude-blog` | **v1.9.0 | Mayo 2026**

### Qué hace:
Skill completo para escribir, optimizar y auditar blog content a escala. **Dual-optimizado** para Google Rankings (Core Update Diciembre 2025 + E-E-A-T) Y para citation en AI Overviews/ChatGPT/Perplexity.

### Prompts clave:

```bash
# Escribir artículo completo con SEO + AI optimization
/blog write "AI Search Visibility for 2026" --target-url https://mi-sitio.com/blog/ai-seo

# Detectar topic clusters y cannibalization
/blog cluster

# Auditar contenido existente contra E-E-A-T + GEO
/blog audit --url https://mi-sitio.com/blog/articulo-existente

# Multilingual publishing con misma calidad SEO
/blog multilingual --languages es,fr,de
```

### Qué cubre:
- **Investigación:** Google SERP analysis + AI citation patterns
- **Outline:** Topic clustering + question-based hierarchy (para fragmentos)
- **Redacción:** Content guidelines que priorizan **citability sobre length**
- **Schema:** Auto-generated JSON-LD para Article, BlogPosting, FAQPage
- **Internal linking:** Link graph optimization para flujo de autoridad
- **Citation verification:** Fact-check automático con fuentes

### Características únicas 2026:
- ✅ **Answer-first formatting** (CNN-style "Answer Summary" en primeras 100 palabras)
- ✅ **Citation capsules** (bloques de 134-167 palabras auto-citables)
- ✅ **Image generation via Gemini** (hero + inline illustrations + social cards)
- ✅ **SVG chart generation** (7 estilos: bar, line, donut, radar, etc.)
- ✅ **YouTube embedding con noscript fallback** (para AI crawlers que no ejecutan JS)

### Ejemplo de prompt:
```
"Write a blog post about 'E-E-A-T signals in 2026' that:
1. Opens with a 100-word answer summary answerable by ChatGPT
2. Includes 3 self-contained answer blocks (140 words each)
3. Has statistics with original data (not just quoted from others)
4. Generates FAQSchema for the top 5 questions readers ask
5. Auto-links to 5 related posts on our site
6. Is dual-optimized for Google + Perplexity citation"
```

**Lenguaje:** Python/Node | **Lanzamiento:** Mayo 2026 | **1.1k stars, rápido crecimiento**

---

## **🎯 3. claude-seo (AgriciDaniel) — Universal SEO + GEO/AEO Core Skill** ⭐⭐⭐⭐⭐

**GitHub:** `github.com/AgriciDaniel/claude-seo` | **v2.2.4 | Junio 2026 (LATEST)**

### Qué hace:
**25 sub-skills + 18 specialist agents** en paralelo que cubren todo: Technical SEO, E-E-A-T, Schema.org, GEO/AEO, backlinks, local SEO, mapas, clustering semántico, e-commerce, internacional.

### Prompts clave:

```bash
# Auditoría rápida (1-2 min, top 7 páginas)
/seo audit --mode quick

# Auditoría completa (5-10 min, crawl todas las páginas)
/seo audit --mode full

# Auditoría con Google Search Console integration
/seo audit --with-gsc https://mi-sitio.com

# Semantic clustering para content strategy
/seo semantic-gap --seed-keyword "AI search visibility"

# GEO/AEO readiness check
/seo geo-readiness --check-ai-crawlers

# Schema validation + auto-generation
/seo schema audit --generate-missing

# Citation tracking across AI platforms
/seo citation-tracker --platforms chatgpt,perplexity,claude
```

### Qué evalúa (251 reglas):

**Technical (M1-M4):** Crawlability, robots.txt, indexability, rendering
**On-Page (M7-M10):** Titles, headings, images, internal linking  
**Content (M11-M12):** Answer extractability, fact density, original data
**AI/GEO (M14, M21):** AI crawler access, llms.txt presence, citability

### Características 2026:
- ✅ **Passage citability scoring** (134-167 word self-contained blocks)
- ✅ **Entity presence detection** (Wikipedia, Reddit, YouTube, LinkedIn linkage)
- ✅ **Attribution density** (¿cita fuentes?)
- ✅ **Alineación con Google AI Optimization Guide** (Mayo 2026)
- ✅ **Deprecated schema detection** (FAQPage eliminated May 7 2026, etc.)

### Ejemplo de prompt:
```
"Run a full SEO audit on https://example.com with:
1. Google Search Console data for the last 3 months
2. Citation readiness for ChatGPT, Perplexity, and Claude AI
3. Topic cluster analysis with semantic gaps
4. Entity linking opportunities vs Wikipedia
5. AI crawler access check (llms.txt, robots.txt directives)
Output PDF + Excel with prioritized roadmap"
```

**Lenguaje:** Python/Node | **Lanzamiento:** Continua, última v2.2.4 Junio 2026 | **9.5k+ stars**

**Ecosistema:** Integración opcional con DataForSEO API, Firecrawl, Banana (infraestructura)

---

## **🧬 4. claude-skill-seo-geo-optimizer (199 Biotechnologies)** ⭐⭐⭐⭐

**GitHub:** `github.com/199-biotechnologies/claude-skill-seo-geo-optimizer` | **v1.3 | Mayo 2026**

### Qué hace:
Skill **basado en research** (Princeton/Georgia Tech "Generative Engine Optimization" + AgenticGEO 2026). Analiza contenido para **search engines tradicicionales + AI platforms** (ChatGPT, Perplexity, Claude, Gemini, Brave).

### Prompts clave:

```bash
# GEO/AEO audit con methodology research-backed
/seo-geo-optimizer analyze https://mi-blog.com/articulo

# Multi-platform citation tracking
/seo-geo-optimizer citation-check --platforms all

# Entity extraction + optimization
/seo-geo-optimizer extract-entities https://mi-blog.com

# Schema generation basado en content type
/seo-geo-optimizer generate-schema --type article
```

### Hallazgos 2026 del repositorio:
- ⚡ **Tactics que mantienen dirección** (pero con lifts más bajos que 2025):
  - Añadir estadísticas originales (+X%)
  - Named-authority quotations (+X%)
  - Fluency en redacción (+X%)
  - Citing sources (+X%)
  - Authoritative phrasing (+X%)

- 📊 **Position bias es fuerte:** Material en primeros 30% de la página obtiene desproporcionada share de AI citations (iPullRank 2026)

- 🔍 **Perplexity selecciona a nivel passage** (no page level) — 366k-citation arXiv study, Julio 2025

- ⚠️ **Schema-as-GEO-lever fue overstated:** Ahrefs midió ~+2.4% lift de AI Mode solo por añadir JSON-LD (1,885 pages)

- 🌐 **Brave Search visibility correlaciona más con Claude citation** que Google ranking

### Ejemplo de prompt:
```
"Optimize this article for AI citation:
1. Identify where I can add original research/statistics
2. Find authority figures I should quote (academic + industry)
3. Rewrite passages for maximum 'citability' (clarity + self-contained)
4. Position my most important claim in first 30% of article
5. Generate passage-level snippets (200 words each) optimized for Perplexity extraction"
```

**Lenguaje:** Python | **Lanzamiento:** Mayo 2026 | **MIT License** | **Datos empíricos 2026**

---

## **🔬 5. Agentic-SEO-Skill (Bhanunamikaze)** ⭐⭐⭐⭐

**GitHub:** `github.com/Bhanunamikaze/Agentic-SEO-Skill` | **v1.2 | Mayo 2026**

### Qué hace:
**LLM-first SEO analysis** con 16 sub-skills especializados, 10 specialist agents, 88 utility scripts como "evidence collectors". Funciona en Claude Code, Codex, Antigravity, Cursor, Windsurf.

### Prompts clave:

```bash
# Page fetch + SEO header extraction
/seo-agent fetch https://mi-sitio.com/pagina

# Crawl multi-página + status/metadata analysis
/seo-agent crawl https://mi-sitio.com --depth 2

# Indexability verdict (robots, meta robots, canonicals, sitemaps)
/seo-agent indexability https://mi-sitio.com

# Core Web Vitals + PageSpeed check
/seo-agent cwv https://mi-sitio.com

# AI crawler policy verification
/seo-agent robots-ai --check-gptbot,claudebot,perplexitybot

# Sitemap analysis + XML validation
/seo-agent sitemap https://mi-sitio.com/sitemap.xml

# GitHub repository SEO report (parasite SEO)
/seo-agent github-seo https://github.com/mi-repo
```

### 16 Sub-skills:
1. **Page Fetch** — Headers + local HTML output
2. **Meta Extraction** — Titles, metadata, headings, links, schema
3. **Core Web Vitals** — LCP, CLS, INP integration
4. **Crawl Analysis** — Multi-page status, depth, duplicates
5. **Indexability** — robots.txt, meta robots, canonicals, sitemaps
6. **AI Crawler Policy** — OAI-SearchBot, Claude-SearchBot checks
7. **Sitemap Validation** — XML, limits, lastmod quality
8. **Image Analysis** — Alt text, dimensions, LCP candidates
9. **Schema Validation** — JSON-LD syntax, required fields, deprecated types
10. **GitHub SEO** — Repository README + Awesome lists optimization
11. **Deduplication** — Findings validation + prioritization
12-16. **Utility collectors** (88 total)

### Ejemplo de prompt:
```
"Audit our GitHub repository for parasite SEO opportunities:
1. Check if our README is optimized for 'Claude Code skills' SERPs
2. Verify our Awesome list is linkable + citation-worthy
3. Generate schema markup for our code examples
4. Check if AI crawlers can fetch our documentation
5. Recommend improvements for appearing in ChatGPT/Claude search results"
```

**Lenguaje:** Python/Node | **Lanzamiento:** Mayo 2026 | **Evidence-based approach**

---

## **📊 TABLA COMPARATIVA RÁPIDA**

| Skill | Enfoque | Mejor para | Updater | GEO/AEO |
|---|---|---|---|---|
| **claude-seo-ai** | Dual scoring (SEO vs AI) | Sitios que necesitan ambos | Hainrixz | ⭐⭐⭐⭐⭐ |
| **claude-blog** | Content strategy + writing | Bloggers + content teams | AgriciDaniel | ⭐⭐⭐⭐⭐ |
| **claude-seo** | Universal 25-skill suite | Agencias + sitios complejos | AgriciDaniel | ⭐⭐⭐⭐⭐ |
| **seo-geo-optimizer** | Research-backed + citation | Académico + científico | 199-Bio | ⭐⭐⭐⭐ |
| **agentic-seo-skill** | GitHub-first + parasite SEO | Devs + open-source projects | Bhanu | ⭐⭐⭐⭐ |

---

## **🚀 PROMPTS COMBINADOS (5-SKILL STACK)**

### **Flujo de auditoría completa (30 min):**

```
1. /claude-seo-ai:audit mi-sitio.com                  # Dual scoring
2. /seo audit --with-gsc mi-sitio.com                 # Full technical
3. /seo-geo-optimizer analyze mi-blog.com/post-1      # Citation readiness
4. /blog audit --url mi-blog.com/post-1               # Content quality
5. /seo-agent robots-ai --check-all-crawlers          # AI access verification
```

### **Flujo de optimización (1 semana):**

```
Día 1: /claude-seo-ai:audit mi-sitio.com 
Día 2: /seo semantic-gap + /blog cluster
Día 3: /blog write + /seo-geo-optimizer optimize
Día 4: /seo schema validate + /seo citation-tracker
Día 5: /seo-agent robots-ai + llms.txt generation
```

### **Prompt master para auditoria AEO:**

```
"Audit my site for Answer Engine Optimization (AEO) readiness:

1. Can ChatGPT, Perplexity, and Claude cite my content?
2. Do I have self-contained answer blocks (120-180 words)?
3. What's my fact density score vs competitors?
4. Am I linking to authority entities (Wikipedia, academic)?
5. Can AI crawlers reach my content (llms.txt check)?
6. Are my titles/headings framed as questions/answers?
7. Generate a prioritized fix roadmap for AI visibility

Use claude-seo-ai for dual scoring + claude-seo-geo-optimizer for citation analysis."
```

---

## **💡 RESUMEN: TRENDS CLAVE 2025-2026**

✅ **AEO/GEO son rebranding de SEO** — Google AI Optimization Guide (Mayo 2026)  
✅ **Position bias en AI citations** — Primeros 30% de contenido dominan  
✅ **Passage-level extraction** — Perplexity elige passages, no páginas  
✅ **Original data > length** — Statistics + research > word count  
✅ **llms.txt es seguro** — 844k+ sitios lo implementan  
✅ **AI crawlers no ejecutan JS** — SSR/SSG > SPA para visibilidad  
✅ **Entity linking importa** — Wikipedia, Reddit, LinkedIn presence

Todos estos skills están **actualizados a junio 2026** y alineados con:
- Google Quality Rater Guidelines (Septiembre 2025)
- Google AI Optimization Guide (Mayo 2026)
- December 2025 Core Update requirements
- Research académico Princeton/Georgia Tech 2025-2026
-
