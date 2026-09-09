# Kafka — claves de personajes y narrativa (temporal)

Serie de 3 posts sobre Apache Kafka (es_MX). Este archivo guarda las claves de la sección «El problema» del Post A.

## Post A — datos fijos
- Archivo: `content/posts/2026-09-06-que-es-kafka-y-por-que-se-llama-asi.md`
- Título: «¿Por qué se llama Kafka? Y qué hace, en realidad»
- Secciones: «¿Por qué se llama Kafka?» (lista) → «El problema» (en edición) → «La idea» → «¿Entonces qué es Kafka?» → «Coda»

## Registro narrativo (cómo escribir)
- **Kafkiano** = absurdo + burocrático + narrado con calma. NO es "oscuro/angustiante".
- **Flat affect / extrañamiento**: lo grotesco con voz llana. Subestimar, no dramatizar.
- **Subtexto / intertexto**: recrear *La metamorfosis* sin nombrarla. La referencia es un fantasma.
- **Eco estructural**: la apertura dice "hombre que amanece cucaracha" → aquí el lector lo vive.
- Voz del autor: mexicano, tuteo, code-switching, sarcasmo a costa propia (skill `redaccion`).

## Escenario
Nombre: **«Despacho Especial Aduanal Deadlock y Asociados S.A. de C.V.»** — acrónimo **DEUDA**.
- "Deadlock y Asociados" = fachada legal bufona (patrón "X y Asociados"), la palabra escondida es un *deep cut* técnico: el deadlock = comunicación síncrona acoplada congelada (Karime ↔ Regina).
- Acrónimo **DEUDA** = la condición kafkiana (culpa impaga, Josef K., Gregor). Bomba narrativa *reversible*: puede detonarse en el Post B (el registro/commit log = deuda que crece) o en el cierre del Post C (la agencia ya "no debe" nada), o no detonarse (subtexto puro).

Agencia aduanal nueva en Mexicali, B.C. Abierta en enero (clima fresco). La primavera se disfruta; la ola de calor llega **de un día para otro** (38 → 39 → 37 → 42, y no baja hasta octubre). Todo mundo prende el aire día y noche o muere.

**El calor = la metamorfosis** (punto de giro). La oficina = el sistema. Cada empleado = un servicio.

## Reparto (personajes = servicios)
| Personaje | Origen | Servicio | Personalidad | Defecto / modo de fallo |
|---|---|---|---|---|
| **Regina Osuna** | Mexicali | Inventario | 30+ años en la agencia, inventario impecable; trae abanico personal hasta en invierno; verano pasado irritable. NO se menciona menopausia (inferida). | **Degradación / retiro**: se va a "trabajar desde casa" (3pm, antes de las 5pm) pero no puede: la mercancía real está en la oficina. Disponibilidad declarada ≠ real. |
| **La Karime** (Karime Crostwhite) | Sinaloa | Pedidos | Veinteañera, trabaja bien, carácter fuerte; uñas gelish + TikTok = se atrasa. NO "buchona" (descartado: eco narco). | **Bloqueo síncrono**: impaciente (timeout corto) + lenta (procesamiento), espera respuesta que no llega y revienta |
| **Marcos Javier** (siempre los dos nombres) | Mexicali | Notificaciones | Gay (evidente pero irrelevante, modelo Whis), afable, empático, bien vestido, mediador, centro de la oficina | **Canal opaco**: chisme sun mensaje→distorsiona (fan-out sin registro). No villano activo; colapsa bajo consultas. «el pez por la boca muere» (el chisme = canal de estado no confiable que colapsa) |
| **José Rojas "El Chief"** | CDMX (vive en Mexicali) | Sistemas | Habla/viste como El Vítor pero niega el cantadito; medio agresivo, malhablado; le dan carrilla; SODA caliente | **Complejo de Casandra**: dice la verdad (correo/mensaje de WhatsApp), nadie le cree hasta que es tarde. Sube a la azotea a debuggear |
| **El Aire Acondicionado** | — | infraestructura | Nuevo, **defectuoso** (nadie lo sabe) | **Fallo silencioso**: muere sin avisar, sin log, sin error. Muere a las 3pm, 54°C |

## El AC (pieza clave)
- Doble función: **termómetro** (sufre el calor) + **causante misterioso** del fallo en cascada.
- Falla a las 3pm, a 54 °C pronosticados, en pleno agosto, fiel a la ley de Murphy (54, no 57: respetar verosimilitud del flat affect, récord real ~52).
- Reemplaza al canadiense (descartado por "barato"/explícito; el AC es absurdo implícito).
- En software: **punto único de fallo** con **bug latente** que solo estalla bajo carga.
- El AC es el **detonante**; el **acoplamiento** es el desastre. El desenlace debe nombrar el diseño (la espera), no el aparato.

## Tema unificador
**La comunicación** (el post trata de comunicación entre servicios). Cada personaje = un modo de fallo de la comunicación: Regina (retiro/degradación), Karime (bloqueo síncrono), Marcos Javier (canal opaco sin registro), José (señal ignorada), AC (silencio). La lección central: **acoplamiento síncrono → cascada**. El chisme NO es la lección; es opacidad. En la retoma jamás decir "Kafka es como un chisme confiable" — el chisme falla por no dejar registro (semilla de Post B).

## Beats del relato
1. **Setup** (enero–primavera): agencia nueva, fresco, el acoplamiento funciona con carga baja. Se presenta el reparto. José instala el AC, le huele raro, manda mensaje al grupo que nadie lee (semilla de Casandra). Carrilla por El Vítor.
2. **Punto de giro**: la ola de calor «de un día para otro».
3. **Incidente incitador**: 54 °C, las 3pm; el AC muere en silencio (incomprensible). El Chief sube a la azotea a debuggear, baja derrotado, sudando, la soda caliente.
4. **Cascada**: Regina se retira a "trabajar desde casa" (3pm, no regresa hoy, quizá días) → Karime espera frente al escritorio vacío y revienta → Marcos Javier amplifica con chisme sin registro (canal opaco) → colapsa bajo consultas → la oficina queda sin nadie que sepa qué pasa.
5. **Incomprensión**: El Chief mira (Casandra + Gregor), con el gel derretido: «el aire solo hizo la pregunta; los tumbó la espera».
6. **Remate** (ya fuera del relato, en el post): nombrar la lección — comunicación síncrona y acoplada — y el acrónimo **DEUDA** como kicker («El SAT la conoce como DEUDA. Yo no podría estar más de acuerdo»).

## POV
Narración en voz de Noé, dirigida al lector con «tú», José como personaje focal. El lector comparte la experiencia de José (Casandra + Gregor) sin "ponerse" el gel.

## Cross-links
- A: `/blog/que-es-kafka-y-por-que-se-llama-asi/`
- B: `/blog/kafka-no-es-una-cola-es-un-registro/`
- C: `/blog/kafka-por-dentro-arquitectura/`
