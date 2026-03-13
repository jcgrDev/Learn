---
description: Crear un Pull Request en GitHub con secciones de plantilla llenadas por IA basadas en los commits y diff de la rama.
---

## Entrada del Usuario

```text
$ARGUMENTS
```

Si `$ARGUMENTS` no está vacío, tratarlo como el título del PR. De lo contrario, generar uno desde el nombre de rama y commits.

---

## Paso 1 — Reunir Contexto de Git

Ejecutar los siguientes comandos para entender qué hay en esta rama:

```bash
# Rama actual y remote
git branch --show-current
git remote get-url origin

# Commit base (donde esta rama divergió de main)
git merge-base HEAD main

# Commits en esta rama
git log $(git merge-base HEAD main)..HEAD --oneline --no-merges

# Archivos cambiados con estadísticas
git diff $(git merge-base HEAD main) --stat

# Solo rutas de archivos cambiados
git diff $(git merge-base HEAD main) --name-only
```

## Paso 2 — Verificar Archivos de Spec

Extraer el número y nombre del tema del nombre de rama (ej., `002-teoria-grafos` -> `specs/002-teoria-grafos/`).

Si existe un directorio de spec correspondiente, leer:
- `specs/<rama>/spec.md` — para contexto de Motivación y Alcance
- `specs/<rama>/plan.md` — para contexto de Decisiones de Diseño

## Paso 3 — Determinar Título del PR

Si `$ARGUMENTS` proporcionó un título, usarlo exactamente.

De lo contrario, derivar del nombre de rama y commits:
- Quitar prefijo numérico: `002-teoria-grafos` -> `Teoría de Grafos`
- Prefijar con tipo de commit convencional: `feat:`, `fix:`, `chore:`, `refactor:`, `docs:`

## Paso 4 — Llenar el Cuerpo del PR

Usando todo el contexto reunido, llenar la plantilla. **Omitir cualquier sección opcional si no agrega valor.**

**Reglas por sección:**
- **Resumen** (siempre incluir): 1-3 bullets describiendo qué hace el PR
- **Motivación** (incluir cuando): el cambio aborda un problema no obvio
- **Cambios** (siempre incluir): lista con bullets de qué cambió
- **Decisiones de Diseño** (incluir cuando): se tomó una decisión no obvia
- **Alcance** (incluir cuando): este PR es parte de una serie de temas
- **Verificación** (incluir para temas completados): describir cómo se verificó

## Paso 5 — Verificar Prerequisitos

1. `gh auth status` exitoso
2. La rama actual ha sido pusheada
3. No hay cambios sin commit

## Paso 6 — Crear el PR

```bash
gh pr create \
  --title "<título>" \
  --body "$(cat <<'EOF'
<cuerpo llenado>
EOF
)" \
  --base main
```

Retornar la URL del PR al usuario cuando termine.

## Paso 7 — Resumen Post-Creación

Reportar: URL del PR, secciones incluidas/omitidas, advertencias.
