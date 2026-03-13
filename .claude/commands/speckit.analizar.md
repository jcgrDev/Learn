---
description: Realizar un análisis no destructivo de consistencia y calidad cruzada entre spec.md, plan.md y tasks.md después de la generación de tareas.
agent: orchestrator
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Meta

Identificar inconsistencias, duplicaciones, ambigüedades e ítems sub-especificados a través de los tres artefactos principales (`spec.md`, `plan.md`, `tasks.md`) antes del estudio. Este comando DEBE ejecutarse solo después de que `/speckit.tareas` haya producido un `tasks.md` completo.

## Restricciones Operativas

**ESTRICTAMENTE SOLO LECTURA**: **No** modificar ningún archivo. Producir un informe de análisis estructurado.

**Autoridad de la Constitución**: La constitución del proyecto (`.specify/memory/constitution.md`) es **no negociable**. Conflictos con la constitución son automáticamente CRÍTICOS.

## Pasos de Ejecución

### 1. Inicializar Contexto de Análisis

Ejecutar `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks` una vez y parsear JSON para FEATURE_DIR y AVAILABLE_DOCS.

### 2. Cargar Artefactos

**Desde spec.md:** Objetivos de Aprendizaje, Prerequisitos, Criterios de Éxito, Recursos
**Desde plan.md:** Contexto de Aprendizaje, Mapa Conceptual, Estructura
**Desde tasks.md:** IDs de Tarea, Descripciones, Agrupación por fase, Marcadores [P]
**Desde constitución:** Principios de aprendizaje

### 3. Pasadas de Detección

#### A. Cobertura de Objetivos
- Objetivos sin tareas asociadas
- Tareas sin objetivo mapeado

#### B. Consistencia de Prerequisitos
- Prerequisitos declarados pero no cubiertos en fase fundacional
- Tareas que asumen conocimiento no listado en prerequisitos

#### C. Alineación con Constitución
- Violaciones de aprendizaje activo (estudio pasivo sin ejercicios)
- Falta de verificación (objetivos sin quiz/evaluación)
- Ausencia de fuentes verificables

#### D. Ambigüedades
- Criterios de éxito no medibles ("entender bien", "comprender")
- Objetivos vagos sin criterios de comprensión

#### E. Brechas de Cobertura
- Objetivos con cero tareas asociadas
- Recursos mencionados pero sin tarea de estudio

#### F. Inconsistencia
- Nivel declarado vs dificultad real de tareas
- Tiempo estimado vs alcance real

### 4. Asignación de Severidad

- **CRÍTICO**: Viola constitución, objetivo sin cobertura, prerequisito bloqueante faltante
- **ALTO**: Criterio no verificable, recurso inaccesible, prerequisito no cubierto
- **MEDIO**: Inconsistencia terminológica, recurso no especificado
- **BAJO**: Mejoras de redacción, sugerencias de organización

### 5. Producir Informe de Análisis Compacto

Salida en Markdown (sin escritura de archivos):

## Informe de Análisis de Especificación

| ID | Categoría | Severidad | Ubicación(es) | Resumen | Recomendación |
|----|-----------|----------|---------------|---------|---------------|

**Tabla Resumen de Cobertura:**

| Clave de Objetivo | ¿Tiene Tarea? | IDs de Tarea | Notas |
|-------------------|---------------|--------------|-------|

**Métricas:** Total Objetivos, Total Tareas, % Cobertura, Conteo Ambigüedades, Conteo Problemas Críticos

### 6. Acciones Siguientes

- Si hay problemas CRÍTICOS: Recomendar resolver antes de `/speckit.implementar`
- Si solo ALTO/MEDIO: El usuario puede proceder con sugerencias

### 7. Ofrecer Remediación

Preguntar: "¿Desea que sugiera ediciones concretas para los N problemas principales?"

## Principios Operativos

- **NUNCA modificar archivos**
- **NUNCA inventar secciones faltantes**
- **Priorizar violaciones de constitución** (siempre son CRÍTICAS)

## Contexto

$ARGUMENTS
