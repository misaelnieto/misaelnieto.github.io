## Táctica: Entity Linking & Attribution Density

**Descripción:**
*   **Entity Linking:** Conectar referencias a entidades (personas, lugares, conceptos, organizaciones) en el contenido con fuentes autoritativas y definiciones claras (ej. Wikipedia, bases de datos académicas).
*   **Attribution Density:** Medir y optimizar la frecuencia y claridad con la que se citan fuentes y se atribuye la autoría o el origen de la información.

**Popularidad:** Alta (Tendencia clave 2025-2026 para IA y SEO).

**Relevancia:**
*   **Entity Linking:** Ayuda a las IAs a comprender el contexto, la autoridad del autor y la veracidad del contenido, facilitando la indexación semántica y la aparición en Knowledge Graphs.
*   **Attribution Density:** Incrementa la confiabilidad (Trustworthiness) del contenido, crucial para E-E-A-T, y es un factor clave para que las IAs citen la fuente.

**Implementación:**

1.  **Para Entity Linking:**
    *   Identificar entidades clave en el texto.
    *   Crear enlaces a páginas de Wikipedia, sitios oficiales, o fuentes académicas relevantes que definan esas entidades.
    *   Asegurar que el contexto del enlace sea natural y útil.

2.  **Para Attribution Density:**
    *   **Citar Fuentes:** Referenciar explícitamente estudios, expertos, o datos de donde proviene la información.
    *   **Atribución Clara:** Indicar claramente quién es el autor, de dónde provienen las estadísticas, o quién realizó una investigación específica.
    *   **Enlaces a Fuentes:** Incluir enlaces directos a las fuentes citadas siempre que sea posible.
    *   **Marcado de Autoría:** Utilizar `Person` schema y metadatos estructurados (ej. `author` en `Article` schema) para identificar al autor.

**Verificación:**

*   Revisar la presencia y calidad de los enlaces a entidades.
*   Evaluar la frecuencia y claridad de las atribuciones a fuentes y autores.
*   Utilizar prompts a IAs para ver si pueden identificar y citar correctamente las fuentes y entidades del contenido.

**Ejemplo:**
En un artículo sobre "Tendencias SEO de IA", citar estudios de "Princeton University" o "Google AI Optimization Guide" con enlaces directos, y enlazar a las páginas de Wikipedia de "Perplexity AI" o "Claude (IA)".

**Fuentes:** seo-geo-optimizer (menciona "Entity extraction + optimization", "Attribution density"), claude-seo-ai, claude-seo.