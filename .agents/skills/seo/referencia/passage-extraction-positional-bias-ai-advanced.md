## Táctica: Passage-Level Extraction & Positional Bias for AI Citations (Advanced)

**Descripción:**
*   **Passage-Level Extraction:** Los motores de IA y LLMs modernos (ej. Perplexity, ChatGPT) tienden a extraer y citar fragmentos específicos (pasajes) de contenido, en lugar de páginas enteras, para responder a consultas.
*   **Positional Bias:** Existe una tendencia demostrada (especialmente en resultados de IA) a favorecer y citar contenido que aparece prominentemente en la parte superior de la página (primeros ~30% del contenido visible).

**Popularidad:** Alta (Tendencia clave 2025-2026, respaldada por investigación empírica).

**Relevancia:** Optimizar la estructura y el contenido para que la información más crítica y las respuestas directas se presenten de forma clara, concisa y accesible en los pasajes superiores, maximizando las posibilidades de ser extraído y citado por IA.

**Estrategias de Implementación:**

1.  **Estructura Jerárquica Clara:** Utilizar encabezados (`h2`, `h3`), listas (ordenadas/desordenadas), y párrafos bien definidos para crear pasajes lógicos y fácilmente distinguibles.
2.  **Contenido Clave al Inicio:** Colocar las respuestas directas, los "answer blocks", las estadísticas originales y la información más relevante al principio del contenido (primeros ~30%).
3.  **Pasajes Autónomos y Densos:** Diseñar cada pasaje clave para que sea lo más autocontenido y denso en información posible, respondiendo a una pregunta específica.
4.  **Optimización de Longitud de Pasaje:** Mantener los pasajes críticos dentro de un rango óptimo (ej. 120-180 palabras) para facilitar la extracción y citación por IA.
5.  **Marcado Semántico Avanzado:** Usar Schema.org (ej. `Question`, `Answer`, `HowToSection`) o marcado semántico personalizado para ayudar a la IA a identificar la estructura, el propósito y la jerarquía de cada sección/pasaje.

**Verificación:**

*   Analizar las respuestas de IA (ej. Perplexity, Claude AI) para consultas relevantes al sitio.
*   Evaluar si los pasajes clave del contenido son citados y si se originan predominantemente en la parte superior de la página.
*   Revisar la estructura del contenido para asegurar pasajes claros, bien definidos y concisos.

**Ejemplo:**
En un artículo sobre "Optimización de Imágenes para SEO", los beneficios clave (ej. "Mejora de Core Web Vitals", "Mayor visibilidad en IA generativa de imágenes") deben presentarse al inicio, en pasajes de ~150 palabras, para maximizar su extracción y cita por IA.

**Fuentes:** Perplexity citation study (arXiv, Julio 2025), iPullRank 2026 study, Google AI Optimization Guide (Mayo 2026), claude-seo, seo-geo-optimizer.