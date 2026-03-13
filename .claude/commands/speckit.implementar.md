---
description: Ejecutar el plan de estudio procesando y ejecutando todas las tareas definidas en tasks.md
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

1. Ejecutar `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks` desde la raíz del repo y parsear FEATURE_DIR y lista AVAILABLE_DOCS. Todas las rutas deben ser absolutas.

2. **Verificar estado de checklists** (si FEATURE_DIR/checklists/ existe):
   - Escanear todos los archivos de checklist
   - Para cada checklist, contar: Total de ítems, Completados, Incompletos
   - **Si algún checklist está incompleto**:
     - Mostrar tabla con conteo de ítems incompletos
     - **DETENERSE** y preguntar: "Algunos checklists están incompletos. ¿Desea proceder con el estudio de todas formas? (sí/no)"
   - **Si todos completos**: Proceder automáticamente

3. Cargar y analizar el contexto de estudio:
   - **REQUERIDO**: Leer tasks.md para la lista completa de tareas
   - **REQUERIDO**: Leer plan.md para contexto de aprendizaje, recursos y estructura
   - **SI EXISTE**: Leer data-model.md (mapa conceptual), contracts/ (ejercicios), research.md (fuentes), quickstart.md

4. Parsear estructura de tasks.md y extraer:
   - **Fases de tareas**: Preparación, Fundacional, Objetivos, Integración
   - **Dependencias**: Reglas de ejecución secuencial vs paralela
   - **Detalles de tareas**: ID, descripción, rutas, marcadores [P]

5. Ejecutar estudio siguiendo el plan de tareas:
   - **Fase por fase**: Completar cada fase antes de pasar a la siguiente
   - **Respetar dependencias**: Prerequisitos antes de objetivos
   - **Para tareas de lectura**: Guiar la lectura activa, sugerir notas clave
   - **Para tareas de ejercicios**: Generar ejercicios basados en contracts/ y research.md
   - **Para tareas de verificación**: Generar quiz usando técnica Feynman, evaluar comprensión
   - **Puntos de verificación**: Quiz/explicación Feynman en cada punto de control

6. Seguimiento de progreso y manejo de errores:
   - Reportar progreso después de cada tarea completada
   - **IMPORTANTE**: Para tareas completadas, marcar como [X] en el archivo de tareas
   - Si el estudiante no demuestra comprensión en un punto de control: sugerir repaso antes de avanzar

7. Validación de completitud:
   - Verificar que todos los criterios de éxito de spec.md se cumplan
   - Generar resumen de aprendizaje
   - Identificar áreas para profundización futura
   - Sugerir calendario de repaso espaciado

Nota: Este comando asume que existe una descomposición completa de tareas en tasks.md. Si las tareas faltan, sugerir ejecutar `/speckit.tareas` primero.
