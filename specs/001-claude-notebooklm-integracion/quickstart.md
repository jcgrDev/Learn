# Guía Rápida: Integración Claude Code ↔ NotebookLM

**Tiempo estimado**: 10-15 minutos

## Paso 1: Instalar el MCP server

```bash
uv tool install notebooklm-mcp-cli
```

## Paso 2: Autenticar con Google

```bash
nlm login
```

Se abrirá un navegador Chromium. Inicia sesión con tu cuenta de Google que tiene NotebookLM. Las cookies se extraen automáticamente.

Verificar autenticación:
```bash
nlm login --check
```

## Paso 3: Configurar para Claude Code (global)

```bash
nlm setup add claude-code
```

Esto registra el MCP server en `~/.claude/settings.json` con scope global.

Verificar:
```bash
claude mcp list
```

Debe mostrar `notebooklm-mcp` en la lista.

## Paso 4: Probar desde Claude Code

Abre Claude Code en cualquier proyecto y pide:

> "Lista mis notebooks de NotebookLM"

Claude Code usará la herramienta `notebook_list` del MCP para mostrar tus notebooks existentes.

## Paso 5: Primera consulta

> "En mi notebook [nombre], pregunta: ¿cuáles son los conceptos principales?"

Claude Code usará `notebook_query` y recibirás una respuesta con citaciones de las fuentes en ese notebook.

## Troubleshooting

| Problema | Solución |
|----------|---------|
| `nlm login` no abre navegador | Usa `nlm login --manual` e importa cookies |
| `claude mcp list` no muestra el server | Ejecuta `nlm setup add claude-code` de nuevo |
| Cookies expiradas | Ejecuta `nlm login` otra vez |
| Error de autenticación en Claude Code | Verifica con `nlm login --check`, re-autentica si es necesario |

## Siguiente paso

Una vez verificado, procede a las tareas detalladas en `tasks.md` (generado con `/speckit.tareas`).
