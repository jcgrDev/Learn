---
description: Ingerir un libro, artículo o recurso para extraer conceptos clave y generar material de estudio.
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

1. Ejecutar `.specify/scripts/bash/check-prerequisites.sh --json --paths-only` desde la raíz del repo y parsear FEATURE_DIR.

2. **Identificar tipo de recurso** desde `$ARGUMENTS`:
   - **PDF local**: Leer con Read tool (usar parámetro `pages` para PDFs grandes)
   - **URL**: Usar WebFetch para acceder al contenido
   - **Artículo PubMed (PMID/DOI)**: Usar herramientas PubMed para obtener texto completo
   - **Referencia bibliográfica**: Usar WebSearch + PubMed para localizar el recurso

3. **Extraer contenido estructurado**:
   - Índice / estructura del recurso
   - Conceptos clave por sección/capítulo
   - Definiciones importantes
   - Argumentos principales y conclusiones
   - Figuras/tablas relevantes (descripción textual)
   - Relaciones entre conceptos

4. **Crear directorio de ingestiones** si no existe: `FEATURE_DIR/ingestiones/`

5. **Generar material de estudio** en `FEATURE_DIR/ingestiones/<nombre-recurso>.md`:

   ```markdown
   # Ingestión: [TÍTULO DEL RECURSO]
   **Autor(es)**: [Autor(es)]
   **Fuente**: [Editorial/URL/DOI]
   **Tipo**: [Libro/Artículo/Curso/Video]
   **Fecha de ingestión**: [FECHA]
   **Relevancia para spec**: [Qué objetivos de aprendizaje cubre]

   ## Estructura del Recurso
   [Índice resumido con capítulos/secciones principales]

   ## Conceptos Clave Extraídos
   - **[Concepto 1]**: [Definición/explicación clara]
   - **[Concepto 2]**: [Definición/explicación clara]

   ## Ideas Principales
   1. [Idea principal 1 con contexto]
   2. [Idea principal 2 con contexto]
   3. [Idea principal 3 con contexto]

   ## Conexiones con Objetivos de Aprendizaje
   - OA1: [Cómo se relaciona este recurso con el objetivo 1]
   - OA2: [Cómo se relaciona con el objetivo 2]

   ## Preguntas para Reflexión
   - [Pregunta 1 derivada del material para profundizar comprensión]
   - [Pregunta 2]
   - [Pregunta 3]

   ## Flashcards Sugeridas
   | Frente | Reverso |
   |--------|---------|
   | [Pregunta/concepto] | [Respuesta/definición] |
   | [Pregunta/concepto] | [Respuesta/definición] |

   ## Citas Relevantes
   - "[Cita textual importante]" (p. XX)

   ## Notas Adicionales
   [Observaciones, conexiones con otros recursos, puntos de desacuerdo]
   ```

6. **Actualizar research.md** si existe: agregar el recurso a las fuentes consultadas con su evaluación.

7. **Sugerencia NotebookLM** (para recursos extensos):
   Si el recurso es un PDF o libro extenso (>50 páginas), informar al usuario:
   ```
   Para un análisis más profundo de este recurso, considera subirlo a NotebookLM:
   1. Ve a notebooklm.google.com
   2. Crea un nuevo notebook
   3. Sube el PDF/recurso
   4. Usa las funciones de resumen, Q&A y podcast de audio

   NotebookLM es especialmente útil para:
   - Generar resúmenes por capítulo
   - Hacer preguntas específicas sobre el contenido
   - Generar podcasts de audio para estudio pasivo
   - Crear fichas de estudio interactivas

   Ver notas/notebooklm-guia.md para más detalles.
   ```

8. **Reportar**: Ruta de la ingestión, número de conceptos extraídos, conexiones con objetivos, flashcards generadas.
