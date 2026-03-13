# Guía de Integración con NotebookLM

## ¿Qué es NotebookLM?

NotebookLM es una herramienta de Google que permite subir documentos (PDFs, libros, artículos, notas) y usar IA para analizarlos. Es especialmente útil como complemento al flujo de aprendizaje SpecKit.

## Estado de Integración

**Integración directa disponible vía MCP** usando `notebooklm-mcp-cli` (jacob-bd). Configurado globalmente en Claude Code desde 2026-03-13.

| Herramienta | Integración | Uso |
|---|---|---|
| **NotebookLM** (MCP disponible) | Directa vía `notebooklm-mcp-cli` | Consultas con citaciones, crear notebooks, subir fuentes, generar podcasts |
| **Notion** (MCP disponible) | Directa vía MCP | Organizar notas, bases de datos de progreso, seguimiento |
| **PubMed** (MCP disponible) | Directa vía MCP | Buscar y leer artículos académicos |

### Instalación del MCP Server

```bash
# Instalar
uv tool install notebooklm-mcp-cli

# Autenticar (abre navegador Chromium)
nlm login
nlm login --check    # Verificar estado

# Registrar en Claude Code (global)
nlm setup add claude-code

# Verificar
claude mcp list      # Debe mostrar notebooklm-mcp: ✓ Connected
```

**Importante**: Las cookies de Google expiran periódicamente. Si las herramientas dejan de funcionar, ejecutar `nlm login` para re-autenticar.

### Herramientas MCP Disponibles (35 tools)

| Categoría | Herramientas | Uso |
|-----------|-------------|-----|
| **Notebooks** | `notebook_list`, `notebook_create`, `notebook_query` | Crear y consultar notebooks |
| **Fuentes** | `source_add`, `source_sync_drive` | Agregar PDFs, URLs, YouTube, Drive |
| **Studio** | `studio_create`, `studio_revise` | Generar podcasts y artefactos |
| **Investigación** | `research_start` | Investigar dentro de un notebook |
| **Avanzado** | `cross_notebook_query`, `batch`, `pipeline` | Multi-notebook, operaciones en lote |
| **Organización** | `tag add/list/select` | Etiquetar y filtrar notebooks |
| **Descargas** | `download_artifact` | Descargar artefactos generados |

## Cuándo Usar NotebookLM

NotebookLM es ideal para:

1. **Libros completos o PDFs extensos (>50 páginas)**
   - Subir el PDF y pedir resúmenes por capítulo
   - Hacer preguntas específicas sobre el contenido
   - Generar guías de estudio automáticas

2. **Podcasts de audio para estudio pasivo**
   - NotebookLM puede generar un "podcast" conversacional sobre el material
   - Ideal para repasar mientras caminas, cocinas, etc.
   - Complementa el estudio activo con exposición pasiva

3. **Quizzes interactivos**
   - Generar preguntas sobre el material subido
   - Más interactivo que quizzes estáticos
   - Explicaciones contextualizadas del material original

4. **Comparación de múltiples fuentes**
   - Subir 2-3 libros/artículos sobre el mismo tema
   - Pedir comparaciones y contrastes
   - Identificar consensos y desacuerdos entre fuentes

5. **Consultas con citaciones verificables** (vía MCP)
   - Desde Claude Code, consultar un notebook y recibir respuestas fundamentadas
   - Las respuestas citan exclusivamente las fuentes subidas (zero hallucination)
   - Ideal para verificar información durante el estudio

## Flujo de Trabajo Recomendado

```text
1. /speckit.especificar <tema>          # Definir qué aprender
2. /speckit.planificar                   # Crear plan de estudio
3. /speckit.ingerir <recurso>           # Ingerir libro/artículo en SpecKit
4. [MCP] Subir recurso a NotebookLM     # source_add desde Claude Code
5. /speckit.tareas                       # Crear tareas de estudio
6. /speckit.implementar                  # Estudiar con apoyo de Claude + NotebookLM
7. [MCP] Consultar NotebookLM            # notebook_query para respuestas fundamentadas
8. /speckit.quiz                         # Autoevaluación formal
9. /speckit.resumen                      # Consolidar conocimiento
```

## Cómo Usar NotebookLM desde Claude Code

### Listar notebooks existentes

Desde Claude Code: *"Lista mis notebooks de NotebookLM"*

### Crear un notebook para un tema nuevo

Desde Claude Code: *"Crea un notebook en NotebookLM llamado [nombre-del-tema]"*

### Agregar fuentes

Desde Claude Code: *"Agrega esta URL como fuente al notebook [nombre]: [URL]"*

Tipos de fuentes soportadas: PDFs, URLs, YouTube, Google Drive, texto pegado.

### Consultar con citaciones

Desde Claude Code: *"En mi notebook [nombre], pregunta: [tu pregunta]"*

Las respuestas vienen fundamentadas exclusivamente en las fuentes subidas.

### Generar podcasts

Desde Claude Code: *"Genera un podcast sobre el contenido del notebook [nombre]"*

## Complementariedad SpecKit + NotebookLM

Cuando un mismo recurso está tanto en SpecKit (vía `/speckit.ingerir`) como en NotebookLM (vía `source_add`), cada herramienta aporta algo distinto:

| Aspecto | SpecKit (`/speckit.ingerir`) | NotebookLM MCP (`notebook_query`) |
|---------|---------------------------|----------------------------------|
| **Extracción** | Conceptos clave, estructura, mapa conceptual | Texto indexado completo con citaciones |
| **Consultas** | Claude responde con contexto del proyecto | Gemini responde citando solo las fuentes subidas |
| **Verificación** | Quiz y técnica Feynman | Respuestas fundamentadas (zero hallucination) |
| **Mejor para** | Planificar el estudio y generar artefactos | Verificar datos, comparar fuentes, profundizar |

**Flujo recomendado cuando ambos tienen el recurso:**

1. Usar SpecKit para estructura y planificación del estudio
2. Usar NotebookLM para consultas puntuales con citaciones verificables
3. Cruzar respuestas: si SpecKit genera un concepto, verificarlo con `notebook_query`
4. Usar `studio_create` para generar podcasts de repaso sobre el material ya estudiado

## Uso Manual (navegador)

Si prefieres usar NotebookLM directamente:

1. Ir a notebooklm.google.com
2. Crear un nuevo notebook con el nombre del tema (ej., "001-calculo-diferencial")
3. Subir fuentes: PDFs, documentos, URLs
4. Usar las funciones:
   - **Resumen**: Vista general del material
   - **Preguntas**: Hacer preguntas específicas
   - **Audio Overview**: Generar podcast conversacional
   - **Notas**: Guardar insights importantes

## Limitaciones

- El MCP server usa **APIs internas no documentadas** de Google — puede romperse si Google cambia algo
- La autenticación es por **cookies del navegador** — expiran y requieren `nlm login` periódico
- Uso **personal/experimental** — no probado con cuentas Enterprise
- Para uso de producción, considerar la API oficial de NotebookLM Enterprise (alpha): https://docs.cloud.google.com/gemini/enterprise/notebooklm-enterprise/docs/api-notebooks

## Notion como Complemento

Notion tiene MCP integrado y puede usarse para organización y seguimiento:

```text
# Buscar notas existentes
mcp__claude_ai_Notion__notion-search

# Crear páginas de notas
mcp__claude_ai_Notion__notion-create-pages

# Crear base de datos de progreso
mcp__claude_ai_Notion__notion-create-database

# Actualizar estado de temas
mcp__claude_ai_Notion__notion-update-page
```

### Estructura sugerida en Notion:

- **Base de datos "Temas de Estudio"**: Un registro por tema/rama
  - Campos: Estado, Prioridad, Fecha inicio, Fecha meta, % Completado
- **Base de datos "Recursos"**: Un registro por fuente
  - Campos: Tipo (libro/artículo/curso), URL, Tema relacionado, Rating
- **Páginas de notas**: Una por sesión de estudio
  - Vincular a tema y recursos correspondientes
