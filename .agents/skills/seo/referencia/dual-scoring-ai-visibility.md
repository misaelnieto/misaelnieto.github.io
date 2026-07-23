## Táctica: Dual Scoring (SEO vs. AI Visibility)

**Descripción:** Un enfoque de auditoría y optimización que evalúa el contenido en dos dimensiones paralelas:
1.  **SEO Clásico:** Optimización para motores de búsqueda tradicionales (Google).
2.  **AI Visibility (GEO/AEO):** Optimización para ser citado, comprendido y potencialmente utilizado por modelos de IA y motores de búsqueda de IA.

**Popularidad:** Alta (tendencia emergente 2025-2026).

**Relevancia:** Permite identificar contenido que puede estar bien posicionado en Google pero ser "invisible" o no citable por plataformas de IA, o viceversa.

**Áreas Clave de Enfoque:**

*   **SEO Clásico:** Crawlability, indexabilidad, Core Web Vitals, rendering (CSR/SSR/SSG), optimización on-page tradicional.
*   **AI Visibility:**
    *   **Citabilidad:** ¿Puede Perplexity, ChatGPT, Claude citar este contenido?
    *   **Formato para IA:** ¿Está estructurado para respuestas directas y bloques autocontenidos?
    *   **Densidad de datos:** ¿Contiene información original y hechos verificables?
    *   **Vinculación de Entidades:** ¿Se enlazan entidades clave a fuentes autoritativas?
    *   **Acceso de Crawlers de IA:** ¿Se respetan `llms.txt` y directivas de `robots.txt` para IA?

**Métricas / Verificación:**

*   Análisis de resultados de búsqueda en Google vs. resultados/respuestas de IA para la misma consulta.
*   Uso de prompts específicos para evaluar la citabilidad del contenido en IAs.
*   Verificación de la presencia y formato de "answer blocks".

**Ejemplo de Prompt:**
"Audit my blog at localhost:3000 for both traditional SEO and AI answer engines. Tell me: 1. Will Perplexity cite my content? 2. Can Claude extract my answers for follow-up questions? 3. Are my entity definitions clear enough for LLM retrieval?"

**Fuentes:** Hainrixz/claude-seo-ai, Google AI Optimization Guide (Mayo 2026).