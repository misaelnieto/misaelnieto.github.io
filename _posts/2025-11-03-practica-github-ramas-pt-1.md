---
title: "Práctica: Trabajando con Ramas en Git (Parte 1)"
summary: "Aprende a usar ramas en Git para experimentar sin miedo. Crea, cambia y combina ramas en esta guía para principiantes."
description: "Este tutorial te enseña los conceptos básicos de las ramas en Git. Aprenderás a crear una rama para trabajar en una nueva función, cambiar entre ramas y fusionar tus cambios de nuevo en la rama principal. Esta es la primera parte de una serie de tutoriales sobre Git."
date: 2025-11-03
categories:
    - Tutoriales
tags:
    - Git
    - GitHub
    - Ramas
    - Tutorial
    - Principiantes
locale: es_MX
hero_svg: /assets/img/heroes/connections.svg
keywords: "Git, GitHub, branches, tutorial, beginners, ramas, control de versiones"
preview: /media/unsplash/brian-suh-a4GET0s82rI-unsplash.jpg
image: /media/unsplash/brian-suh-a4GET0s82rI-unsplash.jpg
---

**Instituto Tecnológico de Mexicali**
Fundamentos de Ingeniería
2025-2

## Tu Primera Aventura con Múltiples Versiones 🌳

**Duración:** 30 minutos
**Nivel:** Principiante absoluto
**Herramientas:** Git Bash en Windows

---

## 🎯 ¿Qué vamos a aprender hoy?

Imagina que estás escribiendo un documento importante. De repente piensas: "¿Y si pruebo agregar este párrafo? Pero... ¿qué pasa si no queda bien?".

Las **ramas en Git** son como tener múltiples borradores de tu trabajo. Puedes experimentar en uno sin dañar el original. Si te gusta el resultado, lo combinas. Si no, simplemente lo descartas.

**No te preocupes:** No vas a romper nada. Git está diseñado para proteger tu trabajo. Es prácticamente imposible perder datos si sigues estos pasos.

---

## 📚 Analogía Visual: El Árbol de Decisiones

Piensa en Git como un árbol:
```
        master (tronco principal)
          |
          |-----> nueva-funcion (rama experimental)
          |
          v
    (tu proyecto continúa)
```

- El **tronco (master)** es tu versión estable
- Las **ramas** son experimentos que crecen del tronco
- Puedes **podar** (eliminar) ramas que no te gusten
- Puedes **injertar** (merge) ramas exitosas de vuelta al tronco

---

## 🛠️ Preparación Inicial

### Paso 1: Crear nuestro proyecto base

Abre Git Bash y ejecuta estos comandos uno por uno:

```bash
# Crear y entrar a la carpeta del proyecto
mkdir calculadora-simple
cd calculadora-simple

# Inicializar Git (como poner la primera página de un cuaderno nuevo)
git init
```

**✅ CHECKPOINT:** Si escribes `dir` deberías ver una carpeta vacía. ¡Perfecto!

### Paso 2: Crear el archivo principal

```bash
# Crear nuestro archivo de calculadora
echo "# Calculadora Simple" > calculadora.py
echo "def sumar(a, b):" >> calculadora.py
echo "    return a + b" >> calculadora.py
```

**✅ CHECKPOINT:** Escribe `type calculadora.py` y deberías ver 3 líneas de código.

### Paso 3: Guardar esta versión en Git

```bash
# Agregar el archivo a Git
git add calculadora.py

# Guardar esta versión (como tomar una foto)
git commit -m "Calculadora básica con suma"
```

**✅ CHECKPOINT:** Si ves un mensaje con "[master (root-commit)]", ¡todo va bien!

---

## 🌿 Creando Tu Primera Rama

### ¿Por qué los archivos "cambian" entre ramas?

**Analogía del Cuaderno Mágico:**
Imagina que tienes un cuaderno mágico. Cuando dices "quiero ver la versión A", las páginas muestran esa versión. Cuando dices "quiero ver la versión B", las páginas cambian automáticamente.

Git funciona igual: cuando cambias de rama, Git reescribe automáticamente los archivos para mostrar esa versión. **Tus otras versiones siguen guardadas**, solo que no las estás viendo en este momento.

### Paso 4: Crear una rama nueva

```bash
# Crear y cambiar a una nueva rama llamada "resta"
git checkout -b resta
```

**💡 Explicación:** Acabas de crear una "copia paralela" de tu proyecto. Ahora puedes experimentar sin afectar la versión original.

**✅ CHECKPOINT:** Git debe decir "Switched to a new branch 'resta'"

### Paso 5: Agregar la función de resta

```bash
# Agregar la función de resta al archivo
echo "" >> calculadora.py
echo "def restar(a, b):" >> calculadora.py
echo "    return a - b" >> calculadora.py
```

Veamos cómo quedó:
```bash
type calculadora.py
```

**✅ CHECKPOINT:** Deberías ver AMBAS funciones: sumar y restar.

### Paso 6: Guardar estos cambios en la rama

```bash
# Guardar los cambios en la rama "resta"
git add calculadora.py
git commit -m "Agregar función de resta"
```

---

## 🔄 El Momento Mágico: Cambiar Entre Ramas

### Paso 7: Volver a la rama principal

**⚠️ IMPORTANTE:** No te asustes cuando veas que el archivo cambia. Es normal y esperado.

```bash
# Volver a la rama master
git checkout master

# Ver el contenido del archivo
type calculadora.py
```

**🎉 ¿Qué pasó?** El archivo ahora NO tiene la función restar. ¡Pero no se perdió! Está guardada en la otra rama.

**✅ CHECKPOINT:** Solo debes ver la función `sumar`, NO la función `restar`.

### Paso 8: Confirmar que la otra versión existe

```bash
# Volver a la rama resta
git checkout resta

# Ver el archivo
type calculadora.py
```

**✅ CHECKPOINT:** ¡La función restar apareció de nuevo! ¿Ves? No se perdió nada.

---

## 🤝 Combinando las Ramas (Merge)

### ¿Qué es un merge?

Un **merge** es decirle a Git: "Me gustó este experimento, quiero agregarlo a mi versión principal".

### Visualización del Merge:

```
ANTES:
master:  [suma]
resta: [suma] + [resta]

DESPUÉS DEL MERGE:
master:  [suma] + [resta]  ← trae los cambios de "resta"
resta: [suma] + [resta]  ← sigue igual
```

### Paso 9: Hacer el merge

```bash
# IMPORTANTE: Primero, asegúrate de estar en master
git checkout master

# Ahora, traer los cambios de "resta" hacia "master"
git merge resta
```

**📝 Traducción:** "Estando en master, quiero traer lo que hice en resta"

**✅ CHECKPOINT:** Git debe decir algo como "1 file changed, 3 insertions(+)"

### Paso 10: Verificar el resultado

```bash
# Ver que ahora master tiene ambas funciones
type calculadora.py
```

**✅ CHECKPOINT FINAL:** Deberías ver AMBAS funciones en la rama master.

---

## 🎊 ¡Felicidades!

Has completado tu primera práctica con ramas. Ahora sabes:

1. ✅ Crear ramas para experimentar sin riesgo
2. ✅ Cambiar entre diferentes versiones de tu código
3. ✅ Combinar cambios exitosos de vuelta a master
4. ✅ Que Git protege tu trabajo (nada se pierde)

---

## 📊 Comandos Opcionales (Para los Curiosos)

Si quieres ver un "mapa" de tus ramas:
```bash
# Ver todas las ramas que existen
git branch

# Ver el historial de commits
git log
```

Presiona `q` para salir del log si se queda "atorado".

---

## 🆘 Troubleshooting

**"Me sale un error al hacer checkout"**
- Solución: Guarda tus cambios primero con `git add .` y `git commit -m "guardar cambios"`

**"No veo los cambios después del merge"**
- Solución: Verifica estar en la rama correcta con `git branch`. El asterisco (*) indica dónde estás.

**"Tengo miedo de perder mi trabajo"**
- Tranquilo: Git guarda TODO. Incluso si algo sale mal, siempre podemos recuperar versiones anteriores.

---

## 💡 Consejos del Profesor

1. **No memorices comandos**, entiende QUÉ hacen
2. **Experimenta sin miedo** - Git está diseñado para protegerte
3. **Si algo sale mal**, solo pregunta. No hay preguntas tontas
4. **La práctica hace al maestro** - Entre más uses Git, más natural se vuelve

---

## 🏁 Entrega

1. Toma una captura de pantalla mostrando el resultado de `type calculadora.py` con ambas funciones
2. Toma otra captura mostrando el resultado de `git branch`
3. Genera un reporte con portada, agrega las capturas de pantalla y envialo por PDF al grupo de Whatsapp.

**Tiempo estimado:** 25-30 minutos

---

*Recuerda: Git es como aprender a andar en bicicleta. Al principio parece complicado, pero una vez que le agarras el modo, no lo olvidas nunca. ¡Tú puedes!* 🚀
