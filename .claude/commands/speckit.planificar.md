---
description: Ejecutar el flujo de trabajo de planificación de estudio usando la plantilla del plan para generar artefactos de diseño.
agent: planificador-agent
handoffs:
  - label: Crear Tareas
    agent: speckit.tareas
    prompt: Descomponer el plan en tareas de estudio
    send: true
  - label: Crear Checklist
    agent: speckit.checklist
    prompt: Crear un checklist para el siguiente dominio...
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

1. **Configuración**: Ejecutar `.specify/scripts/bash/setup-plan.sh --json` desde la raíz del repo y parsear JSON para FEATURE_SPEC, IMPL_PLAN, SPECS_DIR, BRANCH.

2. **Cargar contexto**: Leer FEATURE_SPEC y `.specify/memory/constitution.md`. Cargar plantilla IMPL_PLAN (ya copiada).

3. **Ejecutar flujo de trabajo del plan**: Seguir la estructura en la plantilla IMPL_PLAN para:
   - Completar Contexto de Aprendizaje (marcar desconocidos como "NECESITA CLARIFICACIÓN")
   - Completar sección de Verificación de Constitución desde la constitución
   - Evaluar compuertas (ERROR si violaciones sin justificar)
   - Fase 0: Generar research.md (buscar y evaluar recursos de estudio)
   - Fase 1: Generar data-model.md (mapa conceptual), contracts/ (plantillas de ejercicios), quickstart.md
   - Fase 1: Actualizar contexto de agente ejecutando el script de agente
   - Re-evaluar Verificación de Constitución post-diseño

4. **Detenerse y reportar**: El comando termina después de la planificación. Reportar rama, ruta de IMPL_PLAN, y artefactos generados.

## Fases

### Fase 0: Investigación de Recursos

1. **Extraer necesidades del Contexto de Aprendizaje**:
   - Para cada NECESITA CLARIFICACIÓN -> tarea de búsqueda
   - Para cada objetivo -> identificar recursos adecuados
   - Para cada prerequisito -> verificar material disponible

2. **Buscar y evaluar recursos**:
   ```text
   Para cada objetivo de aprendizaje:
     Tarea: "Buscar mejores recursos para {objetivo} al nivel {nivel}"
   Para cada prerequisito:
     Tarea: "Verificar material disponible para {prerequisito}"
   ```

3. **Consolidar hallazgos** en `research.md`:
   - Recurso: [qué se encontró]
   - Evaluación: [calidad, nivel, accesibilidad]
   - Alternativas consideradas: [qué más se evaluó]

**Salida**: research.md con recursos evaluados

### Fase 1: Diseño y Estructura

**Prerequisitos:** `research.md` completo

1. **Crear mapa conceptual** desde los objetivos de la spec -> `data-model.md`:
   - Concepto, definición, relaciones con otros conceptos
   - Dependencias entre conceptos
   - Orden lógico de estudio

2. **Generar plantillas de ejercicios** desde objetivos:
   - Para cada objetivo -> plantilla de ejercicios a `/contracts/`

3. **Crear guía de inicio rápido** -> `quickstart.md`:
   - Primer paso de estudio
   - Recurso más recomendado
   - Ejercicio introductorio

4. **Actualización del contexto de agente**:
   - Ejecutar `.specify/scripts/bash/update-agent-context.sh claude`
   - Preservar adiciones manuales entre marcadores

**Salida**: data-model.md, /contracts/*, quickstart.md, archivo de agente

## Reglas clave

- Usar rutas absolutas
- ERROR en fallos de compuertas o clarificaciones sin resolver
