---
title: Lecciones que aprendí al escribir «El Despacho» y «El Diagnóstico»
summary: "Diecisiete mitos sobre Kafka que dos revisiones adversarias cazaron en mi parábola del Despacho aduanal — y cómo es cada uno en realidad."
description: "Los errores conceptuales sobre Kafka que casi publico: consumer groups, offsets, retención, fan-out, acks y orden — explicados con la parábola del Despacho aduanal."
date: 2026-09-09
categories:
  - "DevOps"
tags:
- kafka
- mensajeria
- arquitectura
- sistemas-distribuidos
locale: "es_MX"
keywords:
  - "kafka, mitos, consumer groups, offsets, retencion, fan-out, colas, arquitectura"
draft: true
---

## El examen adversario

Escribí [una parábola para explicar Kafka](/blog/que-es-kafka-y-por-que-se-llama-asi): una agencia aduanal en Mexicali donde cada empleado es un componente de software y un aire acondicionado pirata tumba la operación entera. Me gustó tanto que casi la publico tal cual.

Casi. Antes de soltarla, la puse frente a dos ingenieros hostiles con instrucciones de destrozarla. Lo hicieron con gusto. Salieron dieciséis objeciones, y cada una es una lección sobre Kafka que *casi* enseñé mal. Este post es mi wall of shame: el mito que escribí, cómo me lo marcaron, y cómo es en realidad. Si estás aprendiendo Kafka, ahorrate mis errores.

## Sobre mi parábola: el modelo mental que vendí de más

### 1. «Un evento escrito una vez, leído N veces» — y el lector se lleva que todos reciben todo

Escribí el fan-out como si Kafka fuera un altavoz: escribes al registro y todos los interesados escuchan. Cierto… *entre grupos de consumo*. Dentro de un mismo grupo, los consumidores se reparten las particiones y cada mensaje lo procesa **uno solo**. El junior que memoriza «todos leen todo» descubre con dolor que su segundo consumidor le robó la mitad de los eventos.

**Moraleja**: fan-out entre grupos; competing consumers dentro del grupo.

### 2. «Cada quien lleva su propio marcador» — el offset no es del consumidor

Mi frase sonaba a propiedad individual. En realidad el offset vive por **grupo y por partición**, y lo guarda el propio Kafka — el consumidor lo comitea, y un consumidor que se desploma retoma desde su último commit, no desde donde iba. Dos instancias del mismo servicio comparten grupo; por eso el coordinador les reparte las particiones.

### 3. Rey Díaz «se abruma» — Redis no se ahoga: corta

En la escena de la cacofonía, escribí que Rey «ya no atiende a nadie». Suena humano, y por eso mismo es mentira técnica: Redis Pub/Sub no se degrada con elegancia — cuando el consumidor es lento, el output buffer revienta y **cierra la conexión**. No se ahoga; cuelga. Tuve que torcer la frase: «hace lo único sensato: cortar llamadas a media frase».

### 4. Todo fallo era «síncrono» — había dos males distintos

Mi diagnóstico original unificaba todo: «cada servicio dependía de que el siguiente estuviera de pie y le contestara en vivo». Pero Celia y Rey fallaban diferente: a Celia el silencio **la bloquea** (llamada síncrona que no regresa); Rey **pierde en silencio** (entrega sin acuse, nadie escuchando). Dos modos de fallo, dos remedios distintos — request/reply asíncrono para una, persistencia para el otro. Mismo origen, sí: nada quedaba asentado.

### 5. Mi diagrama desparecía los datos de Diana

El primer mermaid decía «Inventario vacío» cuando Diana se iba. Un lector distraído (o no tan distraído) citaría que los datos se fueron con ella. Diana pierde **disponibilidad**, no los datos: la mercancía seguía en el almacén. El nodo ahora dice «Inventario inaccesible». Los diagramas también enseñan — mal.

### 6. Mi broker repartía de más

En el segundo diagrama puse «Broker / Cola» entregando *el mismo* mensaje a dos servicios. Dos párrafos después enseñaba que una cola hace exactamente lo contrario. El diagrama estaba contradiciendo al texto — y ganaba, porque los ojos van antes que la lectura.

### 7. «Nunca se busca una página de en medio» — falsa en lectura

Escribí que el log es rápido porque «solo se pegan hojas al final, nunca se busca una de en medio». Eso es verdad **para escribir**. Los consumidores leen de en medio todo el tiempo — para eso son los offsets. Lo que nunca pasa es *reescribir* en medio, y las lecturas avanzan siempre hacia adelante.

## Sobre «lo que tienes antes de Kafka»

### 8. Di «Redis no sabe retener» — y Redis Streams me desmintió en 2018

«Es lo que tienes antes de Kafka», escribí, refiriéndome a Redis. Válido para Pub/Sub — mentira para Redis. Desde Redis 5.0 (octubre de 2018) existe [Redis Streams](https://redis.io/docs/latest/develop/data-types/streams/): persistente, con consumer groups y replay. Medio Kafka escondido en Redis. El matiz importa: *Pub/Sub* es lo que tienes antes de Kafka.

### 9. «En una cola clásica no hay forma de fan-out» — error fáctico, tal cual

Escribí que varias equipos no podían recibir los mismos eventos de una cola clásica. Falso hace décadas: los *fanout exchanges* de RabbitMQ, los *topics* de JMS y SNS→SQS lo hacen todos los días. Lo que exigían era trabajo manual: routing propio, una cola por suscriptor, dar de alta a cada quien *antes* del primer mensaje. Lo que Kafka aporta no es la invención del fan-out: es fan-out **persistente, con replay y sin pre-registrar a nadie**. La distinción que sobrevive a cualquier comité no es «¿puede difundir?»: es **consume-y-borra vs retener**.

### 10. «Deposita el mensaje y sigue con su vida» — acks=0 con buenas intenciones

Mi frase favorita era también mi frase más peligrosa: el emisor que «sigue con su vida» sin confirmación es exactamente Rey Díaz — entrega sin acuse, y si el broker tronó, el mensaje se evaporó en silencio. El emisor honesto deposita y **espera el acuse** del broker; solo entonces sigue. Irónico: mi propia parábola tenía la lección y yo no la había aplicado.

## Sobre el log en sí

### 11. «Nada de lo escrito se borra» — excepto que sí

La frase con la que cerraba el chiste del nombre («el sistema donde nada de lo escrito se borra») necesitaba un pie: *salvo por retención*. Kafka borra por **tiempo o por tamaño**, desde minutos hasta «nunca jamás» — y encima existe la *compactación*, que conserva solo lo último por clave. El log no es eterno: es *configurable*.

### 12. «Releer todo el registro» — todo el registro *que sobrevivió*

Si la retención borra, el replay no puede ser infinito: solo puedes releer lo que la retención aún conserve. Replay y retención son la misma moneda; escribí la una sin la otra.

### 13. «Kafka mantiene el orden» — orden de qué, y entre quién

«Cada partición mantiene el orden» es correcto e inútil sin su contracara: **entre particiones no hay orden**, y es la **clave del mensaje** la que decide a qué partición va cada evento. Misma clave, misma partición, orden por clave. El bug #1 del principiante es depender del orden global; el #2 es escalar particiones y romper la afinidad de las claves.

### 14. La copia local «responde» el inventario — con lag

Cerré el post ofreciendo que cada servicio mantenga «su propia copia local del inventario y se consulte a sí mismo». La puerta es correcta (materialized views, CQRS), pero una copia por eventos es **eventualmente consistente**. Responder «¿hay veinte?» con lag puede sobrevender stock. Las respuestas fuertes requieren otro diseño — reservas, transacciones — y eso no cabe en un buzón.

## La más grande: creí que el broker daba inmunidad

### 15. «El problema es que tu sistema no está desacoplado» — a los 54 grados, no

Mi frase-tesis prometía demasiado. Con el mejor log del mundo, la oficina a los 54 grados **igual se para**: Diana no puede trabajar, la mercancía está en el almacén caliente, El Chief acaba en el hospital. El desacoplamiento no evita la caída — **cambia lo que significa caerse**: de apagón con todo perdido a pausa con los hechos asentados, de la que se reanuda sin reconstruir nada.

### 16. Contra el aire: desacoplamiento — cuando el antídoto era redundancia

Y contra el aire — dependencia ambiental, no de comunicación — el antídoto no es un broker: es **redundancia**. Otro aire, no un aire mejor. Desacoplamiento y redundancia resuelven males distintos; yo los había fundido en uno.

## Coda

Dieciséis objeciones contra una parábola de mil quinientas palabras. La moraleja no es «no uses analogías» — la parábola sobrevivió al examen y salió más honesta. Es que **las analogías enseñan rápido y equivocan rápido**: el mismo poder en ambas manos. El antídoto que conocí fue pasar el texto por gente con instrucciones de odiarlo.

Si detectas un mito número diecisiete, mándalo: la pared de la vergüenza tiene espacio.

---

*Mitos pendientes de desarrollo (para los siguientes posts de la serie): consumer groups a fondo, ISR y réplicas, transacciones y exactly-once, compactación, Redis Streams a fondo, y la lección completa de redundancia vs desacoplamiento.*

## Tabla resumen: el mito → la verdad

| El mito que casi enseño | La verdad |
|---|---|
| Todos los consumidores reciben todo | Entre grupos sí; dentro del grupo se reparten particiones |
| El offset es del consumidor | Es por grupo y por partición, y se guarda en Kafka — retomas desde el último commit |
| El canal saturado se degrada con elegancia | Redis Pub/Sub corta la conexión del lento |
| Todo fallo es bloqueo síncrono | Bloqueo (Celia) y pérdida silenciosa (Rey): dos males |
| «Inventario vacío» al caer un nodo | Pierde disponibilidad, no los datos |
| El broker reparte lo mismo por defecto | Depende del tipo de intermediario y su configuración |
| Append-only = nunca se lee de en medio | Nunca se *reescribe* de en medio; se lee desde cualquier offset |
| Redis no sabe retener | Pub/Sub no; Redis Streams sí |
| La cola clásica no puede fan-out | Podía — a mano, cola por suscriptor, pre-registrado |
| Depositas y sigues con tu vida | Depositas, esperas el acuse, *entonces* sigues |
| Nada se borra nunca | Retención por tiempo o tamaño, más compactación |
| Replay infinito | Solo lo que la retención conserve |
| Kafka mantiene el orden (global) | Solo por partición; la clave decide la partición |
| La copia local responde con verdad fuerte | Es eventualmente consistente |
| El broker da inmunidad | Convierte la caída en pausa con hechos asentados |
| Contra la infraestructura fallida: desacoplamiento | Contra el ambiente: redundancia — otro aire, no un aire mejor |
