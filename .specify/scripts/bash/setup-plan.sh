#!/usr/bin/env bash

set -e

# Parsear argumentos de línea de comandos
JSON_MODE=false
ARGS=()

for arg in "$@"; do
    case "$arg" in
        --json)
            JSON_MODE=true
            ;;
        --help|-h)
            echo "Uso: $0 [--json]"
            echo "  --json    Salida en formato JSON"
            echo "  --help    Mostrar este mensaje de ayuda"
            exit 0
            ;;
        *)
            ARGS+=("$arg")
            ;;
    esac
done

# Obtener directorio del script y cargar funciones comunes
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Obtener todas las rutas y variables de funciones comunes
eval $(get_feature_paths)

# Verificar si estamos en una rama de capítulo apropiada
check_feature_branch "$CURRENT_BRANCH" "$HAS_GIT" || exit 1

# Asegurar que el directorio de capítulo exista
mkdir -p "$FEATURE_DIR"

# Copiar plantilla del plan si existe
TEMPLATE="$REPO_ROOT/.specify/templates/plan-template.md"
if [[ -f "$TEMPLATE" ]]; then
    cp "$TEMPLATE" "$IMPL_PLAN"
    echo "Plantilla del plan copiada a $IMPL_PLAN"
else
    echo "Advertencia: Plantilla del plan no encontrada en $TEMPLATE"
    touch "$IMPL_PLAN"
fi

# Salida de resultados
if $JSON_MODE; then
    printf '{"FEATURE_SPEC":"%s","IMPL_PLAN":"%s","SPECS_DIR":"%s","BRANCH":"%s","HAS_GIT":"%s"}\n' \
        "$FEATURE_SPEC" "$IMPL_PLAN" "$FEATURE_DIR" "$CURRENT_BRANCH" "$HAS_GIT"
else
    echo "FEATURE_SPEC: $FEATURE_SPEC"
    echo "IMPL_PLAN: $IMPL_PLAN"
    echo "SPECS_DIR: $FEATURE_DIR"
    echo "BRANCH: $CURRENT_BRANCH"
    echo "HAS_GIT: $HAS_GIT"
fi
