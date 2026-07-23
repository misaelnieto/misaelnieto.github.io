---
description: Run SEO audit using the custom seo skill
agent: explore
model: deepseek-v4-flash-free
subtask: true
---

Run a flexible SEO audit on the local site build using the `seo` skill. The command can target the whole site or be restricted to specific parts (paths, pages, or sections).

Mandatory: Always check no errors on the output of the following:

! just build

Take note of the warnings and use them through your analysis

## Restriccion de alcance de auditoria

Si "$ARGUMENTS" no esta vacio, restringe la auditoria basado en lo indicado.
Si "$ARGUMENTS" está vacío, la auditoria se restringe con estas reglas:
- Archivos en el repositorio sin commit y stage
- Si no hay archivos modificados, restringe auditoria al ultimo commit.
```

The command invokes the `seo` skill, which performs technical checks, E‑E‑A‑T analysis, AI‑visibility evaluation, link checking, and content quality review only on the specified targets. Results are written to `reports/seo-audit.md` in a structured markdown format.

# Placeholder for SEO audit command implementation
