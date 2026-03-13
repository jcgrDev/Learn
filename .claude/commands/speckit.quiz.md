---
description: Generar un quiz de autoevaluación basado en el material estudiado.
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

1. Ejecutar `.specify/scripts/bash/check-prerequisites.sh --json --paths-only` desde la raíz del repo y parsear FEATURE_DIR.

2. **Cargar contexto**: spec.md (objetivos), plan.md (nivel), research.md (fuentes), data-model.md (conceptos), tasks.md (progreso).

3. **Determinar alcance del quiz**:
   - Si `$ARGUMENTS` especifica un objetivo: quiz enfocado en ese objetivo
   - Si vacío: quiz comprensivo de todos los objetivos con tareas completadas [X]
   - Nivel de dificultad basado en el plan de estudio

4. **Crear directorio de quizzes** si no existe: `FEATURE_DIR/quizzes/`

5. **Generar quiz** en `FEATURE_DIR/quizzes/quiz-AAAA-MM-DD.md`:

   ```markdown
   # Quiz: [NOMBRE DEL TEMA]
   **Fecha**: [FECHA]
   **Alcance**: [Objetivos cubiertos]
   **Nivel**: [Introductorio/Intermedio/Avanzado]

   ## Sección 1: Conceptos Fundamentales (Opción Múltiple)

   **Q1.** [Pregunta sobre concepto clave]
   - A) [Opción]
   - B) [Opción]
   - C) [Opción]
   - D) [Opción]

   ## Sección 2: Comprensión (Respuesta Corta)

   **Q5.** Explica en tus propias palabras [concepto].

   ## Sección 3: Aplicación (Problemas)

   **Q8.** Dado [escenario], [pregunta de aplicación].

   ## Sección 4: Análisis (Pensamiento Crítico)

   **Q10.** Compara y contrasta [concepto A] con [concepto B].

   ---

   ## Respuestas

   <details>
   <summary>Ver respuestas</summary>

   **Q1.** C) [Explicación de por qué es correcta]
   **Q5.** [Respuesta modelo con puntos clave que debe incluir]
   **Q8.** [Solución paso a paso]
   **Q10.** [Respuesta modelo con criterios de comparación]

   </details>
   ```

6. **Reglas de generación**:
   - Mínimo 10 preguntas, máximo 25
   - Distribución: ~30% conceptos, ~30% comprensión, ~25% aplicación, ~15% análisis
   - Incluir SIEMPRE respuestas con explicación detallada
   - Basar preguntas en fuentes del research.md y conceptos del data-model.md
   - Evitar preguntas triviales o de memorización pura
   - Las preguntas de aplicación deben usar escenarios realistas
   - Las preguntas de análisis deben fomentar pensamiento crítico

7. **Evaluación interactiva** (opcional):
   - Si el usuario quiere responder el quiz en la sesión: presentar preguntas una a una
   - Evaluar respuestas y dar retroalimentación inmediata
   - Al final, calcular: % correcto por sección, áreas fuertes y débiles
   - Sugerir tareas de repaso para áreas débiles

8. **Reportar**: Ruta del quiz, número de preguntas por sección, objetivos cubiertos.
