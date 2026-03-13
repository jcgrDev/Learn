---
description: Generar un checklist personalizado para el tema actual basado en requisitos del usuario.
agent: autor-checklist-agent
---

## Propósito del Checklist: "Pruebas de Calidad para Plan de Estudio"

**CONCEPTO CRÍTICO**: Los checklists son **PRUEBAS UNITARIAS PARA LA ESPECIFICACIÓN DE ESTUDIO** - validan la calidad, claridad y completitud de los requisitos de aprendizaje en un dominio dado.

**NO son para verificación de estudio**:
- NO "Verificar que entendiste el concepto"
- NO "Probar que puedes resolver ejercicios"
- NO "Confirmar que leíste el libro"

**SÍ son para validación de calidad de la especificación**:
- "¿Están los prerequisitos identificados para todos los objetivos?" (completitud)
- "¿Está 'comprender bien' cuantificado con criterios específicos?" (claridad)
- "¿Son los criterios de éxito consistentes con los objetivos?" (consistencia)
- "¿Están las fuentes especificadas para cada objetivo?" (cobertura)
- "¿Define la spec qué sucede si los prerequisitos no se cumplen?" (casos límite)

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Pasos de Ejecución

1. **Configuración**: Ejecutar `.specify/scripts/bash/check-prerequisites.sh --json` desde la raíz del repo y parsear JSON para FEATURE_DIR y lista AVAILABLE_DOCS.

2. **Clarificar intención (dinámico)**: Derivar hasta TRES preguntas clarificadoras. DEBEN:
   - Generarse a partir de la redacción del usuario + señales de spec/plan/tasks
   - Solo preguntar sobre información que cambia materialmente el contenido
   - Omitirse individualmente si ya están claras en `$ARGUMENTS`

3. **Cargar contexto del tema**: Leer desde FEATURE_DIR: spec.md, plan.md (si existe), tasks.md (si existe)

4. **Generar checklist** - Crear "Pruebas Unitarias para Requisitos de Aprendizaje":
   - Crear directorio `FEATURE_DIR/checklists/` si no existe
   - Generar nombre de archivo descriptivo (ej., `objetivos.md`, `recursos.md`, `plan.md`)
   - Numerar ítems secuencialmente desde CHK001
   - Cada ejecución crea un NUEVO archivo

   **PATRONES PROHIBIDOS**:
   - Cualquier ítem que comience con "Verificar", "Probar", "Confirmar" + comportamiento de estudio
   - Referencias a ejecución de estudio, acciones del usuario

   **PATRONES REQUERIDOS**:
   - "¿Están [tipo de requisito] definidos/especificados para [escenario]?"
   - "¿Está [término vago] cuantificado con criterios específicos?"
   - "¿Son los requisitos consistentes entre [sección A] y [sección B]?"

5. **Referencia de Estructura**: Seguir plantilla en `.specify/templates/checklist-template.md`.

6. **Reportar**: Ruta del checklist, conteo de ítems.

## Tipos de Checklist de Ejemplo

**Calidad de Objetivos:** `objetivos.md`
- "¿Son los objetivos específicos y verificables? [Claridad, Spec §OA-1]"
- "¿Cada objetivo tiene criterios de comprensión definidos? [Completitud]"

**Calidad de Recursos:** `recursos.md`
- "¿Las fuentes son accesibles y apropiadas al nivel? [Realismo]"
- "¿Hay al menos una fuente primaria por objetivo? [Completitud]"

**Calidad de Plan:** `plan-estudio.md`
- "¿Los prerequisitos están cubiertos en la fase fundacional? [Completitud]"
- "¿El tiempo asignado es realista para el alcance? [Realismo]"
