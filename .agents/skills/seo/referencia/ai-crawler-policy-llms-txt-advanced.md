## Táctica: AI Crawler Policy & `llms.txt` Compliance (Advanced)

**Descripción:** Configurar directivas explícitas para crawlers de Inteligencia Artificial (IA) sobre cómo deben acceder y procesar el contenido de un sitio web, utilizando principalmente el archivo `llms.txt` y directivas específicas en `robots.txt`.

**Popularidad:** Alta (Tendencia clave 2025-2026 para control de IA).

**Relevancia:** Esencial para gestionar la indexación y el uso del contenido por parte de motores de búsqueda de IA y LLMs, asegurando que el contenido deseado sea accesible para IA y el no deseado sea correctamente excluido.

**Mecanismos Principales:**

1.  **`llms.txt` (Archivo de Políticas para LLMs):**
    *   Ubicación: Raíz del sitio (`https://tusitio.com/llms.txt`).
    *   Propósito: Define las reglas de acceso y procesamiento de contenido para crawlers de IA. Más específico que `robots.txt` para este fin.
    *   Directivas Comunes:
        *   `Allow: /`: Permite el acceso general a todo el contenido público.
        *   `Disallow: /private/`: Bloquea directorios específicos (ej. contenido para miembros, datos de usuario).
        *   `Disallow: /drafts/`: Bloquea contenido en desarrollo o no publicado.
        *   `Crawl-delay: N`: Controla la velocidad de rastreo para crawlers de IA específicos.
    *   Adoptado por: Perplexity, Claude, OpenAI (OAI-SearchBot), Gemini, Brave Search, y otros motores emergentes.

2.  **`robots.txt` (Directivas Específicas para IA):**
    *   Se puede usar para dirigir crawlers de IA específicos mediante `User-agent`.
    *   Ejemplo: `User-agent: PerplexityBot\nDisallow: /non-ciitable-content/`
    *   Combinar reglas generales de `robots.txt` con directivas específicas para IA si es necesario.

3.  **Meta Tags (`robots`, `googlebot`):**
    *   Aunque `llms.txt` es más explícito, las meta tags `noindex`, `nofollow`, `noai`, `noimageai` pueden complementar las directivas, aunque su adopción por parte de todos los crawlers de IA puede variar.

**Verificación:**

*   **Existencia y Ubicación:** Confirmar que `llms.txt` esté en la raíz y sea accesible públicamente.
*   **Sintaxis y Configuración:** Validar la sintaxis de `llms.txt` y `robots.txt`.
*   **Simulación/Logs:** Utilizar herramientas de simulación de crawlers de IA o revisar logs del servidor para verificar cómo los crawlers de IA interactúan con las directivas establecidas.
*   **Prueba de Acceso:** Intentar acceder a secciones bloqueadas o permitidas simulando ser un crawler de IA.

**Ejemplo de `llms.txt`:**
```
# Permitir a los crawlers de IA públicos acceder al contenido general.
Allow: /

# Bloquear el rastreo de secciones privadas o de desarrollo.
Disallow: /private/
Disallow: /staging/
Disallow: /admin/

# Configurar un crawl-delay para crawlers de IA específicos si es necesario.
# Crawl-delay: 1
```

**Fuentes:** Google AI Optimization Guide (Mayo 2026), agentic-seo-skill, claude-seo-ai, Perplexity/Claude documentation on crawler access.