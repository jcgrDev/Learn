# Plan de Estudio: [NOMBRE DEL TEMA]

**Rama**: `[###-nombre-tema]` | **Fecha**: [FECHA] | **Spec**: [enlace]
**Entrada**: Especificación del tema desde `/specs/[###-nombre-tema]/spec.md`
**Formato de Citación**: APA 7

**Nota**: Esta plantilla se completa con el comando `/speckit.planificar`. Ver `.specify/templates/plan-template.md` para el flujo de trabajo de ejecución.

## Resumen

[Extraer de la especificación del tema: objetivo principal + enfoque de estudio]

## Contexto de Aprendizaje

<!--
  ACCIÓN REQUERIDA: Reemplazar el contenido de esta sección con los detalles
  del enfoque de estudio. La estructura aquí se presenta como guía.
-->

**Nivel de Profundidad**: [ej., Introductorio, Intermedio, Avanzado o NECESITA CLARIFICACIÓN]
**Fuentes Principales**: [ej., Libros, artículos, cursos, videos o NECESITA CLARIFICACIÓN]
**Herramientas de Estudio**: [ej., Anki, Notion, Jupyter, cuaderno o NECESITA CLARIFICACIÓN]
**Enfoque de Aprendizaje**: [ej., Teórico, Práctico, Mixto o NECESITA CLARIFICACIÓN]
**Tiempo Disponible**: [ej., 2 horas diarias, 3 semanas o NECESITA CLARIFICACIÓN]
**Conocimientos Previos**: [ej., Álgebra básica, programación en Python o NECESITA CLARIFICACIÓN]
**Tipo de Evaluación**: [autoevaluación/quiz/proyecto/explicación Feynman - determina la estructura]
**Limitaciones Conocidas**: [ej., Acceso a recursos, idioma, tiempo o NECESITA CLARIFICACIÓN]

## Verificación de Constitución

*COMPUERTA: Debe pasar antes del estudio de Fase 0. Re-verificar después del diseño de Fase 1.*

[Compuertas determinadas según el archivo de constitución]

## Estructura del Proyecto

### Documentación (este tema)

```text
specs/[###-tema]/
├── plan.md              # Este archivo (salida del comando /speckit.planificar)
├── research.md          # Salida de Fase 0 (comando /speckit.planificar)
├── data-model.md        # Mapa conceptual (salida de Fase 1)
├── quickstart.md        # Guía rápida de inicio (salida de Fase 1)
├── contracts/           # Plantillas de ejercicios/evaluaciones (salida de Fase 1)
└── tasks.md             # Salida de Fase 2 (comando /speckit.tareas)
```

### Estructura de Notas (raíz del repositorio)

<!--
  ACCIÓN REQUERIDA: Reemplazar el árbol con la estructura concreta.
-->

```text
# [ELIMINAR SI NO SE USA] Opción 1: Estudio teórico (POR DEFECTO)
notas/
├── conceptos/
├── resumenes/
├── ejercicios/
├── quizzes/
└── mapas-conceptuales/

# [ELIMINAR SI NO SE USA] Opción 2: Estudio práctico (con código)
notas/
├── conceptos/
├── ejercicios/
├── proyectos/
└── experimentos/

# [ELIMINAR SI NO SE USA] Opción 3: Estudio de libro
notas/
├── capitulos/
├── resumenes/
├── ejercicios/
└── glosario/
```

**Decisión de Estructura**: [Documentar la estructura seleccionada y referenciar los directorios reales]

## Seguimiento de Complejidad

> **Llenar SOLO si la Verificación de Constitución tiene violaciones que deben justificarse**

| Violación | Por Qué Es Necesaria | Alternativa Más Simple Rechazada Porque |
|-----------|----------------------|----------------------------------------|
| [ej., Saltar prerequisitos] | [necesidad actual] | [por qué no se puede] |
