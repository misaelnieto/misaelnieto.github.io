## Táctica: AI-Aware Schema Markup & Deprecation Handling

**Descripción:** Implementar marcado Schema.org (JSON-LD) de forma estratégica para mejorar la comprensión de la IA sobre el contenido y anticipar/gestionar la obsolescencia de ciertos tipos de esquemas.

**Popularidad:** Alta (SEO técnico, tendencia clave 2025-2026 para IA).

**Relevancia:** Ayuda a los motores de búsqueda y a las IAs a interpretar la estructura del contenido (tipos de datos, relaciones, intenciones), facilitando la extracción de información y la generación de respuestas.

**Implementación:**

1.  **Tipos de Esquema Relevantes:**
    *   `Article`, `BlogPosting`: Para contenido de blog.
    *   `FAQPage`: Anteriormente popular, pero con cambios importantes.
    *   `HowTo`, `Recipe`: Para contenido instructivo.
    *   `Organization`, `Person`: Para autoridad y confianza.
    *   Esquemas específicos para E-commerce, Productos, Eventos, etc.

2.  **Generación y Validación:**
    *   Utilizar herramientas para generar JSON-LD automáticamente o manualmente.
    *   Validar el marcado con herramientas como el [Rich Results Test de Google](https://search.google.com/test/rich-results) (aunque este se enfoca en Google, es un buen punto de partida).
    *   Considerar validadores específicos para IA si existen.

3.  **Consideraciones para IA (GEO/AEO):**
    *   **Fragmentos de Respuesta:** Usar esquemas que resalten preguntas y respuestas directas (ej. `FAQPage` o esquemas de `HowTo` bien estructurados).
    *   **Entidades:** Marcar entidades clave dentro del esquema si es posible.

4.  **Manejo de Deprecación (¡Importante!):**
    *   **Evolución de Esquemas:** Estar al tanto de los cambios en Schema.org. Por ejemplo, `FAQPage` fue afectado significativamente alrededor de Mayo 2026, y su uso para generar fragmentos de respuesta directa puede haber cambiado.
    *   **Adaptación:** Priorizar esquemas que sigan siendo compatibles con las directrices de IA y búsqueda (ej. usar `Question` y `Answer` dentro de `Article` o `WebPage` si `FAQPage` ya no es óptimo).

**Verificación:**

*   Validar el JSON-LD generado contra las especificaciones de Schema.org y las directrices de Google/IA.
*   Revisar logs o herramientas de análisis para ver cómo los motores de IA interpretan el marcado.
*   Comprobar si el marcado contribuye a rich snippets o a respuestas directas en las SERPs.

**Ejemplo de Prompt:**
"Generate JSON-LD schema markup for this blog post about 'AI SEO Trends 2026'. Ensure it includes Organization and Person schema for authoritativeness, and structure the content to highlight key Q&A pairs for potential AI extraction, considering recent changes to FAQPage schema."

**Fuentes:** Google Search Console documentation, Schema.org, claude-seo, seo-geo-optimizer.