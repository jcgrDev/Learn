---
description: "Plantilla de lista de tareas para estudio de un tema"
---

# Tareas: [NOMBRE DEL TEMA]

**Entrada**: Documentos de diseño desde `/specs/[###-nombre-tema]/`
**Prerequisitos**: plan.md (requerido), spec.md (requerido para objetivos), research.md
**Organización**: Las tareas se agrupan por objetivo de aprendizaje para permitir estudio independiente.

## Formato: `[ID] [P?] [Objetivo] Descripción`

- **[P]**: Puede estudiarse en paralelo (sin dependencias)
- **[Objetivo]**: A qué objetivo pertenece esta tarea (ej., OA1, OA2, OA3)
- Incluir rutas exactas de archivo/recurso en las descripciones

<!--
  ============================================================================
  IMPORTANTE: Las tareas abajo son EJEMPLOS con fines ilustrativos.

  El comando /speckit.tareas DEBE reemplazarlas con tareas reales basadas en:
  - Objetivos de aprendizaje desde spec.md (con sus prioridades P1, P2, P3...)
  - Plan de estudio desde plan.md
  - Mapa conceptual desde data-model.md

  Las tareas DEBEN organizarse por objetivo para que cada uno pueda:
  - Estudiarse de forma independiente
  - Verificarse de forma independiente
  - Completarse como un incremento de conocimiento

  NO mantener estas tareas de ejemplo en el archivo tasks.md generado.
  ============================================================================
-->

## Fase 1: Preparación (Infraestructura de Estudio)

**Propósito**: Configurar ambiente y recursos de estudio

- [ ] T001 Recopilar y organizar fuentes de estudio según plan
- [ ] T002 Configurar herramientas de estudio (Anki, Notion, cuaderno)
- [ ] T003 [P] Crear estructura de notas según plan

---

## Fase 2: Fundacional (Prerequisitos)

**Propósito**: Cubrir conocimientos previos que DEBEN dominarse antes de CUALQUIER objetivo

**CRÍTICO**: Ningún objetivo puede comenzar hasta que esta fase esté completa

- [ ] T004 Revisar y reforzar prerequisitos identificados en spec.md
- [ ] T005 [P] Crear glosario de términos fundamentales
- [ ] T006 [P] Lectura exploratoria inicial del material principal
- [ ] T007 Autoevaluación de prerequisitos (verificar dominio base)

**Punto de control**: Fundación lista - el estudio por objetivos puede comenzar

---

## Fase 3: Objetivo 1 - [Título] (Prioridad: P1) MVP

**Meta**: [Breve descripción de lo que este objetivo entrega como conocimiento]

**Verificación Independiente**: [Cómo verificar comprensión de este objetivo por sí solo]

### Estudio del Objetivo 1

- [ ] T008 [P] [OA1] Lectura profunda del material sobre objetivo 1
- [ ] T009 [P] [OA1] Tomar notas activas y crear resumen en notas/resumenes/
- [ ] T010 [OA1] Crear mapa conceptual del objetivo 1
- [ ] T011 [OA1] Resolver ejercicios prácticos en notas/ejercicios/
- [ ] T012 [OA1] Explicar el concepto en palabras propias (Feynman)
- [ ] T013 [OA1] Autoevaluación: quiz sobre objetivo 1

**Punto de control**: El Objetivo 1 debe ser completamente comprendido y verificable

---

## Fase 4: Objetivo 2 - [Título] (Prioridad: P2)

**Meta**: [Breve descripción]

**Verificación Independiente**: [Cómo verificar comprensión]

### Estudio del Objetivo 2

- [ ] T014 [P] [OA2] Lectura profunda del material sobre objetivo 2
- [ ] T015 [OA2] Tomar notas y crear resumen
- [ ] T016 [OA2] Resolver ejercicios prácticos
- [ ] T017 [OA2] Autoevaluación: quiz sobre objetivo 2

**Punto de control**: Los Objetivos 1 Y 2 deben estar comprendidos

---

## Fase N: Integración y Consolidación

**Propósito**: Conectar conceptos y consolidar conocimiento

- [ ] TXXX [P] Crear resumen ejecutivo integrando todos los objetivos
- [ ] TXXX Crear mapa conceptual integrado
- [ ] TXXX [P] Resolver ejercicios que combinen múltiples objetivos
- [ ] TXXX Evaluación final comprensiva (quiz integrador)
- [ ] TXXX Identificar áreas para profundización futura
- [ ] TXXX Preparar flashcards de repaso espaciado

---

## Dependencias y Orden de Ejecución

### Dependencias entre Fases

- **Preparación (Fase 1)**: Sin dependencias - puede comenzar inmediatamente
- **Fundacional (Fase 2)**: Depende de la Preparación - BLOQUEA todos los objetivos
- **Objetivos (Fase 3+)**: Todos dependen de la Fase Fundacional
  - Los objetivos pueden proceder en paralelo (si no hay dependencia conceptual)
  - O secuencialmente en orden de prioridad (P1, P2, P3)
- **Integración (Fase Final)**: Depende de que todos los objetivos estén completos

### Oportunidades de Paralelismo

- Todas las tareas de Preparación marcadas [P] pueden ejecutarse en paralelo
- Una vez completa la fase Fundacional, objetivos independientes pueden comenzar en paralelo
- Diferentes objetivos pueden estudiarse simultáneamente si no tienen dependencia conceptual

---

## Estrategia de Estudio

### MVP Primero (Solo Objetivo 1)

1. Completar Fase 1: Preparación
2. Completar Fase 2: Fundacional (CRÍTICO)
3. Completar Fase 3: Objetivo 1
4. **DETENER y VALIDAR**: Verificar comprensión del Objetivo 1
5. Si aprobado, continuar con siguiente objetivo

### Repaso Espaciado

- Después de cada objetivo completado: programar repaso a 1 día, 3 días, 1 semana
- Usar flashcards/Anki para conceptos clave
- Intercalar práctica de objetivos anteriores con estudio nuevo

---

## Notas

- [P] tareas = sin dependencias conceptuales
- [Objetivo] etiqueta mapea tarea a objetivo específico para trazabilidad
- Cada objetivo debe ser completable y verificable de forma independiente
- Detenerse en cualquier punto de control para validar comprensión
- Evitar: estudio pasivo, lectura sin notas, avanzar sin verificar
