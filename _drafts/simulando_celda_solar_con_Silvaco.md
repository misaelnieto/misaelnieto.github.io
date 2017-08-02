---
published: false
---
# Simulando una celda solar con Silvaco

En la universidad tenemos Silvaco. Es una oportunidad rara para aprender a usar este simulador. Funciona con Windows (Con algunas limitaciones), pero su principal plataforma es Linux (RHEL).

Tomare el primer ejemplo `solarex01.in` que viene incluido en Silvaco como ejemplo de simulacion de celdas solares.

## Lanzando Athena

La primera herramienta a usar sera Athena. Para lanzar Athena se usa `go`.

```
go athena
```

## Rejilla de cálculo

Athena requiere que se defina una rejilla para hacer las simulaciones. El espaciado de la rejilla define qué tan
