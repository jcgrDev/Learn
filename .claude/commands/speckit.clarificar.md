---
description: Identificar áreas sub-especificadas en la spec del tema actual haciendo hasta 5 preguntas de clarificación dirigidas y codificando las respuestas en la spec.
agent: clarificador-agent
handoffs:
  - label: Crear Plan de Estudio
    agent: speckit.planificar
    prompt: Crear un plan para el tema. Quiero estudiar...
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

Meta: Detectar y reducir ambigüedades o puntos de decisión faltantes en la especificación activa del tema de estudio y registrar las clarificaciones directamente en el archivo spec.

Nota: Se espera que este flujo se ejecute ANTES de invocar `/speckit.planificar`.

Pasos de ejecución:

1. Ejecutar `.specify/scripts/bash/check-prerequisites.sh --json --paths-only` desde la raíz del repo **una vez**. Parsear campos JSON:
   - `FEATURE_DIR`
   - `FEATURE_SPEC`

2. Cargar el archivo spec actual. Realizar escaneo estructurado de ambigüedades usando esta taxonomía. Para cada categoría, marcar estado: Claro / Parcial / Faltante.

   Alcance y Objetivos:
   - Objetivos principales y criterios de éxito
   - Declaraciones explícitas de fuera-de-alcance
   - Nivel de profundidad esperado

   Prerequisitos:
   - Conocimientos previos necesarios
   - Nivel actual del estudiante
   - Brechas de prerequisitos identificadas

   Recursos y Formato:
   - Formato preferido (libro, video, curso, práctica)
   - Accesibilidad y costo de recursos
   - Idioma preferido de las fuentes

   Metodología de Estudio:
   - Tiempo disponible para el estudio
   - Estilo de aprendizaje preferido
   - Herramientas de estudio disponibles

   Verificación:
   - Criterios de éxito medibles
   - Forma de autoevaluación preferida
   - Nivel de dominio esperado

3. Generar (internamente) una cola priorizada de preguntas candidatas (máximo 5). NO mostrarlas todas a la vez. Cada pregunta debe ser respondible con selección múltiple (2-5 opciones) O respuesta corta (<=5 palabras).

4. Bucle de preguntas secuencial (interactivo):
    - Presentar EXACTAMENTE UNA pregunta a la vez
    - Para preguntas de opción múltiple:
       - **Analizar todas las opciones** y determinar la **más adecuada**
       - Presentar tu **opción recomendada** prominentemente con razonamiento claro
       - Formato: `**Recomendado:** Opción [X] - <razonamiento>`
    - Después de la respuesta del usuario:
       - Si responde "sí", "recomendado" o "sugerido", usar tu recomendación
       - De lo contrario, validar la respuesta
    - Dejar de preguntar cuando:
       - Todas las ambigüedades críticas resueltas, O
       - El usuario señala finalización ("listo", "bien", "no más"), O
       - Se alcanzan 5 preguntas

5. Integración después de CADA respuesta aceptada:
    - Asegurar que exista sección `## Clarificaciones` con sub-encabezado `### Sesión AAAA-MM-DD`
    - Agregar línea bullet: `- P: <pregunta> -> R: <respuesta final>`
    - Aplicar inmediatamente la clarificación a la(s) sección(es) apropiada(s)
    - Guardar archivo spec DESPUÉS de cada integración

6. Validación (después de CADA escritura):
   - Total de preguntas hechas <= 5
   - Secciones actualizadas no contienen marcadores vagos que la nueva respuesta debía resolver
   - Sin contradicciones con afirmaciones anteriores

7. Escribir spec actualizada de vuelta a `FEATURE_SPEC`.

8. Reportar finalización:
   - Número de preguntas hechas y respondidas
   - Ruta de la spec actualizada
   - Secciones tocadas
   - Tabla resumen de cobertura
   - Siguiente comando sugerido

Reglas de comportamiento:
- Si no se encuentran ambigüedades: responder "No se detectaron ambigüedades críticas." y sugerir proceder
- Si falta spec, instruir al usuario a ejecutar `/speckit.especificar` primero
- Nunca exceder 5 preguntas
- Respetar señales de terminación del usuario

Contexto para priorización: $ARGUMENTS
