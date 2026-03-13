#!/usr/bin/env bash

# Actualizar archivos de contexto de agente con información de plan.md
#
# Uso: ./update-agent-context.sh [tipo_agente]
# Tipos: claude|gemini|copilot|cursor-agent|qwen|opencode|codex|windsurf|kilocode|auggie|shai|q|agy|bob|qoder
# Dejar vacío para actualizar todos los archivos de agente existentes

set -e
set -u
set -o pipefail

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

eval $(get_feature_paths)

NEW_PLAN="$IMPL_PLAN"
AGENT_TYPE="${1:-}"

CLAUDE_FILE="$REPO_ROOT/CLAUDE.md"
GEMINI_FILE="$REPO_ROOT/GEMINI.md"
COPILOT_FILE="$REPO_ROOT/.github/agents/copilot-instructions.md"
CURSOR_FILE="$REPO_ROOT/.cursor/rules/specify-rules.mdc"
QWEN_FILE="$REPO_ROOT/QWEN.md"
AGENTS_FILE="$REPO_ROOT/AGENTS.md"
WINDSURF_FILE="$REPO_ROOT/.windsurf/rules/specify-rules.md"
KILOCODE_FILE="$REPO_ROOT/.kilocode/rules/specify-rules.md"
AUGGIE_FILE="$REPO_ROOT/.augment/rules/specify-rules.md"
ROO_FILE="$REPO_ROOT/.roo/rules/specify-rules.md"
CODEBUDDY_FILE="$REPO_ROOT/CODEBUDDY.md"
QODER_FILE="$REPO_ROOT/QODER.md"
AMP_FILE="$REPO_ROOT/AGENTS.md"
SHAI_FILE="$REPO_ROOT/SHAI.md"
Q_FILE="$REPO_ROOT/AGENTS.md"
AGY_FILE="$REPO_ROOT/.agent/rules/specify-rules.md"
BOB_FILE="$REPO_ROOT/AGENTS.md"

TEMPLATE_FILE="$REPO_ROOT/.specify/templates/agent-file-template.md"

NEW_LANG=""
NEW_FRAMEWORK=""
NEW_DB=""
NEW_PROJECT_TYPE=""

log_info() { echo "INFO: $1"; }
log_success() { echo "✓ $1"; }
log_error() { echo "ERROR: $1" >&2; }
log_warning() { echo "ADVERTENCIA: $1" >&2; }

cleanup() {
    local exit_code=$?
    rm -f /tmp/agent_update_*_$$
    rm -f /tmp/manual_additions_$$
    exit $exit_code
}
trap cleanup EXIT INT TERM

validate_environment() {
    if [[ -z "$CURRENT_BRANCH" ]]; then
        log_error "No se pudo determinar el capítulo actual"
        if [[ "$HAS_GIT" == "true" ]]; then
            log_info "Asegúrese de estar en una rama de capítulo"
        else
            log_info "Establezca la variable SPECIFY_FEATURE o cree un capítulo primero"
        fi
        exit 1
    fi

    if [[ ! -f "$NEW_PLAN" ]]; then
        log_error "No se encontró plan.md en $NEW_PLAN"
        exit 1
    fi

    if [[ ! -f "$TEMPLATE_FILE" ]]; then
        log_warning "Archivo de plantilla no encontrado en $TEMPLATE_FILE"
    fi
}

extract_plan_field() {
    local field_pattern="$1"
    local plan_file="$2"

    grep "^\*\*${field_pattern}\*\*: " "$plan_file" 2>/dev/null | \
        head -1 | \
        sed "s|^\*\*${field_pattern}\*\*: ||" | \
        sed 's/^[ \t]*//;s/[ \t]*$//' | \
        grep -v "NECESITA CLARIFICACIÓN" | \
        grep -v "NEEDS CLARIFICATION" | \
        grep -v "^N/A$" || echo ""
}

parse_plan_data() {
    local plan_file="$1"

    if [[ ! -f "$plan_file" ]]; then
        log_error "Archivo de plan no encontrado: $plan_file"
        return 1
    fi

    log_info "Extrayendo datos del plan desde $plan_file"

    NEW_LANG=$(extract_plan_field "Language/Version" "$plan_file")
    if [[ -z "$NEW_LANG" ]]; then
        NEW_LANG=$(extract_plan_field "Lenguaje/Versión" "$plan_file")
    fi
    NEW_FRAMEWORK=$(extract_plan_field "Primary Dependencies" "$plan_file")
    if [[ -z "$NEW_FRAMEWORK" ]]; then
        NEW_FRAMEWORK=$(extract_plan_field "Dependencias Principales" "$plan_file")
    fi
    NEW_DB=$(extract_plan_field "Storage" "$plan_file")
    if [[ -z "$NEW_DB" ]]; then
        NEW_DB=$(extract_plan_field "Almacenamiento" "$plan_file")
    fi
    NEW_PROJECT_TYPE=$(extract_plan_field "Project Type" "$plan_file")
    if [[ -z "$NEW_PROJECT_TYPE" ]]; then
        NEW_PROJECT_TYPE=$(extract_plan_field "Tipo de Proyecto" "$plan_file")
    fi

    [[ -n "$NEW_LANG" ]] && log_info "Lenguaje encontrado: $NEW_LANG"
    [[ -n "$NEW_FRAMEWORK" ]] && log_info "Framework encontrado: $NEW_FRAMEWORK"
    [[ -n "$NEW_DB" && "$NEW_DB" != "N/A" ]] && log_info "Base de datos encontrada: $NEW_DB"
    [[ -n "$NEW_PROJECT_TYPE" ]] && log_info "Tipo de proyecto encontrado: $NEW_PROJECT_TYPE"
}

format_technology_stack() {
    local lang="$1"
    local framework="$2"
    local parts=()

    [[ -n "$lang" && "$lang" != "NEEDS CLARIFICATION" && "$lang" != "NECESITA CLARIFICACIÓN" ]] && parts+=("$lang")
    [[ -n "$framework" && "$framework" != "NEEDS CLARIFICATION" && "$framework" != "NECESITA CLARIFICACIÓN" && "$framework" != "N/A" ]] && parts+=("$framework")

    if [[ ${#parts[@]} -eq 0 ]]; then
        echo ""
    elif [[ ${#parts[@]} -eq 1 ]]; then
        echo "${parts[0]}"
    else
        local result="${parts[0]}"
        for ((i=1; i<${#parts[@]}; i++)); do
            result="$result + ${parts[i]}"
        done
        echo "$result"
    fi
}

get_project_structure() {
    local project_type="$1"
    if [[ "$project_type" == *"web"* ]]; then
        echo "backend/\\nfrontend/\\ntests/"
    else
        echo "src/\\ntests/"
    fi
}

get_commands_for_language() {
    local lang="$1"
    case "$lang" in
        *"Python"*) echo "cd src && pytest && ruff check ." ;;
        *"Rust"*) echo "cargo test && cargo clippy" ;;
        *"JavaScript"*|*"TypeScript"*) echo "npm test \\&\\& npm run lint" ;;
        *"LaTeX"*|*"latex"*) echo "latexmk -pdf main.tex" ;;
        *"R"*) echo "Rscript main.R" ;;
        *) echo "# Agregar comandos para $lang" ;;
    esac
}

get_language_conventions() {
    local lang="$1"
    echo "$lang: Seguir convenciones estándar"
}

create_new_agent_file() {
    local target_file="$1"
    local temp_file="$2"
    local project_name="$3"
    local current_date="$4"

    if [[ ! -f "$TEMPLATE_FILE" ]] || [[ ! -r "$TEMPLATE_FILE" ]]; then
        log_error "Plantilla no encontrada o no legible en $TEMPLATE_FILE"
        return 1
    fi

    log_info "Creando nuevo archivo de contexto de agente desde plantilla..."
    cp "$TEMPLATE_FILE" "$temp_file" || return 1

    local project_structure=$(get_project_structure "$NEW_PROJECT_TYPE")
    local commands=$(get_commands_for_language "$NEW_LANG")
    local language_conventions=$(get_language_conventions "$NEW_LANG")

    local escaped_lang=$(printf '%s\n' "$NEW_LANG" | sed 's/[\[\.*^$()+{}|]/\\&/g')
    local escaped_framework=$(printf '%s\n' "$NEW_FRAMEWORK" | sed 's/[\[\.*^$()+{}|]/\\&/g')
    local escaped_branch=$(printf '%s\n' "$CURRENT_BRANCH" | sed 's/[\[\.*^$()+{}|]/\\&/g')

    local tech_stack
    if [[ -n "$escaped_lang" && -n "$escaped_framework" ]]; then
        tech_stack="- $escaped_lang + $escaped_framework ($escaped_branch)"
    elif [[ -n "$escaped_lang" ]]; then
        tech_stack="- $escaped_lang ($escaped_branch)"
    else
        tech_stack="- ($escaped_branch)"
    fi

    local recent_change
    if [[ -n "$escaped_lang" && -n "$escaped_framework" ]]; then
        recent_change="- $escaped_branch: Agregado $escaped_lang + $escaped_framework"
    elif [[ -n "$escaped_lang" ]]; then
        recent_change="- $escaped_branch: Agregado $escaped_lang"
    else
        recent_change="- $escaped_branch: Agregado"
    fi

    local substitutions=(
        "s|\[PROJECT NAME\]|$project_name|"
        "s|\[DATE\]|$current_date|"
        "s|\[EXTRACTED FROM ALL PLAN.MD FILES\]|$tech_stack|"
        "s|\[ACTUAL STRUCTURE FROM PLANS\]|$project_structure|g"
        "s|\[ONLY COMMANDS FOR ACTIVE TECHNOLOGIES\]|$commands|"
        "s|\[LANGUAGE-SPECIFIC, ONLY FOR LANGUAGES IN USE\]|$language_conventions|"
        "s|\[LAST 3 FEATURES AND WHAT THEY ADDED\]|$recent_change|"
    )

    for substitution in "${substitutions[@]}"; do
        sed -i.bak -e "$substitution" "$temp_file" || return 1
    done

    newline=$(printf '\n')
    sed -i.bak2 "s/\\\\n/${newline}/g" "$temp_file"
    rm -f "$temp_file.bak" "$temp_file.bak2"

    return 0
}

update_existing_agent_file() {
    local target_file="$1"
    local current_date="$2"

    log_info "Actualizando archivo de contexto de agente existente..."

    local temp_file
    temp_file=$(mktemp) || return 1

    local tech_stack=$(format_technology_stack "$NEW_LANG" "$NEW_FRAMEWORK")
    local new_tech_entries=()
    local new_change_entry=""

    if [[ -n "$tech_stack" ]] && ! grep -q "$tech_stack" "$target_file"; then
        new_tech_entries+=("- $tech_stack ($CURRENT_BRANCH)")
    fi

    if [[ -n "$NEW_DB" ]] && [[ "$NEW_DB" != "N/A" ]] && [[ "$NEW_DB" != "NEEDS CLARIFICATION" ]] && [[ "$NEW_DB" != "NECESITA CLARIFICACIÓN" ]] && ! grep -q "$NEW_DB" "$target_file"; then
        new_tech_entries+=("- $NEW_DB ($CURRENT_BRANCH)")
    fi

    if [[ -n "$tech_stack" ]]; then
        new_change_entry="- $CURRENT_BRANCH: Agregado $tech_stack"
    elif [[ -n "$NEW_DB" ]] && [[ "$NEW_DB" != "N/A" ]]; then
        new_change_entry="- $CURRENT_BRANCH: Agregado $NEW_DB"
    fi

    local has_active_technologies=0
    local has_recent_changes=0

    grep -q "^## Tecnologías Activas\|^## Active Technologies" "$target_file" 2>/dev/null && has_active_technologies=1
    grep -q "^## Cambios Recientes\|^## Recent Changes" "$target_file" 2>/dev/null && has_recent_changes=1

    local in_tech_section=false
    local in_changes_section=false
    local tech_entries_added=false
    local changes_entries_added=false
    local existing_changes_count=0

    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" == "## Tecnologías Activas" ]] || [[ "$line" == "## Active Technologies" ]]; then
            echo "$line" >> "$temp_file"
            in_tech_section=true
            continue
        elif [[ $in_tech_section == true ]] && [[ "$line" =~ ^##[[:space:]] ]]; then
            if [[ $tech_entries_added == false ]] && [[ ${#new_tech_entries[@]} -gt 0 ]]; then
                printf '%s\n' "${new_tech_entries[@]}" >> "$temp_file"
                tech_entries_added=true
            fi
            echo "$line" >> "$temp_file"
            in_tech_section=false
            continue
        elif [[ $in_tech_section == true ]] && [[ -z "$line" ]]; then
            if [[ $tech_entries_added == false ]] && [[ ${#new_tech_entries[@]} -gt 0 ]]; then
                printf '%s\n' "${new_tech_entries[@]}" >> "$temp_file"
                tech_entries_added=true
            fi
            echo "$line" >> "$temp_file"
            continue
        fi

        if [[ "$line" == "## Cambios Recientes" ]] || [[ "$line" == "## Recent Changes" ]]; then
            echo "$line" >> "$temp_file"
            if [[ -n "$new_change_entry" ]]; then
                echo "$new_change_entry" >> "$temp_file"
            fi
            in_changes_section=true
            changes_entries_added=true
            continue
        elif [[ $in_changes_section == true ]] && [[ "$line" =~ ^##[[:space:]] ]]; then
            echo "$line" >> "$temp_file"
            in_changes_section=false
            continue
        elif [[ $in_changes_section == true ]] && [[ "$line" == "- "* ]]; then
            if [[ $existing_changes_count -lt 2 ]]; then
                echo "$line" >> "$temp_file"
                ((existing_changes_count++))
            fi
            continue
        fi

        if [[ "$line" =~ \*\*Última\ actualización\*\*:.*[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] ]] || [[ "$line" =~ \*\*Last\ updated\*\*:.*[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] ]]; then
            echo "$line" | sed "s/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/$current_date/" >> "$temp_file"
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$target_file"

    if [[ $in_tech_section == true ]] && [[ $tech_entries_added == false ]] && [[ ${#new_tech_entries[@]} -gt 0 ]]; then
        printf '%s\n' "${new_tech_entries[@]}" >> "$temp_file"
    fi

    if [[ $has_active_technologies -eq 0 ]] && [[ ${#new_tech_entries[@]} -gt 0 ]]; then
        echo "" >> "$temp_file"
        echo "## Tecnologías Activas" >> "$temp_file"
        printf '%s\n' "${new_tech_entries[@]}" >> "$temp_file"
    fi

    if [[ $has_recent_changes -eq 0 ]] && [[ -n "$new_change_entry" ]]; then
        echo "" >> "$temp_file"
        echo "## Cambios Recientes" >> "$temp_file"
        echo "$new_change_entry" >> "$temp_file"
    fi

    mv "$temp_file" "$target_file" || { rm -f "$temp_file"; return 1; }
    return 0
}

update_agent_file() {
    local target_file="$1"
    local agent_name="$2"

    log_info "Actualizando archivo de contexto de $agent_name: $target_file"

    local project_name=$(basename "$REPO_ROOT")
    local current_date=$(date +%Y-%m-%d)

    local target_dir=$(dirname "$target_file")
    [[ ! -d "$target_dir" ]] && mkdir -p "$target_dir"

    if [[ ! -f "$target_file" ]]; then
        local temp_file=$(mktemp) || return 1
        if create_new_agent_file "$target_file" "$temp_file" "$project_name" "$current_date"; then
            mv "$temp_file" "$target_file" && log_success "Creado nuevo archivo de contexto de $agent_name"
        else
            rm -f "$temp_file"
            return 1
        fi
    else
        if update_existing_agent_file "$target_file" "$current_date"; then
            log_success "Actualizado archivo de contexto de $agent_name existente"
        else
            return 1
        fi
    fi
}

update_specific_agent() {
    local agent_type="$1"
    case "$agent_type" in
        claude) update_agent_file "$CLAUDE_FILE" "Claude Code" ;;
        gemini) update_agent_file "$GEMINI_FILE" "Gemini CLI" ;;
        copilot) update_agent_file "$COPILOT_FILE" "GitHub Copilot" ;;
        cursor-agent) update_agent_file "$CURSOR_FILE" "Cursor IDE" ;;
        qwen) update_agent_file "$QWEN_FILE" "Qwen Code" ;;
        opencode) update_agent_file "$AGENTS_FILE" "opencode" ;;
        codex) update_agent_file "$AGENTS_FILE" "Codex CLI" ;;
        windsurf) update_agent_file "$WINDSURF_FILE" "Windsurf" ;;
        kilocode) update_agent_file "$KILOCODE_FILE" "Kilo Code" ;;
        auggie) update_agent_file "$AUGGIE_FILE" "Auggie CLI" ;;
        roo) update_agent_file "$ROO_FILE" "Roo Code" ;;
        codebuddy) update_agent_file "$CODEBUDDY_FILE" "CodeBuddy CLI" ;;
        qoder) update_agent_file "$QODER_FILE" "Qoder CLI" ;;
        amp) update_agent_file "$AMP_FILE" "Amp" ;;
        shai) update_agent_file "$SHAI_FILE" "SHAI" ;;
        q) update_agent_file "$Q_FILE" "Amazon Q Developer CLI" ;;
        agy) update_agent_file "$AGY_FILE" "Antigravity" ;;
        bob) update_agent_file "$BOB_FILE" "IBM Bob" ;;
        *)
            log_error "Tipo de agente desconocido '$agent_type'"
            exit 1
            ;;
    esac
}

update_all_existing_agents() {
    local found_agent=false

    [[ -f "$CLAUDE_FILE" ]] && { update_agent_file "$CLAUDE_FILE" "Claude Code"; found_agent=true; }
    [[ -f "$GEMINI_FILE" ]] && { update_agent_file "$GEMINI_FILE" "Gemini CLI"; found_agent=true; }
    [[ -f "$COPILOT_FILE" ]] && { update_agent_file "$COPILOT_FILE" "GitHub Copilot"; found_agent=true; }
    [[ -f "$CURSOR_FILE" ]] && { update_agent_file "$CURSOR_FILE" "Cursor IDE"; found_agent=true; }
    [[ -f "$QWEN_FILE" ]] && { update_agent_file "$QWEN_FILE" "Qwen Code"; found_agent=true; }
    [[ -f "$AGENTS_FILE" ]] && { update_agent_file "$AGENTS_FILE" "Codex/opencode"; found_agent=true; }
    [[ -f "$WINDSURF_FILE" ]] && { update_agent_file "$WINDSURF_FILE" "Windsurf"; found_agent=true; }
    [[ -f "$KILOCODE_FILE" ]] && { update_agent_file "$KILOCODE_FILE" "Kilo Code"; found_agent=true; }
    [[ -f "$AUGGIE_FILE" ]] && { update_agent_file "$AUGGIE_FILE" "Auggie CLI"; found_agent=true; }
    [[ -f "$ROO_FILE" ]] && { update_agent_file "$ROO_FILE" "Roo Code"; found_agent=true; }
    [[ -f "$CODEBUDDY_FILE" ]] && { update_agent_file "$CODEBUDDY_FILE" "CodeBuddy CLI"; found_agent=true; }
    [[ -f "$SHAI_FILE" ]] && { update_agent_file "$SHAI_FILE" "SHAI"; found_agent=true; }
    [[ -f "$QODER_FILE" ]] && { update_agent_file "$QODER_FILE" "Qoder CLI"; found_agent=true; }
    [[ -f "$Q_FILE" ]] && { update_agent_file "$Q_FILE" "Amazon Q Developer CLI"; found_agent=true; }
    [[ -f "$AGY_FILE" ]] && { update_agent_file "$AGY_FILE" "Antigravity"; found_agent=true; }
    [[ -f "$BOB_FILE" ]] && { update_agent_file "$BOB_FILE" "IBM Bob"; found_agent=true; }

    if [[ "$found_agent" == false ]]; then
        log_info "No se encontraron archivos de agente existentes, creando archivo Claude por defecto..."
        update_agent_file "$CLAUDE_FILE" "Claude Code"
    fi
}

print_summary() {
    echo
    log_info "Resumen de cambios:"
    [[ -n "$NEW_LANG" ]] && echo "  - Lenguaje agregado: $NEW_LANG"
    [[ -n "$NEW_FRAMEWORK" ]] && echo "  - Framework agregado: $NEW_FRAMEWORK"
    [[ -n "$NEW_DB" && "$NEW_DB" != "N/A" ]] && echo "  - Base de datos agregada: $NEW_DB"
    echo
}

main() {
    validate_environment
    log_info "=== Actualizando archivos de contexto de agente para capítulo $CURRENT_BRANCH ==="

    parse_plan_data "$NEW_PLAN" || exit 1

    local success=true
    if [[ -z "$AGENT_TYPE" ]]; then
        log_info "Sin agente específico, actualizando todos los archivos existentes..."
        update_all_existing_agents || success=false
    else
        log_info "Actualizando agente específico: $AGENT_TYPE"
        update_specific_agent "$AGENT_TYPE" || success=false
    fi

    print_summary

    if [[ "$success" == true ]]; then
        log_success "Actualización de contexto de agente completada exitosamente"
    else
        log_error "Actualización completada con errores"
        exit 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
