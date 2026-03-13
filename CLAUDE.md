# Learn — Guías de Aprendizaje

Repositorio multi-aprendizaje. Cada rama es un tema de estudio independiente. Última actualización: 2026-03-13

## Tecnologías Activas

- Python + notebooklm-mcp-cli (001-claude-notebooklm-integracion)

## Estructura del Proyecto

```text
specs/           # Especificaciones de temas de aprendizaje (uno por rama)
.specify/        # Herramientas SpecKit (scripts, plantillas, constitución)
.claude/         # Configuración de agentes Claude (con PubMed, Notion y WebSearch)
notas/           # Notas de estudio y productos de aprendizaje
```

## Comandos

```bash
# Flujo de trabajo SpecKit para aprendizaje (en español)
/speckit.especificar <tema>        # Crear especificación de tema de estudio
/speckit.clarificar                # Clarificar dudas y alcance del tema
/speckit.planificar                # Crear plan de estudio
/speckit.tareas                    # Descomponer plan en tareas de aprendizaje
/speckit.analizar                  # Verificar consistencia entre artefactos
/speckit.implementar               # Ejecutar tareas de estudio
/speckit.checklist                 # Crear checklist de comprensión
/speckit.constitucion              # Actualizar constitución del proyecto
/speckit.quiz                      # Generar quiz de autoevaluación
/speckit.resumen                   # Generar resumen ejecutivo del tema
/speckit.ingerir <fuente>          # Ingerir libro/artículo/recurso para estudio
/pr                                # Crear Pull Request
```

## Estilo

- Todo el flujo de trabajo opera en español
- Formato de citación: **APA 7** en todo el repositorio
- Los agentes de aprendizaje usan PubMed, WebSearch, WebFetch y Notion para fuentes verificables
- Se priorizan fuentes primarias y textos de referencia del área
- Integración con Notion para organización de notas y seguimiento de progreso

## Integraciones Externas

- **Notion**: Organización de notas, bases de datos de progreso, y seguimiento de temas
- **PubMed**: Búsqueda de artículos académicos para temas científicos/médicos
- **NotebookLM** (MCP vía `notebooklm-mcp-cli`): Consultas con citaciones, crear notebooks, subir fuentes, generar podcasts — todo desde Claude Code (ver notas/notebooklm-guia.md)

## Cambios Recientes

- 001-claude-notebooklm-integracion: Agregado Python + notebooklm-mcp-cli

<!-- ADICIONES MANUALES INICIO -->
<!-- ADICIONES MANUALES FIN -->
