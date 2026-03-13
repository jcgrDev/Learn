# Especificación de Tema de Estudio: Integración Claude Code ↔ NotebookLM

**Rama**: `001-claude-notebooklm-integracion`
**Creado**: 2026-03-13
**Estado**: Borrador
**Formato de Citación**: APA 7
**Entrada**: Descripción del usuario: "connect the claude project in this Learn project to my notebooklm"

## Objetivos de Aprendizaje *(obligatorio)*

### Objetivo 1 - Instalar y configurar un MCP server de NotebookLM en Claude Code (Prioridad: P1)

Comprender las opciones disponibles de MCP servers para NotebookLM, seleccionar la más adecuada para el flujo de trabajo SpecKit, e instalarla y configurarla correctamente en el proyecto Learn.

**Justificación de prioridad**: Sin un MCP server funcional no existe integración posible. Es el prerequisito técnico fundamental.

**Verificación Independiente**: Puede verificarse ejecutando un comando MCP de NotebookLM desde Claude Code y obteniendo una respuesta exitosa.

**Criterios de Comprensión**:

1. **Dado** las opciones de MCP servers disponibles (PleasePrompto/notebooklm-mcp, jacob-bd/notebooklm-mcp-cli, notebooklm-skill), **Puedo** evaluar pros y contras de cada uno y seleccionar el más apropiado, **Demostrando** una comparación documentada con criterios de selección claros.
2. **Dado** el MCP server seleccionado, **Puedo** instalarlo y autenticarlo con mi cuenta de Google, **Demostrando** que `claude mcp list` muestra el servidor activo y funcional.
3. **Dado** la configuración global de Claude Code (`~/.claude/settings.json`), **Puedo** integrar el MCP server a nivel global, **Demostrando** que el servidor está disponible en cualquier proyecto Claude Code.

---

### Objetivo 2 - Establecer un flujo de trabajo integrado SpecKit ↔ NotebookLM (Prioridad: P1)

Diseñar e implementar un flujo de trabajo que conecte los comandos SpecKit (`/speckit.ingerir`, `/speckit.implementar`, etc.) con las capacidades de NotebookLM (notebooks, fuentes, consultas con citaciones).

**Justificación de prioridad**: La integración técnica sin un flujo de trabajo práctico no aporta valor. Este objetivo transforma la conexión técnica en productividad real.

**Verificación Independiente**: Puede verificarse ejecutando el flujo completo de un tema de estudio donde Claude Code consulte NotebookLM para obtener respuestas fundamentadas en fuentes subidas.

**Criterios de Comprensión**:

1. **Dado** un recurso de estudio (PDF, URL, libro), **Puedo** subirlo a NotebookLM desde Claude Code usando el MCP, **Demostrando** que el recurso aparece como fuente en un notebook de NotebookLM.
2. **Dado** un notebook con fuentes cargadas, **Puedo** hacer consultas desde Claude Code y recibir respuestas con citaciones de las fuentes, **Demostrando** que las respuestas están fundamentadas en el material subido (cero alucinaciones).
3. **Dado** el comando `/speckit.ingerir`, **Puedo** complementar la ingesta con consultas automáticas a NotebookLM, **Demostrando** que los resúmenes generados incluyen información verificada contra las fuentes originales.

---

### Objetivo 3 - Conectar y gestionar notebooks existentes desde Claude Code (Prioridad: P2)

Aprender a acceder, listar y operar sobre los notebooks ya existentes en NotebookLM desde Claude Code, y eventualmente crear nuevos siguiendo la estructura de ramas del proyecto Learn.

**Justificación de prioridad**: El usuario ya tiene notebooks con materiales — la prioridad es conectarse a ellos y consultarlos, no crear desde cero.

**Verificación Independiente**: Puede verificarse listando los notebooks existentes desde Claude Code y haciendo una consulta exitosa sobre uno de ellos.

**Criterios de Comprensión**:

1. **Dado** los notebooks existentes en mi cuenta de NotebookLM, **Puedo** listarlos y seleccionar el correcto desde Claude Code, **Demostrando** acceso a la biblioteca sin abrir el navegador.
2. **Dado** un notebook existente con fuentes ya cargadas, **Puedo** hacer consultas directamente desde Claude Code, **Demostrando** que el MCP conecta con el material ya subido.
3. **Dado** un nuevo tema de estudio (rama), **Puedo** crear un notebook adicional desde Claude Code, **Demostrando** que puedo expandir la biblioteca existente programáticamente.

---

### Prerequisitos

- Cuenta de Google con acceso a NotebookLM (notebooklm.google.com)
- Claude Code instalado y funcional (ya disponible en este proyecto)
- Python con `uv` instalado ✅ (ya disponible)
- Familiaridad básica con MCP (Model Context Protocol) en Claude Code
- MCP de Notion ya configurado (disponible en `.claude/settings.json`) — *fuera del alcance de este tema*

### Casos Límite de Comprensión

- **Confusión API oficial vs. no oficial**: NotebookLM Enterprise tiene una API oficial (alpha) de Google Cloud, pero los MCP servers comunitarios usan APIs internas no documentadas. Importante entender las implicaciones de estabilidad y seguridad.
- **MCP server vs. Skill**: PleasePrompto ofrece tanto un MCP server (`notebooklm-mcp`) como un Claude Code Skill (`notebooklm-skill`). Son enfoques diferentes con trade-offs distintos.
- **Autenticación por cookies**: Los MCP servers comunitarios requieren autenticación vía cookies del navegador, lo cual puede expirar y necesitar re-autenticación periódica.

## Recursos y Fuentes *(obligatorio)*

### Fuentes Primarias

- **FP-001**: Repositorio jacob-bd/notebooklm-mcp-cli (**seleccionado**) — CLI + MCP server en Python con funcionalidades completas: crear notebooks, agregar fuentes, generar podcasts. Setup vía `nlm setup add claude-code` (https://github.com/jacob-bd/notebooklm-mcp-cli)
- **FP-002**: Guía CLI del repositorio — Documentación de comandos `nlm` disponibles (https://github.com/jacob-bd/notebooklm-mcp-cli/blob/main/docs/CLI_GUIDE.md)
- **FP-003**: Repositorio PleasePrompto/notebooklm-mcp — Alternativa npm para referencia comparativa (https://github.com/PleasePrompto/notebooklm-mcp)

### Fuentes Complementarias

- **FC-001**: Artículo XDA Developers — Review práctico de la integración NotebookLM + Claude vía MCP (https://www.xda-developers.com/notebooklm-connects-to-claude-through-mcp/)
- **FC-002**: Guía de integración en Medium — Tutorial paso a paso para automatizar NotebookLM desde agentes IA (https://agentnativedev.medium.com/automate-google-notebooklm-from-your-ai-agent-with-notebooklm-mcp-3c513a37396a)
- **FC-003**: NotebookLM Enterprise API (oficial, alpha) — API oficial de Google para referencia de capacidades futuras (https://docs.cloud.google.com/gemini/enterprise/notebooklm-enterprise/docs/api-notebooks)
- **FC-004**: Guía existente del proyecto: `notas/notebooklm-guia.md` — Actualizar con la nueva información de integración vía MCP

### Conceptos Clave

- **MCP (Model Context Protocol)**: Protocolo estándar que permite a agentes IA (como Claude Code) conectarse con herramientas externas mediante servers que exponen capacidades como "tools"
- **NotebookLM**: Herramienta de Google que permite subir documentos y consultar una IA (Gemini) que responde exclusivamente con base en las fuentes subidas, eliminando alucinaciones
- **Biblioteca (Library)**: Colección de notebooks en NotebookLM, compartida entre clientes MCP compatibles
- **Fuentes (Sources)**: Documentos subidos a un notebook (PDFs, URLs, YouTube, Google Drive, texto) que Gemini usa para responder consultas
- **Grounded answers**: Respuestas fundamentadas exclusivamente en las fuentes subidas, con citaciones verificables

## Clarificaciones

### Sesión 2026-03-13

- P: ¿Cuál MCP server prefieres para la integración? -> R: jacob-bd/notebooklm-mcp-cli (Python/uv) — por sus funcionalidades completas (crear notebooks, agregar fuentes, generar podcasts desde CLI)
- P: ¿Tienes `uv` instalado? -> R: Sí, ya disponible — prerequisito de instalación no es una tarea pendiente
- P: ¿Qué alcance tiene el Objetivo 4 (NotebookLM ↔ Notion)? -> R: Fuera del alcance — foco exclusivo en integración Claude ↔ NotebookLM
- P: ¿Tienes notebooks existentes en NotebookLM? -> R: Sí, ya tiene notebooks con materiales — el Objetivo 3 prioriza conectarse a los existentes antes de crear nuevos
- P: ¿Configuración global o por proyecto? -> R: Global (`~/.claude/settings.json`) — disponible en todos los proyectos Claude Code

## Criterios de Éxito *(obligatorio)*

### Resultados Medibles

- **CE-001**: Ejecutar `claude mcp list` y ver el servidor de NotebookLM activo y conectado
- **CE-002**: Desde Claude Code, crear un notebook, subir al menos 2 fuentes, y hacer una consulta que devuelva una respuesta con citaciones
- **CE-003**: Completar el flujo `/speckit.ingerir` de un recurso usando NotebookLM como fuente de verificación
- **CE-004**: Actualizar `notas/notebooklm-guia.md` con la documentación de la integración funcional
- **CE-005**: Confirmar que el MCP server queda registrado en `~/.claude/settings.json` (config global) y disponible en cualquier proyecto Claude Code
