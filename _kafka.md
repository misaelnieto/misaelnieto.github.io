# Kafka — claves de personajes y narrativa (temporal)

Serie de 3 posts sobre Apache Kafka (es_MX). Este archivo guarda las claves de la parábola del Post A.

## Post A — datos fijos
- Archivo: `content/posts/2026-09-06-que-es-kafka-y-por-que-se-llama-asi.md`
- Título: «¿Por qué se llama Kafka? Y qué hace, en realidad»
- Estructura: «¿Por qué se llama Kafka?» → «El Despacho…» (**solo historia**) → «Comunicación síncrona vs acoplada» (**mapeo + explicaciones técnicas**) → «La idea» → «¿Entonces qué es Kafka?» → «Coda»
- Cierre narrativo exacto: «Y más importante: nadie recordaba, ni siquiera El Chief, que el aire era pirata.» Después va el análisis.
- Regla de capas: la narrativa NO explica la tesis; toda explicación técnica vive en el análisis.

## Registro narrativo (cómo escribir)
- **Kafkiano** = absurdo + burocrático + narrado con calma (flat affect). Subestimar, no dramatizar.
- **Subtexto**: recrear *La metamorfosis* sin nombrarla.
- Voz del autor: mexicano, tuteo, code-switching, sarcasmo a costa propia (skill `redaccion`).
- Nomenclatura: nombres propios sin artículo (nada de «la Celia»).

## Escenario
Nombre: **«Despacho Especial Aduanal Deadlock y Asociados S.A. de C.V.»** — acrónimo **DEUDA** (kicker en el análisis).
- Agencia en Mexicali, B.C.; sucursal nueva abre en enero (clima fresco). Ola de calor «de un día para otro» (36 → 42…; 54 °C el día del fallo).
- El calor = la metamorfosis (punto de giro). La oficina = el sistema; cada empleado = un servicio.
- Descripción de la agencia: solo 3 datos (sucursal nueva, almacén + mostradores + cubículos, meses templados sin prisa). Fuera café/galletas/sala de espera (set dressing, no foreshadow).

## Reparto (nombres = acrónimo técnico; el acrónimo se revela SOLO en el análisis)
| Personaje | Acrónimo | Sistema real | Rol en la historia | Modo de fallo |
|---|---|---|---|---|
| **Diana Báez** | DB | Microsoft Access (legacy) | Inventario, fuente de verdad, impecable desde siempre; abanico en invierno (señal de envejecimiento, menopausia jamás explícita) | Correcta pero NO disponible: sin réplica, sin acceso remoto, sin reemplazo. Se retira y el inventario queda inaccesible. «La base de datos no perdió información; perdió disponibilidad.» |
| **Celia R. Montes** | CRM | CRM / intake multicanal (teléfono, mostrador, WhatsApp) | Atención a clientes; cierra pedidos | Bloqueo síncrono: no cierra nada hasta que Diana responde. **NO es «frontend»; olvidar Django.** |
| **Rey Díaz** | Redis | Redis Pub/Sub (relay efímero) | Mensajero y coordinador, organizado y diligente, chismoso; memoria de corto plazo: el día lo graba palabra por palabra, pero «no le preguntes qué hizo ayer, porque nunca se acuerda». Muy eficiente → nadie se preocupa de su olvido (tercera señal ignorada, junto al abanico y la caja pirata). Conductor de los reportes diarios de El Chief | Canal sin persistencia, sin replay, sin audit log. Memoria volátil = RAM: perfecta en vivo, borrada al reiniciar. No inventa el rumor; el rumor se completa solo. |
| **Luis Omar García «El Chief»** | LOG | Observabilidad + operación (Grafana/Loki/Prometheus/Alertmanager + on-call humano) y config management (Chef/Salt: instala, actualiza, mantiene la infraestructura con las manos); manda reportes diarios que nadie lee, enrutados por Rey | Sistemas; detecta la anomalía del AC, avisa, repara; sube a la azotea | Complejo de Casandra: alerta informal que se diluye por el canal de Rey. Su hospitalización = el monitoreo cae y nadie lo sabe (sin heartbeat, sin guardia alterna, sin escalamiento). NO es Grafana a secas: es «el monitoreo con patas». |
| **El Aire Acondicionado** | — | infraestructura ambiental | Nuevo, pirata (caja de una marca, aparato de otra) | Fallo silencioso a las 3pm, 54 °C, agosto. Detonante externo, NO causa. |

- Tratamiento: «doña Diana»; en prosa «Luis Omar», en diálogos «Chief»; Rey Díaz siempre con nombre y apellido (regla heredada de Marcos Javier).
- Los nombres suenan a persona; los acrónimos (DB, CRM, Redis, LOG) se detonan en la sección de análisis, no en la historia.

## El AC (pieza clave)
- Falla a las 3pm, 54 °C pronosticados, pleno agosto (verosimilitud: récord real ~52; ley de Murphy sin exagerar).
- El Chief detecta la anomalía (caja de una marca, aparato de otra), avisa por el canal de Rey, nadie sabe qué hacer con la información, instala de todos modos («tenemos garantía»).
- El AC es el **detonante**; la comunicación síncrona/acoplada es el desastre. La lección nombra el diseño (la espera), no el aparato.

## Tema unificador
**La comunicación entre servicios.** Modos de fallo: Diana (disponibilidad), Celia (bloqueo síncrono), Rey (canal efímero), Luis Omar (señal ignorada + operador sin redundancia), AC (silencio). Lección central: **acoplamiento síncrono → cascada; el AC solo hizo visible la falta de tolerancia a fallos**. Jamás decir «Kafka es como un chisme confiable» — el chisme falla por no dejar registro (semilla del Post B).

## Beats del relato (versión comprimida, ~1,500–1,700 palabras)
1. **Setup mínimo**: agencia nueva, enero, reparto en pinceladas funcionales. Diana y el abanico como señal ignorada (requisito detrás del escritorio, 2–3 líneas).
2. **La costumbre**: grito-y-espera Celia → Diana (diálogo íntegro «¡Báez!…»), luego Celia → Rey. «Lo que no quedó escrito, sencillamente no existe» — una sola vez en todo el post.
3. **Rey en un solo párrafo** (mensajero, chismoso, memoria de corto plazo: «ayer, para Rey Díaz, no existe»; eficiente → nadie anota nada).
4. **AC**: carrilla + lotería en estilo indirecto (conservar «se nos cae el changarro») + caja pirata condensada («Un aire pirata, dijo.») + maldición de Casandra + instala de todos modos («tenemos garantía»). Un solo latiguillo («¡Abuelita de Batman!», embebido en la narración). **Regla de modalidad: la única línea de diálogo directo del post es el grito «¡Báez!…» del setup** — se oye la petición cuando funciona; cuando falla, solo llega el eco en indirecto y el silencio. Todo lo demás va en estilo indirecto.
5. **Meses templados** → ola de calor «de un día para otro» → el AC muere (*Thump.*, sin log, sin error).
6. **Cascada**: Diana se va (payoff del abanico: «un abanico no parece una alarma») → Celia espera frente al escritorio vacío y revienta → Rey redondea rumores → la fila frente a su escritorio («Sin Rey Díaz, la oficina se queda sin noticias. Con Rey Díaz, sin hechos»).
7. **Sin explicación de tesis en la narrativa**: conservar «El aire solo hizo la pregunta» + imagen de la fila; fuera el párrafo-explicación (eso vive en el análisis).
8. **Desenlace en UN párrafo**: hospital sin avisar, Rey abre por inercia («la costumbre no pregunta por las personas; solo sigue»), Celia improvisa, garantía, normalidad → «nadie recordaba que el aire era pirata.»

## Análisis («Comunicación síncrona vs acoplada»)
- Aquí se revela el truco de los nombres: **Diana Báez = DB** (Access legacy, fuente de verdad), **Celia R. Montes = CRM** (intake multicanal), **Rey Díaz = Redis** (Pub/Sub efímero, sin persistencia), **Luis Omar García = LOG** (observabilidad + operación).
- Mapeo compacto y escaneable: una entrada por servicio, negritas en el nombre.
- Luis Omar: su ausencia = segunda falla sin registro (compound failure).
- Kicker **DEUDA** aquí.
- Mermaid con nodos renombrados (C/D/R/L).
- Pendiente: decidir si el título cambia a «Síncrono, acoplado y sin tolerancia a fallos».

## POV
Voz de Noé, «tú» al lector; Luis Omar (LOG) como personaje focal (Casandra + Gregor).

## Cross-links
- A: `/blog/que-es-kafka-y-por-que-se-llama-asi/`
- B: `/blog/kafka-no-es-una-cola-es-un-registro/`
- C: `/blog/kafka-por-dentro-arquitectura/`
