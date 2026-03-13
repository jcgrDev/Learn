# Documentación de Setup: NotebookLM MCP

**Fecha**: 2026-03-13
**Versión**: notebooklm-mcp-cli 0.3.15

## Configuración Final

| Componente | Valor |
|-----------|-------|
| Paquete | `notebooklm-mcp-cli` vía `uv tool install` |
| CLI | `nlm` (v0.3.15) |
| Cuenta | jcgrdev@gmail.com |
| Scope | Global (`~/.claude/settings.json`) |
| Notebooks accesibles | 18 (al momento del setup) |

## Problemas Encontrados y Soluciones

### 1. Herramientas MCP no disponibles en la misma sesión

**Problema**: Después de ejecutar `nlm setup add claude-code`, las herramientas MCP no están disponibles inmediatamente en la sesión activa de Claude Code.

**Solución**: Iniciar una nueva sesión de Claude Code. Las herramientas se cargan al inicio de la sesión.

### 2. Tags no disponibles en v0.3.15

**Problema**: El data-model.md mencionaba herramientas de tags (`tag add`, `tag list`, `tag select`) pero no existen en la versión 0.3.15 de la CLI.

**Solución**: Usar `nlm alias` como alternativa para organización rápida de notebooks. Ejemplo: `nlm alias set wonderlic <notebook-id>`.

### 3. Respuestas largas de `source_get_content`

**Problema**: Al obtener el contenido crudo de una fuente con `source_get_content`, el resultado puede exceder los límites de tokens del MCP (ej., Wikipedia con ~80K caracteres).

**Solución**: El resultado se guarda automáticamente en un archivo temporal. Usar `grep` sobre ese archivo para buscar datos específicos en lugar de leer todo el contenido.

## Comandos de Mantenimiento

```bash
# Re-autenticar si expiran cookies
nlm login

# Verificar estado de autenticación
nlm login --check

# Diagnosticar instalación
nlm doctor

# Actualizar paquete
uv tool upgrade notebooklm-mcp-cli
```

## Notebook de Prueba

- **Nombre**: 001-claude-notebooklm-integracion
- **ID**: 64ff33b5-bb15-4d83-ad8e-cf30a18c022b
- **Fuentes**: GitHub repo jacob-bd + XDA Developers
- **URL**: https://notebooklm.google.com/notebook/64ff33b5-bb15-4d83-ad8e-cf30a18c022b
