---
description: Generar un tasks.md accionable y ordenado por dependencias para el tema basado en los artefactos de diseño disponibles.
agent: descomponedor-tareas-agent
handoffs:
  - label: Analizar Consistencia
    agent: speckit.analizar
    prompt: Ejecutar análisis de consistencia del proyecto
    send: true
  - label: Implementar Estudio
    agent: speckit.implementar
    prompt: Comenzar el estudio en fases
    send: true
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

1. **Configuración**: Ejecutar `.specify/scripts/bash/check-prerequisites.sh --json` desde la raíz del repo y parsear FEATURE_DIR y lista AVAILABLE_DOCS. Todas las rutas deben ser absolutas.

2. **Cargar documentos de diseño**: Leer desde FEATURE_DIR:
   - **Requerido**: plan.md (contexto, recursos, estructura), spec.md (objetivos con prioridades)
   - **Opcional**: data-model.md (mapa conceptual), contracts/ (ejercicios), research.md (recursos), quickstart.md

3. **Ejecutar flujo de generación de tareas**:
   - Cargar plan.md y extraer contexto de aprendizaje, recursos, estructura
   - Cargar spec.md y extraer objetivos con sus prioridades (P1, P2, P3, etc.)
   - Si data-model.md existe: Extraer conceptos y mapear a objetivos
   - Si research.md existe: Extraer recursos para tareas de estudio
   - Generar tareas organizadas por objetivo de aprendizaje
   - Generar grafo de dependencias
   - Validar completitud

4. **Generar tasks.md**: Usar `.specify/templates/tasks-template.md` como estructura.

5. **Reportar**: Ruta a tasks.md, conteo de tareas, alcance MVP sugerido.

Contexto para generación de tareas: $ARGUMENTS

## Reglas de Generación de Tareas

**CRÍTICO**: Las tareas DEBEN organizarse por objetivo de aprendizaje para permitir estudio y verificación independientes.

### Formato de Checklist (REQUERIDO)

```text
- [ ] [IDTarea] [P?] [Objetivo?] Descripción con ruta de archivo/recurso
```

**Componentes del Formato**:

1. **Checkbox**: SIEMPRE comenzar con `- [ ]`
2. **ID de Tarea**: Número secuencial (T001, T002, T003...)
3. **Marcador [P]**: SOLO si la tarea es paralelizable
4. **Etiqueta [Objetivo]**: REQUERIDA para tareas de fase de objetivos
   - Formato: [OA1], [OA2], [OA3], etc.
5. **Descripción**: Acción clara con ruta de archivo/recurso

### Estructura de Fases

- **Fase 1**: Preparación (configurar ambiente de estudio)
- **Fase 2**: Fundacional (prerequisitos bloqueantes - DEBEN completarse antes de objetivos)
- **Fase 3+**: Objetivos en orden de prioridad (P1, P2, P3...)
  - Dentro de cada objetivo: Lectura -> Notas activas -> Ejercicios -> Verificación (Feynman/Quiz)
  - Cada fase debe ser verificable independientemente
- **Fase Final**: Integración y Consolidación (resumen, mapa integrado, repaso espaciado)
