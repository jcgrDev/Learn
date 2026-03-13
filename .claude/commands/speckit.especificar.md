---
description: Crear o actualizar la especificación de un tema de estudio a partir de una descripción en lenguaje natural.
agent: definidor-tema-agent
handoffs:
  - label: Crear Plan de Estudio
    agent: speckit.planificar
    prompt: Crear un plan para el tema. Quiero estudiar...
  - label: Clarificar Alcance
    agent: speckit.clarificar
    prompt: Clarificar alcance de la especificación
    send: true
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

El texto que el usuario escribió después de `/speckit.especificar` en el mensaje activador **es** la descripción del tema. Asume que siempre lo tienes disponible en esta conversación aunque `$ARGUMENTS` aparezca literalmente abajo. No pidas al usuario que lo repita a menos que haya proporcionado un comando vacío.

Dada esa descripción del tema, haz lo siguiente:

1. **Generar un nombre corto conciso** (2-4 palabras) para la rama:
   - Analizar la descripción y extraer las palabras clave más significativas
   - Crear un nombre corto de 2-4 palabras que capture la esencia del tema
   - Usar formato sustantivo-descriptor cuando sea posible (ej., "calculo-diferencial", "machine-learning-intro")
   - Preservar términos técnicos y acrónimos
   - Ejemplos:
     - "Quiero aprender cálculo diferencial" -> "calculo-diferencial"
     - "Estudiar machine learning desde cero" -> "machine-learning-intro"
     - "Entender la teoría de grafos" -> "teoria-grafos"

2. **Verificar ramas existentes antes de crear una nueva**:

   a. Primero, obtener todas las ramas remotas:
      ```bash
      git fetch --all --prune
      ```

   b. Encontrar el número más alto en todas las fuentes:
      - Ramas remotas, locales, y directorios de specs

   c. Ejecutar `.specify/scripts/bash/create-new-feature.sh --json "$ARGUMENTS"` con el número y nombre corto calculados

   **IMPORTANTE**: Solo ejecutar este script una vez por tema

3. Cargar `.specify/templates/spec-template.md` para entender las secciones requeridas.

4. Seguir este flujo de ejecución:

    1. Parsear descripción del usuario desde la Entrada
       Si vacía: ERROR "No se proporcionó descripción del tema"
    2. Extraer conceptos clave de la descripción
       Identificar: área de conocimiento, nivel, prerequisitos implícitos, alcance
    3. Para aspectos poco claros:
       - Hacer suposiciones informadas basadas en contexto
       - Solo marcar con [NECESITA CLARIFICACIÓN: pregunta específica] si:
         - La decisión impacta significativamente el alcance o nivel
         - Existen múltiples interpretaciones con implicaciones diferentes
         - No existe un valor por defecto razonable
       - **LÍMITE: Máximo 3 marcadores [NECESITA CLARIFICACIÓN] en total**
       - Priorizar: alcance > nivel > fuentes > detalles
    4. Completar sección de Objetivos de Aprendizaje
       Si no hay objetivos claros: ERROR "No se pueden determinar los objetivos"
    5. Identificar Prerequisitos
    6. Generar Recursos y Fuentes iniciales (usar WebSearch si es necesario)
    7. Definir Criterios de Éxito verificables
    8. Retornar: ÉXITO (spec lista para planificación)

5. Escribir la especificación en SPEC_FILE usando la estructura de la plantilla.

6. **Validación de Calidad**: Generar archivo en `FEATURE_DIR/checklists/requirements.md`:

   ```markdown
   # Checklist de Calidad de Especificación: [NOMBRE DEL TEMA]

   **Propósito**: Validar completitud y calidad de la especificación antes de planificación
   **Creado**: [FECHA]
   **Tema**: [Enlace a spec.md]

   ## Calidad del Contenido

   - [ ] Enfocado en QUÉ aprender, no CÓMO estudiar
   - [ ] Escrito para cualquier nivel de estudiante
   - [ ] Todas las secciones obligatorias completadas

   ## Completitud de Objetivos

   - [ ] No quedan marcadores [NECESITA CLARIFICACIÓN]
   - [ ] Los objetivos son verificables y sin ambigüedad
   - [ ] Los criterios de éxito son medibles
   - [ ] Los prerequisitos están identificados
   - [ ] El alcance está claramente delimitado

   ## Preparación del Tema

   - [ ] Todos los objetivos tienen criterios de comprensión claros
   - [ ] Los objetivos cubren el alcance declarado
   - [ ] Las fuentes iniciales están identificadas
   ```

7. Reportar finalización con nombre de rama, ruta del archivo spec, resultados del checklist, y preparación para la siguiente fase (`/speckit.clarificar` o `/speckit.planificar`).

## Guías Generales

- Enfocarse en **QUÉ** se quiere aprender y **POR QUÉ**.
- Evitar CÓMO estudiar (sin metodología detallada, sin plan de estudio).
- Escrito para cualquier nivel de estudiante.
- NO crear checklists embebidos en la spec.

### Para Generación con IA

1. **Hacer suposiciones informadas**: Usar contexto para llenar vacíos
2. **Documentar supuestos**: Registrar valores por defecto razonables
3. **Limitar clarificaciones**: Máximo 3 marcadores [NECESITA CLARIFICACIÓN]
4. **Priorizar**: alcance > nivel > fuentes > detalles

### Guías de Criterios de Éxito

Los criterios de éxito deben ser:
1. **Medibles**: Incluir métricas específicas (% correcto en quiz, capacidad de explicar, etc.)
2. **Verificables**: Pueden evaluarse mediante autoevaluación
3. **Progresivos**: De comprensión básica a aplicación

**Buenos ejemplos**:
- "Explicar los 5 conceptos fundamentales sin consultar notas"
- "Resolver correctamente el 80% de ejercicios de nivel intermedio"
- "Enseñar el concepto a otra persona y responder sus preguntas"

**Malos ejemplos**:
- "Entender bien el tema" (no medible)
- "Leer todo el libro" (actividad, no resultado)
