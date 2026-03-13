#!/usr/bin/env bash

# Script consolidado de verificación de prerequisitos
#
# Uso: ./check-prerequisites.sh [OPCIONES]
#
# OPCIONES:
#   --json              Salida en formato JSON
#   --require-tasks     Requerir que tasks.md exista (para fase de implementación)
#   --include-tasks     Incluir tasks.md en la lista AVAILABLE_DOCS
#   --paths-only        Solo mostrar variables de ruta (sin validación)
#   --help, -h          Mostrar mensaje de ayuda

set -e

# Parsear argumentos
JSON_MODE=false
REQUIRE_TASKS=false
INCLUDE_TASKS=false
PATHS_ONLY=false

for arg in "$@"; do
    case "$arg" in
        --json)
            JSON_MODE=true
            ;;
        --require-tasks)
            REQUIRE_TASKS=true
            ;;
        --include-tasks)
            INCLUDE_TASKS=true
            ;;
        --paths-only)
            PATHS_ONLY=true
            ;;
        --help|-h)
            cat << 'EOF'
Uso: check-prerequisites.sh [OPCIONES]

Verificación consolidada de prerequisitos para el flujo de trabajo de tesis.

OPCIONES:
  --json              Salida en formato JSON
  --require-tasks     Requerir que tasks.md exista
  --include-tasks     Incluir tasks.md en la lista AVAILABLE_DOCS
  --paths-only        Solo mostrar variables de ruta (sin validación)
  --help, -h          Mostrar este mensaje de ayuda

EJEMPLOS:
  # Verificar prerequisitos de tareas (plan.md requerido)
  ./check-prerequisites.sh --json

  # Verificar prerequisitos de implementación (plan.md + tasks.md requeridos)
  ./check-prerequisites.sh --json --require-tasks --include-tasks

  # Obtener solo rutas (sin validación)
  ./check-prerequisites.sh --paths-only

EOF
            exit 0
            ;;
        *)
            echo "ERROR: Opción desconocida '$arg'. Use --help para información de uso." >&2
            exit 1
            ;;
    esac
done

# Cargar funciones comunes
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Obtener rutas y validar rama
eval $(get_feature_paths)
check_feature_branch "$CURRENT_BRANCH" "$HAS_GIT" || exit 1

# Si modo solo-rutas, mostrar rutas y salir
if $PATHS_ONLY; then
    if $JSON_MODE; then
        printf '{"REPO_ROOT":"%s","BRANCH":"%s","FEATURE_DIR":"%s","FEATURE_SPEC":"%s","IMPL_PLAN":"%s","TASKS":"%s"}\n' \
            "$REPO_ROOT" "$CURRENT_BRANCH" "$FEATURE_DIR" "$FEATURE_SPEC" "$IMPL_PLAN" "$TASKS"
    else
        echo "REPO_ROOT: $REPO_ROOT"
        echo "BRANCH: $CURRENT_BRANCH"
        echo "FEATURE_DIR: $FEATURE_DIR"
        echo "FEATURE_SPEC: $FEATURE_SPEC"
        echo "IMPL_PLAN: $IMPL_PLAN"
        echo "TASKS: $TASKS"
    fi
    exit 0
fi

# Validar directorios y archivos requeridos
if [[ ! -d "$FEATURE_DIR" ]]; then
    echo "ERROR: Directorio de capítulo no encontrado: $FEATURE_DIR" >&2
    echo "Ejecute /speckit.especificar primero para crear la estructura del capítulo." >&2
    exit 1
fi

if [[ ! -f "$IMPL_PLAN" ]]; then
    echo "ERROR: plan.md no encontrado en $FEATURE_DIR" >&2
    echo "Ejecute /speckit.planificar primero para crear el plan de investigación." >&2
    exit 1
fi

# Verificar tasks.md si es requerido
if $REQUIRE_TASKS && [[ ! -f "$TASKS" ]]; then
    echo "ERROR: tasks.md no encontrado en $FEATURE_DIR" >&2
    echo "Ejecute /speckit.tareas primero para crear la lista de tareas." >&2
    exit 1
fi

# Construir lista de documentos disponibles
docs=()

[[ -f "$RESEARCH" ]] && docs+=("research.md")
[[ -f "$DATA_MODEL" ]] && docs+=("data-model.md")

if [[ -d "$CONTRACTS_DIR" ]] && [[ -n "$(ls -A "$CONTRACTS_DIR" 2>/dev/null)" ]]; then
    docs+=("contracts/")
fi

[[ -f "$QUICKSTART" ]] && docs+=("quickstart.md")

if $INCLUDE_TASKS && [[ -f "$TASKS" ]]; then
    docs+=("tasks.md")
fi

# Salida de resultados
if $JSON_MODE; then
    if [[ ${#docs[@]} -eq 0 ]]; then
        json_docs="[]"
    else
        json_docs=$(printf '"%s",' "${docs[@]}")
        json_docs="[${json_docs%,}]"
    fi

    printf '{"FEATURE_DIR":"%s","AVAILABLE_DOCS":%s}\n' "$FEATURE_DIR" "$json_docs"
else
    echo "FEATURE_DIR:$FEATURE_DIR"
    echo "AVAILABLE_DOCS:"

    check_file "$RESEARCH" "research.md"
    check_file "$DATA_MODEL" "data-model.md"
    check_dir "$CONTRACTS_DIR" "contracts/"
    check_file "$QUICKSTART" "quickstart.md"

    if $INCLUDE_TASKS; then
        check_file "$TASKS" "tasks.md"
    fi
fi
