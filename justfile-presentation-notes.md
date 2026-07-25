# Just: Task Runner para Polyglots
## Notas de presentación detalladas para MexicaliOpenSource

**Duración total:** 15 minutos  
**Diapositivas:** 13  
**Formato:** Casual, conversacional, sin bullshit

---

## Diapositiva 1: Portada (0:30)

**Título:** Just: Task Runner para Polyglots  
**Subtítulo:** Por qué Make sigue siendo relevante, pero Just es mejor  
**Créditos:** Tu nombre | MexicaliOpenSource | [Fecha]

**Notas:** Entra con una frase de gancho. Ej: "¿Cuántos de ustedes tienen un Makefile que no usan porque Make es un lenguaje de los 70s? Bueno... Just es la respuesta moderna."

---

## Diapositiva 2: El Problema (1:30)

**Título:** ¿Por qué hablamos de herramientas de tareas?

**Contenido:**
- Tienes un proyecto con múltiples comandos: `npm run build`, `pytest`, `docker compose up`, `cargo test`
- Nadie se acuerda cuál es cuál
- La documentación no se mantiene actualizada
- Cada framework hace lo suyo: npm scripts, Gradle, Cargo, Makefile...

**Notas:** Preguntar a la audiencia: "¿Quién tiene un README.md gigante solo con comandos?" Esperar risas. Ese es el problema.

---

## Diapositiva 3: Categoría de Just (1:00)

**Título:** ¿Qué es Just?

**Definición:**  
Un **task runner** (ejecutor de tareas) moderno que:
- Define recetas en un archivo llamado `justfile`
- Ejecuta comandos con sintaxis simple
- No intenta ser un lenguaje de build completo (ej: no compila código)
- Agnostico del lenguaje: Python, Node, Java, Rust, Go, Bash...

**Comparación rápida:**
| Herramienta | Propósito | Lenguaje |
|---|---|---|
| **Make** | Build system original | Makefile syntax |
| **npm scripts** | Task runner para Node | JSON en package.json |
| **Gradle** | Build tool para JVM | Groovy/Kotlin DSL |
| **Cargo** | Build para Rust | Cargo.toml |
| **Just** | Task runner universal | Justfile |

**Notas:** Énfasis: "Just no reemplaza Make, npm scripts, o Gradle. Es un *companion* universal que funciona encima de ellos."

---

## Diapositiva 4: Just vs Make vs npm scripts (2:00)

**Título:** ¿Por qué no seguir con Make?

**Make hace bien:**
- Dependencias entre recetas (si cambió `src/`, recompila)
- Es el estándar de facto desde 1976
- Viene instalado en casi todos lados

**Make hace MAL:**
- Sintaxis arcana (tabs obligatorios, escaping roto)
- Las reglas implícitas son un infierno (`.c.o`)
- Error handling es débil
- No es portable entre equipos (Windows es un caos)

**Just mejora Make:**
- Sintaxis clara y moderna
- Funciona igual en Linux, macOS, Windows
- Mejor manejo de errores
- Más fácil de entender para juniors

**npm scripts hace bien:**
- Integrado en package.json
- Bueno para proyectos puramente Node

**npm scripts hace MAL:**
- Solo para Node (¿qué pasa si tienes un Dockerfile?)
- El JSON es verboso y feo para scripts largos
- Difícil compartir tareas entre monorepos

**Notas:** "Just es básicamente: 'Hicimos Make de nuevo, pero sin la mierda de 1976.'"

---

## Diapositiva 5: Problemas que Just SÍ resuelve (1:30)

**Título:** Just resuelve estos problemas

1. **Documentación viva**  
   Ejecuta `just` → lista todas las tareas disponibles  
   Ejecuta `just --help TAREA` → muestra la receta

2. **Portabilidad multilenguaje**  
   Un solo `justfile` para tu stack completo

3. **Sintaxis humana**  
   No tabs ocultos, no reglas implícitas, plain English

4. **Error handling robusto**  
   Si un comando falla, la receta se detiene (no intenta ser smart)

5. **Composición**  
   Puedes llamar recetas desde otras recetas (con parámetros)

**Notas:** Mostrar que `just` sin argumentos lista todo. Eso es gold para onboarding.

---

## Diapositiva 6: Problemas que Just NO resuelve (1:00)

**Título:** ¿Qué NO hace Just?

Just **NO es:**
- **Gestor de dependencias** (no instala packages)
- **Lenguaje de build** (no compila código fuente)
- **Sistema de CI/CD** (pero juega bien con GitHub Actions, etc.)
- **Reemplazo de Docker** (pero orquesta containers)
- **Cross-platform mágico** (si escribes comandos Windows-only, falla en Linux)

**Notas:** "Just es agnóstico. Si tu proyecto requiere Go, Rust o Python como build system, úsalo. Just solo orquesta."

---

## Diapositiva 7: Instalación & Disponibilidad (1:00)

**Título:** Getting Started: Instala Just

**Opciones:**
```bash
# macOS (Homebrew)
brew install just

# Linux (apt, dnf, pacman)
sudo apt install just

# Windows (Chocolatey)
choco install just

# Rust (cargo)
cargo install just

# Verificar
just --version
```

**Disponibilidad:**
- ✅ Empaquetado en la mayoría de distros
- ✅ Viene en package managers modernos
- ✅ Multi-plataforma (Linux, macOS, Windows)
- ✅ Binario único, sin dependencias runtime

**Notas:** "No tiene dependencias de runtime. Es un binario Go. Descargas, ejecutas, listo."

---

## Diapositiva 8: Sintaxis Básica (1:30)

**Título:** ¿Cómo escribo un Justfile?

```justfile
# Comentario
# Variables
PYTHON := "python3"
VERSION := "1.0.0"

# Receta simple
hello:
    echo "Hello, Mexicali!"

# Receta con dependencia
build: hello
    echo "Building version {{VERSION}}"

# Receta con parámetros
greet name:
    echo "Hola, {{name}}!"

# Receta que llama otras recetas
all: build test
```

**Ejecución:**
```bash
just hello
just greet Alice
just all
```

**Notas:** Mostrar que `{{}}` es template syntax. Explicar que las dependencias se ejecutan primero (como Make).

---

## Diapositiva 9: Características principales (2:00)

**Título:** Features que usarás todos los días

**1. Variables**
```justfile
PYTHON := "python3"
VENV := "venv"

activate-venv:
    source {{VENV}}/bin/activate
```

**2. Parámetros**
```justfile
run port="8000":
    python manage.py runserver {{port}}
```

**3. Multilínea & Scripts**
```justfile
complex:
    #!/bin/bash
    set -e
    for file in *.py; do
        echo "Processing $file"
    done
```

**4. Condicionales (opcional)**
```justfile
test target="test":
    {{if target == "coverage"}}
        pytest --cov
    {{else}}
        pytest
    {{end}}
```

**5. Exports & Env**
```justfile
export DATABASE_URL := "postgres://localhost/db"

migrate:
    alembic upgrade head
```

**Notas:** Enfatizar que puedes usar bash/sh inline sin aprender un nuevo lenguaje.

---

## Diapositiva 10: Ejemplo Python (1:30)

**Título:** Ejemplo Real: Proyecto Python Típico

```justfile
# Python Project Justfile
PYTHON := "python3"
VENV := ".venv"

# Setup
setup:
    {{PYTHON}} -m venv {{VENV}}
    {{VENV}}/bin/pip install -r requirements.txt
    {{VENV}}/bin/pip install -r requirements-dev.txt

# Testing
test:
    {{VENV}}/bin/pytest tests/ -v --cov=src

# Linting
lint:
    {{VENV}}/bin/black --check src/
    {{VENV}}/bin/ruff check src/

# Run local dev
dev:
    {{VENV}}/bin/uvicorn main:app --reload

# All (lint + test)
check: lint test
```

**Ejecución:**
```bash
just setup  # Instala todo
just dev    # Corre dev server
just check  # Lint + test
```

**Notas:** "Este es el 80% de lo que necesitas. No es mágico, solo organización."

---

## Diapositiva 11: Ejemplo Java (1:00)

**Título:** Ejemplo Real: Proyecto Java/Gradle

```justfile
# Java Project Justfile
GRADLE := "gradle"

setup:
    {{GRADLE}} wrapper

build:
    {{GRADLE}} build

test:
    {{GRADLE}} test

run:
    {{GRADLE}} bootRun

# Build + Docker
docker-build: build
    docker build -t myapp:latest .

docker-run: docker-build
    docker run -p 8080:8080 myapp:latest
```

**Notas:** "Just está *orquestando* Gradle, no reemplazándolo. Gradle hace el work pesado, Just es la interfaz amigable."

---

## Diapositiva 12: Ejemplo Node & Contenedores (2:00)

**Título:** Ejemplo Real: Node + Docker Compose

```justfile
# Node + Docker Justfile
export NODE_ENV := "development"

# Node tasks
install:
    npm ci

dev:
    npm run dev

build:
    npm run build

lint:
    npm run lint

# Docker Compose
docker-up:
    docker compose up -d

docker-down:
    docker compose down

docker-logs service="web":
    docker compose logs -f {{service}}

# Orchestration
local-setup: install docker-up
    echo "Local environment ready"

local-cleanup: docker-down
    rm -rf node_modules
    echo "Cleaned up"
```

**Ejecución:**
```bash
just local-setup
just dev
just local-cleanup
```

**Notas:** "Ves cómo Just maneja Node, npm y Docker en el mismo lugar? Eso es oro."

---

## Diapositiva 13: Módulos & Stack Complejo (2:00)

**Título:** Modularización: Stack real (tu ejemplo)

Estructura:
```
myproject/
├── justfile              # Main orchestrator
├── api/
│   └── api.justfile      # API tasks
├── web/
│   └── web.justfile      # Frontend tasks
├── infra/
│   └── infra.justfile    # DevOps tasks
└── docker-compose.yml
```

**justfile principal:**
```justfile
# Main orchestrator
mod api "api/api.justfile"
mod web "web/web.justfile"
mod infra "infra/infra.justfile"

# Orquestación
dev: api-dev web-dev infra-up
    echo "Full stack running"

deploy: api-build web-build infra-deploy
    echo "Deployed!"
```

**api/api.justfile:**
```justfile
# API module
dev:
    python -m uvicorn main:app --reload

build:
    docker build -t myapp-api .
```

**web/web.justfile:**
```justfile
# Frontend module
dev:
    npm run dev

build:
    npm run build
```

**Uso:**
```bash
just dev              # Corre todo
just api-dev         # Solo API
just api-build       # Build solo de API
```

**Notas:** "Esto es para proyectos grandes. Modularización sin overhead. Cada equipo (backend, frontend, infra) tiene su justfile, y hay uno central que orquesta."

---

## Diapositiva 14: Cuándo usar Just (1:30)

**Título:** ✅ Usa Just cuando...

- **Equipos multidisciplinarios**  
  Backend, Frontend, DevOps hablan el mismo lenguaje

- **Proyectos polyglot**  
  Mix de Python, Node, Go, Java, etc.

- **Monorepos**  
  Necesitas orquestar multiple servicios

- **Onboarding**  
  `just` lista todas las tareas, `just --help TAREA` muestra el cómo

- **Documentación viva**  
  El justfile *es* la documentación

- **CI/CD con múltiples pasos**  
  GitHub Actions hace `just ci-build`, `just ci-test`, etc.

**Notas:** "Just brilla cuando tu `README.md` tiene un apartado 'Comandos útiles' con 20 líneas. Eso va en un justfile."

---

## Diapositiva 15: Cuándo NO usar Just (1:00)

**Título:** ❌ NO uses Just cuando...

- **Proyecto puro de un lenguaje**  
  Si solo es Node: npm scripts ya resuelve  
  Si solo es Rust: Cargo ya hace todo

- **Necesitas gestión de dependencias**  
  npm, pip, cargo, Maven son mejores

- **Scripts Windows-only o Linux-only**  
  (Aunque Just lo soporta, introduce fragmented scripts)

- **Automatización industrial**  
  Necesitas Terraform, Ansible, o un job scheduler

- **Build system complejo**  
  Necesitas CMake, Bazel, o Meson

**Notas:** "Just no reemplaza herramientas especializadas. Es un orquestador amable para tareas manuales."

---

## Diapositiva 16: Cierre (1:00)

**Título:** Conclusión

**Just resume:**
1. Es Make pero moderno y amigable
2. Funciona con cualquier lenguaje
3. Orquesta, no reemplaza
4. Excelente para onboarding y documentación
5. Porta bien entre equipos

**Links:**
- https://github.com/casey/just
- https://just.systems (docs)
- https://just.systems/man/en/ (manual)

**TL;DR:**  
"Si tienes un README con comandos importantes, usa un justfile."

**Notas de cierre:** Abre para preguntas. Si alguien pregunta "¿cómo lo uso en mi proyecto?", responde: "Crea un `justfile` en la raíz, Define tus recetas, ejecuta `just` para ver la lista."

---

## Timing Sugerido

| Sección | Duración | Acumulado |
|---|---|---|
| Portada | 0:30 | 0:30 |
| Problema | 1:30 | 2:00 |
| Categoría | 1:00 | 3:00 |
| Just vs Make | 2:00 | 5:00 |
| Problemas que resuelve | 1:30 | 6:30 |
| Problemas que NO resuelve | 1:00 | 7:30 |
| Instalación | 1:00 | 8:30 |
| Sintaxis básica | 1:30 | 10:00 |
| Features | 2:00 | 12:00 |
| Python | 1:30 | 13:30 |
| Java | 1:00 | 14:30 |
| Node + Docker | 2:00 | 16:30 |
| Módulos | 2:00 | 18:30 |
| Cuándo usar | 1:30 | 20:00 |
| Cuándo no usar | 1:00 | 21:00 |
| Cierre + Q&A | 1:00 | 22:00 |

**Nota:** Total es ~22 min. Para ajustarte a 15 min:
- Reduce Java, Node, Módulos a 30-45 seg c/u (solo screenshots, no leer código)
- Combina Problemas que resuelve + NO resuelve en 2 min
- Reduce Sintaxis a 1 min

---

## Tips de Presentación

1. **Abre una terminal al lado.** Ejecuta comandos en vivo si tienes Wi-Fi estable.
2. **Usa ejemplos del proyecto real.** Si tienes un repo abierto, clone y muestra.
3. **Evita leer el código en vivo.** Preselecciona ejemplos en archivos, haz paste rápido.
4. **Pausa después de cada diapositiva "aha".** Dale a la audiencia tiempo para procesar.
5. **Mete humor.** Hablá de pain points reales (tabs en Make, ese README gigante).
6. **Ten un justfile real en tu laptop.** Si necesitas demostrar, `just` en terminal y listo.
