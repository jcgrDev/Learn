# Guía de Integración con NotebookLM

## ¿Qué es NotebookLM?

NotebookLM es una herramienta de Google que permite subir documentos (PDFs, libros, artículos, notas) y usar IA para analizarlos. Es especialmente útil como complemento al flujo de aprendizaje SpecKit.

## Estado de Integración

**No existe un MCP server oficial de NotebookLM** para integración directa con Claude Code. La integración es **manual** a través del navegador web.

### Alternativas MCP disponibles:

| Herramienta | Integración | Uso |
|---|---|---|
| **Notion** (MCP disponible) | Directa vía MCP | Organizar notas, bases de datos de progreso, seguimiento |
| **PubMed** (MCP disponible) | Directa vía MCP | Buscar y leer artículos académicos |
| **NotebookLM** | Manual vía navegador | Análisis profundo de PDFs/libros |

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

## Flujo de Trabajo Recomendado

```text
1. /speckit.especificar <tema>          # Definir qué aprender
2. /speckit.planificar                   # Crear plan de estudio
3. /speckit.ingerir <recurso>           # Ingerir libro/artículo en SpecKit
4. [Manual] Subir mismo recurso a NotebookLM  # Para análisis profundo
5. /speckit.tareas                       # Crear tareas de estudio
6. /speckit.implementar                  # Estudiar con apoyo de Claude
7. [Manual] Usar NotebookLM para repasar # Podcasts, Q&A, quizzes
8. /speckit.quiz                         # Autoevaluación formal
9. /speckit.resumen                      # Consolidar conocimiento
```

## Cómo Usar NotebookLM

1. Ir a notebooklm.google.com
2. Crear un nuevo notebook con el nombre del tema (ej., "001-calculo-diferencial")
3. Subir fuentes: PDFs, documentos, URLs
4. Usar las funciones:
   - **Resumen**: Vista general del material
   - **Preguntas**: Hacer preguntas específicas
   - **Audio Overview**: Generar podcast conversacional
   - **Notas**: Guardar insights importantes
5. Exportar insights relevantes de vuelta al flujo SpecKit si es necesario

## Notion como Alternativa Integrada

Dado que Notion tiene MCP integrado, puede usarse para funciones similares:

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
