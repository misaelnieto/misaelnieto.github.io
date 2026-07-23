## Táctica: AI Crawler Policy & `llms.txt` Compliance

**Descripción:** Configurar directivas claras para los crawlers de Inteligencia Artificial (IA) sobre cómo deben acceder y procesar el contenido de un sitio web, utilizando principalmente el archivo `llms.txt` y directivas en `robots.txt`.

**Popularidad:** Emergente / Alta (Tendencia clave 2025-2026).

**Relevancia:** Esencial para controlar la indexación y el uso del contenido por parte de motores de búsqueda de IA y LLMs, asegurando que el contenido deseado sea accesible y el no deseado sea excluido.

**Mecanismos Principales:**

1.  **`llms.txt` (Archivo de Políticas para LLMs):**
    *   Ubicación: Raíz del sitio (`https://tusitio.com/llms.txt`).
    *   Propósito: Similar a `robots.txt` pero específico para crawlers de IA. Define qué contenido pueden consumir para entrenamiento o indexación.
    *   Directivas Comunes:
        *   `Allow: /`: Permite el acceso general.
        *   `Disallow: /private/`: Bloquea directorios específicos.
        *   `Disallow: /drafts/`: Bloquea contenido en desarrollo.
        *   `Crawl-delay: N`: Controla la velocidad de rastreo para crawlers de IA.
    *   Adoptado por: Perplexity, Claude, OpenAI (a través de OAI-SearchBot), Gemini, Brave Search.

2.  **`robots.txt`:**
    *   Se puede usar para crawlers de IA específicos mediante `User-agent`.
    *   Ejemplo: `User-agent: PerplexityBot\nDisallow: /non-ciitable-content/`
    *   `Allow` y `Disallow` generales también aplican si el crawler de IA los respeta.

3.  **Meta Tags (Menos común para IA):**
    *   `"robots", "noyaca"`: Puede indicar que el contenido no debe ser usado para entrenamiento de IA, aunque `llms.txt` es más explícito.

**Verificación:**

*   **Existencia y Ubicación:** Asegurarse de que `llms.txt` esté en la raíz y sea accesible.
*   **Sintaxis:** Validar la sintaxis de `llms.txt` y `robots.txt`.
*   **Simulación:** Usar herramientas (si existen) o revisar logs del servidor para verificar cómo los crawlers de IA interactúan con el sitio.
*   **Prueba de Acceso:** Intentar acceder a secciones bloqueadas o permitidas a través de simuladores de crawlers de IA.

**Ejemplo de `llms.txt`:**
```
# Allow all AI crawlers to access public content.
Allow: /

# Disallow crawling of sensitive or non-public sections.
Disallow: /private/
Disallow: /user-data/

# Specify crawl-delay for preferred AI crawlers if needed.
# Crawl-delay: 1
```

**Fuentes:** Google AI Optimization Guide (Mayo 2026), agentic-seo-skill, claude-seo-ai.