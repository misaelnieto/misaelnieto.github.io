---
title: Cómo Usar la Librería Tenacity en Python
summary: Una pequeña guía para comenzar a usar la librería Tenacity de Python
description: Facilmente reintenta una funcion en Python en caso de que algo falle
date: 2024-08-16T19:15:15.747Z
categories:
    - Python
    - Tutoriales
tags:
    - python
    - tenacity
    - tutorial
    - programación
locale: es
hero_svg: ../assets/img/heroes/happy-intersection.svg
keywords: python, tenacity, tutorial, programación
preview: https://upload.wikimedia.org/wikipedia/commons/9/95/Dorylus_nigricans_casent0172643_head_1.jpg
image: https://upload.wikimedia.org/wikipedia/commons/9/95/Dorylus_nigricans_casent0172643_head_1.jpg
---

¡Hola a todos! Hoy les voy a platicar de una librería de Python que me ha salvado la vida en más de una ocasión: **Tenacity**. Si alguna vez has tenido que lidiar con errores intermitentes en tus scripts o aplicaciones, esta herramienta es para ti. Vamos a ver cómo funciona y cómo puedes integrarla en tus proyectos. 🚀


## Reintentando cosas en Python

Cuando trabajas con APIs, servicios externos o pruebas de dispositivos que pueden fallar de vez en cuando haciendo que programar sistemas tolerantes a fallos se vuelva un poco complicado. Como ejemplo, esto es clásico: estás intentando hacer una petición HTTP a una API externa para obtener datos.

```python
import requests

def obtener_datos():
    response = requests.get('https://api.ejemplo.com/datos')
    return response.json()
```

**¿Cómo podría fallar?**

Bueno, como sabemos la conexión a Internet, por naturaleza puede ser inestable y, a veces falla, pero no siempre.

La función `obtener_datos()` puede fallar si la conexión a Internet se corta momentáneamente o si hay problemas temporales con el servidor de la API o si los astros se alinearon ¿Seria genial si, en caso de fallo, se intentara de nuevo la petición, no?

```python
import requests
import time

def obtener_datos():
    url = 'https://api.ejemplo.com/datos'
    max_retries = 3
    retry_delay = 2  # segundos

    for intento in range(max_retries):
        try:
            response = requests.get(url)
            response.raise_for_status()  # Esto lanzará una excepción para códigos de estado 4xx/5xx
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f"Intento {intento + 1} fallido: {e}")
            if intento < max_retries - 1:
                print(f"Reintentando en {retry_delay} segundos...")
                time.sleep(retry_delay)
            else:
                print("No se pudo obtener los datos después de varios intentos.")
                raise
```

![Ewwwww! Osea, SI, pero se ve feísimo!](../assets/img/posts/clint_eastwood_si_pero_no.png){: .image }

¿Cuál es el problema? !Se ve feo! Y además es más código para un concepto tan simple como reintentar una función. Debería haber una manera más fácil y **Pythonica**.

Bueno, lo mismo pasa con otros escenarios:

1. Peticiones a la red con cualquier librería
2. Acceso a una Base de Datos (local o remota)
3. Lectura/Escritura de Archivos en un Sistema de Archivos Compartido
4. Interacción con un Servicio en la Nube
5. Ejecución de Tareas en un Sistema Distribuido (Spark, por ejemplo)
6. Pruebas de hardware que tiene firmware inestable o que esta funcionando en condiciones rudas como alta temperatura, vibración, maquinaria pesada, suciedad, etc.


Estos son solo algunos ejemplos de situaciones donde los errores intermitentes pueden ocurrir. La librería [Tenacity](https://tenacity.readthedocs.io/en/latest/) puede ser muy útil en estos casos para reintentar la ejecución de la función hasta que tenga éxito, mejorando así la robustez de tu aplicación.


## ¿Qué es Tenacity?

[Tenacity](https://tenacity.readthedocs.io/en/latest/) es una librería para *reintentar cosas* en Python. Básicamente, te permite intentar ejecutar una función varias veces hasta que tenga éxito o se cumpla una condición de fallo. Esto es bien útil cuando trabajas con APIs, servicios externos o pruebas de dispositivos que pueden fallar de vez en cuando.

Las ventajas de usar Tenacity, en lugar de programar los reintentos nosotros mismos son:

- **Código Más Limpio**: El uso de Tenacity hace que el código sea más limpio y fácil de leer.
- **Flexibilidad**: Tenacity ofrece muchas opciones para personalizar la lógica de reintentos, como estrategias de espera exponencial, reintentos basados en condiciones específicas, etc.
- **Manejo Automático de Excepciones**: Tenacity maneja automáticamente las excepciones, lo que simplifica el manejo de errores en tu código.
- **Menos trabajo para ti**: Puedes enforcarte en la funcionalidad de la aplicación y delegar el manejo de errores y reintentos a Tenacity.

**¿Ya te convencí?** 😃

## Instalación

La instalación es super sencilla:

```sh
pip install tenacity
```

## Uso Básico

Retomemos el ejemplo de la funcion `obtener_datos()`. Pero ahora con Tenacity. 

```python
import requests
from tenacity import retry, stop_after_attempt, wait_fixed

@retry(stop=stop_after_attempt(3), wait=wait_fixed(2), reraise=True)
def obtener_datos():
    url = 'https://api.ejemplo.com/datos'
    response = requests.get(url)
    response.raise_for_status()  # Esto lanzará una excepción para códigos de estado 4xx/5xx
    return response.json()
```

Ahora la explicación:

> Decorador `@retry`

- `@retry(stop=stop_after_attempt(3), wait=wait_fixed(2), reraise=True)`: Este decorador configura la función para que:
  - `stop_after_attempt(3)`: Intente ejecutar la función hasta 3 veces.
  - `wait_fixed(2)`: Espere 2 segundos entre cada intento.
  - `reraise=True`: Vuelva a lanzar la excepción original después de que se hayan agotado todos los intentos. Esto será util por que quiensea que use nuestra función, no sabrá que se uso Tenacity y podrá saber que realmente falló, a pesar de los reintentos.

> Función `obtener_datos`

- La función `obtener_datos` sigue siendo básicamente la misma, haciendo una petición HTTP a la URL especificada y lanzando una excepción si la respuesta HTTP tiene un código de estado 4xx o 5xx con `response.raise_for_status()`. Esto es la clave, si `raise_for_status()` lanza una excepción, el decorador de Tenacity reintentará la función una vez mas hasta llegar al límite de intentos.


## Estrategias de Reintento

Tenacity ofrece varias estrategias para manejar los reintentos. Veamos algunas de las más útiles.

### Reintentos con Retardo Exponencial
Esta estrategia es útil cuando quieres aumentar el tiempo de espera entre cada intento.

```python
from tenacity import wait_exponential

@retry(wait=wait_exponential(multiplier=1, min=4, max=10))
def funcion_con_reintento_exponencial():
    # Tu código aquí
    pass

```

### Reintentos para excepciones específicas

Puedes especificar qué excepciones deberían desencadenar un reintento.

```python
from tenacity import retry_if_exception_type

@retry(retry=retry_if_exception_type(ValueError))
def funcion_que_captura_excepcion():
    # Tu código aquí
    pass
```

### Reintentos condicinales

Puedes reintentar una función hasta que se obtenga un resultado específico.

```python
from tenacity import retry_if_result

@retry(retry=retry_if_result(lambda x: x is None))
def funcion_con_condicion():
    # Tu código aquí
    pass
```

## Ejemplo Completo

Aquí tienes un ejemplo de `obtener_datos()` que combina varias de las estrategias mencionadas:

```python
from tenacity import retry, stop_after_attempt, wait_exponential, retry_if_exception_type
import requests

@retry(stop=stop_after_attempt(5), wait=wait_exponential(multiplier=1, min=2, max=10), retry=retry_if_exception_type(requests.exceptions.RequestException))
def obtener_datos():
    response = requests.get('https://api.ejemplo.com/datos')
    if response.status_code != 200:
        raise requests.exceptions.RequestException("Error en la petición")
    return response.json()

try:
    datos = obtener_datos()
    print("Datos obtenidos:", datos)
except requests.exceptions.RequestException as e:
    print("No se pudo obtener los datos después de varios intentos:", e)
```

En este ejemplo, estamos intentando hacer una petición a una API hasta 5 veces con un retardo exponencial entre cada intento. Si la petición falla debido a un `RequestException`, se volverá a intentar.

## Conclusión

Y ahí lo tienen, amigos. Tenacity es una herramienta poderosa y flexible que puede hacer que tus scripts sean mucho más robustos. Ya no tienes que preocuparte por esos errores intermitentes que te vuelven loco. ¡Dale una oportunidad y cuéntame cómo te va!

Si tienen alguna duda o quieren compartir sus experiencias, déjenme un comentario. ¡Nos vemos en el próximo post!

¡Saludos! 👋
