## Táctica: AI Crawler Policy (`llms.txt`, `robots.txt`)

**Descripción:** Definir y comunicar explícitamente cómo los crawlers de IA (como los utilizados por Perplexity, Claude, ChatGPT, Gemini, Brave Search) deben o no deben interactuar con el sitio web.

**Popularidad:** Creciente (tendencia clave 2025-2026).

**Relevancia:** Permite controlar la indexación y el uso del contenido por parte de las IAs, indicando qué partes del sitio son apropiadas para indexación, citación o generación.

**Métodos Principales:**

1.  **`llms.txt`:**
    *   Archivo en la raíz del sitio (`https://tusitio.com/llms.txt`).
    *   Similar a `robots.txt`, pero específico para LLM crawlers.
    *   Permite especificar directivas como `Disallow: /private/` o `Allow: /public-content/`.
    *   Actualmente adoptado por Perplexity, Claude, y otros motores de búsqueda de IA.

2.  **`robots.txt`:**
    *   Se puede usar para crawlers de IA específicos mediante `User-agent`.
    *   Ejemplo: `User-agent: PerplexityBot\nDisallow: /unindexed/`
    *   `Allow` y `Disallow` generales también aplican si el crawler de IA los respeta.

3.  **Meta Tags:**
    *   `noyaca`: Para indicar que el contenido no debe ser usado para entrenamiento de IA (aunque `llms.txt` es más estándar).

**Verificación:**

*   Asegurar la existencia y correcta ubicación de `llms.txt`.
*   Validar la sintaxis y las directivas en `robots.txt` y `llms.txt`.
*   Utilizar herramientas de simulación de crawlers de IA (si están disponibles) o revisar logs del servidor para confirmar el comportamiento.

**Ejemplo (`llms.txt`):**
```
# Allow Perplexity, Claude, and OpenAI crawlers to access all public content.
Allow: /

# Disallow crawling of private or non-public facing content.
Disallow: /admin/
Disallow: /private/
Disallow: /drafts/

# Respect crawl-delay for specific crawlers if needed.
# Crawl-delay: 1
```

**Fuentes:** claude-seo-ai, agentic-seo-skill, Google AI Optimization Guide (Mayo 2026).