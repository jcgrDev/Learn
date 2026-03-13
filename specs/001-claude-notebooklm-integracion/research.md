# Investigación de Recursos: Integración Claude Code ↔ NotebookLM

**Fecha**: 2026-03-13
**Rama**: `001-claude-notebooklm-integracion`

## MCP Server Seleccionado: jacob-bd/notebooklm-mcp-cli

### Evaluación

| Criterio | Valoración | Notas |
|----------|-----------|-------|
| **Funcionalidad** | ⭐⭐⭐⭐⭐ | 35 herramientas MCP: notebooks, fuentes, consultas, studio, batch, tags |
| **Setup para Claude Code** | ⭐⭐⭐⭐ | Automático vía `nlm setup add claude-code` |
| **Documentación** | ⭐⭐⭐⭐ | README completo, CLI Guide, ejemplos |
| **Mantenimiento** | ⭐⭐⭐⭐ | Activamente mantenido (ene 2026+) |
| **Estabilidad** | ⭐⭐⭐ | APIs internas no documentadas — puede romperse sin aviso |
| **Autenticación** | ⭐⭐⭐ | Cookie-based, requiere re-login periódico |

### Instalación

```bash
# Opción 1: Via uv (recomendado)
uv tool install notebooklm-mcp-cli

# Opción 2: Via pip
pip install notebooklm-mcp-cli

# Configurar para Claude Code (global)
nlm setup add claude-code
```

### Autenticación

```bash
nlm login          # Modo automático — lanza navegador Chromium
nlm login --manual # Modo manual — importar cookies desde archivo
nlm login --check  # Verificar estado actual
```

- Soporta múltiples perfiles (cuentas Google)
- Lanza un perfil de navegador dedicado para extraer cookies automáticamente
- Las cookies expiran — necesario re-login periódico

### Herramientas MCP Disponibles (35 tools)

| Categoría | Herramientas | Uso en SpecKit |
|-----------|-------------|----------------|
| **Notebooks** | `notebook_list`, `notebook_create`, `notebook_query` | Crear/consultar notebooks por tema |
| **Fuentes** | `source_add`, `source_sync_drive` | Agregar PDFs, URLs, YouTube a notebooks |
| **Studio** | `studio_create`, `studio_revise` | Generar podcasts y artefactos |
| **Investigación** | `research_start` | Investigar un tema dentro de un notebook |
| **Avanzado** | `cross_notebook_query`, `batch`, `pipeline` | Consultar múltiples notebooks, operaciones en lote |
| **Organización** | `tag` (add/list/select) | Etiquetar y filtrar notebooks |
| **Compartir** | `notebook_share_*` | Compartir notebooks (no prioritario) |
| **Descargas** | `download_artifact` | Descargar artefactos generados |

### Prerequisitos Técnicos

- Python 3.7+ ✅ (disponible)
- uv ✅ (disponible)
- Cuenta NotebookLM ✅ (con notebooks existentes)
- Navegador Chromium ✅ (para autenticación)

### Limitaciones Documentadas

1. **APIs no oficiales**: "internal APIs that are undocumented and may change without notice"
2. **Cookie authentication**: Requiere re-autenticación periódica
3. **Uso personal**: "use at your own risk for personal/experimental purposes"
4. **Enterprise**: No probado con cuentas NotebookLM Enterprise

## Alternativa Evaluada: PleasePrompto/notebooklm-mcp

| Criterio | Valoración | Comparación |
|----------|-----------|-------------|
| Setup | ⭐⭐⭐⭐⭐ | Más rápido (npx) pero menos funcionalidades |
| Funcionalidades | ⭐⭐⭐ | Menos herramientas que notebooklm-mcp-cli |
| Perfiles | ⭐⭐⭐⭐ | Minimal/Standard/Full — control de tokens |

**Decisión**: Se eligió `jacob-bd/notebooklm-mcp-cli` por funcionalidades completas (35 tools vs. menos) y mayor control sobre notebooks y fuentes.

## Recurso Complementario: notebooklm-guia.md (existente)

- **Estado**: Desactualizado — dice "No existe un MCP server oficial de NotebookLM"
- **Acción**: Actualizar con la información de integración MCP funcional
- **Secciones a modificar**: Estado de Integración, Flujo de Trabajo Recomendado, Notion como Alternativa

## Referencias

- jacob-bd. (2026). *notebooklm-mcp-cli* [Software]. GitHub. https://github.com/jacob-bd/notebooklm-mcp-cli
- PleasePrompto. (2026). *notebooklm-mcp* [Software]. GitHub. https://github.com/PleasePrompto/notebooklm-mcp
- Google. (2025). *NotebookLM Enterprise API* [Documentación]. Google Cloud. https://docs.cloud.google.com/gemini/enterprise/notebooklm-enterprise/docs/api-notebooks
