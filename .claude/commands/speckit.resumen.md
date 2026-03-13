---
description: Generar un resumen ejecutivo del tema de estudio consolidando todo el conocimiento adquirido.
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

1. Ejecutar `.specify/scripts/bash/check-prerequisites.sh --json --paths-only` desde la raíz del repo y parsear FEATURE_DIR.

2. **Cargar todos los artefactos disponibles**: spec.md, plan.md, research.md, data-model.md, tasks.md, quizzes existentes, notas existentes en el directorio `notas/`.

3. **Generar resumen ejecutivo** en `FEATURE_DIR/resumen-ejecutivo.md`:

   ```markdown
   # Resumen Ejecutivo: [NOMBRE DEL TEMA]
   **Fecha**: [FECHA]
   **Estado**: [En progreso / Completado]
   **Objetivos cubiertos**: [X de Y completados]

   ## Visión General
   [1-2 párrafos resumiendo el tema en lenguaje accesible]

   ## Conceptos Clave
   [Lista de los conceptos más importantes con definiciones concisas]
   - **[Concepto 1]**: [Definición en 1-2 oraciones]
   - **[Concepto 2]**: [Definición en 1-2 oraciones]

   ## Mapa Conceptual
   [Relaciones entre conceptos principales, formato texto o ASCII]

   ## Lo Que Aprendí
   [Resumen de comprensión por cada objetivo completado]
   ### Objetivo 1: [Título]
   - Comprensión alcanzada: [breve descripción]
   - Puntos clave: [lista de 3-5 insights]

   ## Fuentes Principales
   [Top 3-5 fuentes más valiosas con breve justificación de por qué]
   1. [Fuente] — [por qué fue valiosa]

   ## Áreas para Profundización
   [Temas que surgieron durante el estudio que merecen exploración futura]
   - [Tema 1]: [por qué es interesante/relevante]

   ## Conexiones con Otros Temas
   [Cómo se relaciona este tema con otros temas de estudio, incluyendo ramas existentes]

   ## Plan de Repaso
   [Calendario sugerido de repaso espaciado]
   - 1 día después: [qué repasar]
   - 1 semana después: [qué repasar]
   - 1 mes después: [qué repasar]
   ```

4. **Reportar**: Ruta del resumen, estado de completitud por objetivo, áreas sugeridas para profundización.
