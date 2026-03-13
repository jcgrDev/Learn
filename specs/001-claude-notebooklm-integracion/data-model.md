# Mapa Conceptual: Integración Claude Code ↔ NotebookLM

**Fecha**: 2026-03-13

## Conceptos y Relaciones

```text
                    ┌─────────────────┐
                    │   Claude Code   │
                    │  (Agente IA)    │
                    └────────┬────────┘
                             │ usa
                             ▼
                    ┌─────────────────┐
                    │  MCP Protocol   │
                    │  (stdio/JSON)   │
                    └────────┬────────┘
                             │ conecta
                             ▼
              ┌──────────────────────────────┐
              │  notebooklm-mcp-cli          │
              │  (MCP Server + CLI)          │
              │                              │
              │  35 tools:                   │
              │  ├─ notebook_*               │
              │  ├─ source_*                 │
              │  ├─ studio_*                 │
              │  ├─ research_*              │
              │  └─ batch/pipeline          │
              └──────────────┬───────────────┘
                             │ autentica (cookies)
                             ▼
              ┌──────────────────────────────┐
              │  Google NotebookLM           │
              │  (APIs internas)             │
              │                              │
              │  ┌─────────┐ ┌─────────┐    │
              │  │Notebook │ │Notebook │    │
              │  │  ┌──┐   │ │  ┌──┐   │    │
              │  │  │S1│   │ │  │S1│   │    │
              │  │  ├──┤   │ │  ├──┤   │    │
              │  │  │S2│   │ │  │S2│   │    │
              │  │  └──┘   │ │  └──┘   │    │
              │  └─────────┘ └─────────┘    │
              └──────────────────────────────┘
```

## Tabla de Conceptos

| Concepto | Definición | Depende de | Orden |
|----------|-----------|------------|-------|
| **Claude Code** | CLI de Anthropic que ejecuta agentes IA con acceso a herramientas | — | Prerequisito |
| **MCP (Model Context Protocol)** | Protocolo que conecta agentes IA con herramientas externas vía stdio | Claude Code | Prerequisito |
| **notebooklm-mcp-cli** | Paquete Python que expone NotebookLM como MCP server + CLI | MCP, Python/uv | 1 |
| **Autenticación (cookies)** | Método de auth que extrae cookies del navegador para acceder a APIs de Google | notebooklm-mcp-cli, navegador Chromium | 2 |
| **Biblioteca (Library)** | Colección de todos los notebooks en una cuenta NotebookLM | Autenticación | 3 |
| **Notebook** | Contenedor de fuentes y conversaciones en NotebookLM | Biblioteca | 3 |
| **Fuentes (Sources)** | Documentos (PDF, URL, YouTube, Drive, texto) subidos a un notebook | Notebook | 4 |
| **Consulta (Query)** | Pregunta enviada a un notebook que Gemini responde con citaciones | Fuentes | 5 |
| **Grounded Answer** | Respuesta de Gemini fundamentada exclusivamente en las fuentes subidas | Consulta, Fuentes | 5 |
| **Studio Artifacts** | Productos generados (podcasts, FAQs, briefings) a partir de fuentes | Fuentes | 6 |
| **Config global** | Registro del MCP server en `~/.claude/settings.json` | notebooklm-mcp-cli | 2 |

## Dependencias de Estudio

```text
1. Instalar notebooklm-mcp-cli (uv tool install)
   └─> 2. Autenticar con Google (nlm login)
       └─> 3. Configurar en Claude Code (nlm setup add claude-code)
           └─> 4. Listar notebooks existentes (notebook_list)
               ├─> 5a. Consultar notebook existente (notebook_query)
               └─> 5b. Crear notebook nuevo (notebook_create)
                   └─> 6. Agregar fuentes (source_add)
                       └─> 7. Consultar con citaciones (notebook_query)
                           └─> 8. Integrar con flujo SpecKit
```

## Conceptos Fuera del Alcance

- Notion MCP (ya configurado, no se integra en este tema)
- NotebookLM Enterprise API (oficial, alpha — diferente del MCP comunitario)
- Compartir notebooks (`notebook_share_*` — no prioritario)
