---
description: Convertir tareas existentes en issues de GitHub accionables basados en los artefactos de diseño disponibles.
tools: ['github/github-mcp-server/issue_write']
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

1. Ejecutar `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks` desde la raíz del repo y parsear FEATURE_DIR y lista AVAILABLE_DOCS. Todas las rutas deben ser absolutas.
1. Del script ejecutado, extraer la ruta a **tasks**.
1. Obtener el remote de Git ejecutando:

```bash
git config --get remote.origin.url
```

> [!PRECAUCIÓN]
> SOLO PROCEDER A LOS SIGUIENTES PASOS SI EL REMOTE ES UNA URL DE GITHUB

1. Para cada tarea en la lista, usar el servidor MCP de GitHub para crear un nuevo issue en el repositorio representado por el remote de Git.

> [!PRECAUCIÓN]
> BAJO NINGUNA CIRCUNSTANCIA CREAR ISSUES EN REPOSITORIOS QUE NO COINCIDAN CON LA URL DEL REMOTE
