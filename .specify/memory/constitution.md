# Constitución del Proyecto de Aprendizaje

## Principios Fundamentales

### I. Comprensión Profunda sobre Memorización

El aprendizaje DEBE priorizar la comprensión conceptual sobre la memorización mecánica. Los conceptos DEBEN conectarse con conocimiento previo y con aplicaciones prácticas. Se DEBE buscar entender el "por qué" detrás de cada concepto, no solo el "qué". La explicación en palabras propias (técnica Feynman) es el estándar de verificación de comprensión.

**Justificación**: La retención a largo plazo y la capacidad de aplicar conocimiento en contextos nuevos dependen de la comprensión profunda, no de la repetición.

### II. Fuentes Verificables y de Calidad

Las fuentes de estudio DEBEN provenir de textos reconocidos, publicaciones académicas o recursos de instituciones acreditadas. Se DEBEN contrastar múltiples fuentes para conceptos complejos o controvertidos. Las afirmaciones DEBEN estar respaldadas por referencias verificables. Los agentes DEBEN usar activamente PubMed, WebSearch y WebFetch para fundamentar el contenido con fuentes reales.

**Justificación**: El aprendizaje basado en fuentes no verificadas puede crear modelos mentales incorrectos difíciles de corregir posteriormente.

### III. Aprendizaje Activo (NO NEGOCIABLE)

El estudio DEBE incluir ejercicios prácticos, preguntas de autoevaluación y aplicación de conceptos. La lectura pasiva NO es suficiente — se DEBEN generar quizzes, resúmenes y ejercicios. Se DEBE usar recuperación activa (active recall) como método principal de estudio. La repetición espaciada DEBE guiar el calendario de repaso.

**Justificación**: La investigación en ciencias del aprendizaje demuestra consistentemente que la práctica activa supera a la revisión pasiva en retención y transferencia.

### IV. Progresión Estructurada

Cada tema DEBE seguir una progresión lógica de lo fundamental a lo avanzado. Los prerequisitos DEBEN identificarse y cubrirse antes de avanzar. Se DEBE establecer un mapa conceptual que muestre las dependencias entre temas. El avance DEBE ser verificable mediante criterios de comprensión claros.

**Justificación**: Intentar aprender conceptos avanzados sin fundamentos sólidos genera frustración y comprensión superficial.

### V. Honestidad Intelectual

Se DEBE reconocer explícitamente lo que NO se entiende. Las lagunas de conocimiento DEBEN documentarse, no ocultarse. Las fuentes DEBEN citarse correctamente. No se DEBEN fabricar referencias ni inventar datos. Si no se encuentra evidencia, declararlo explícitamente.

**Justificación**: La honestidad sobre las propias limitaciones es prerequisito para el aprendizaje efectivo y la integridad académica.

### VI. Aplicación y Transferencia

El aprendizaje DEBE incluir ejemplos de aplicación en contextos reales. Se DEBEN buscar conexiones entre el tema de estudio y otros dominios. Los proyectos prácticos DEBEN acompañar el estudio teórico cuando sea posible. La capacidad de enseñar el concepto a otros es el nivel más alto de comprensión.

**Justificación**: El conocimiento que no se puede aplicar ni transferir tiene valor limitado. La aplicación consolida y profundiza la comprensión.

### VII. Alcance Realista y Sostenible

El alcance de cada tema DEBE ser realista para el tiempo y energía disponibles. Los objetivos DEBEN ser específicos, medibles y temporales. Se DEBE priorizar profundidad sobre amplitud. Las sesiones de estudio DEBEN respetar los límites de la atención sostenida.

**Justificación**: El aprendizaje sostenible produce mejores resultados que las maratones intensivas seguidas de abandono.

## Modelo de Trabajo: Rama por Tema de Estudio

Este repositorio alberga **múltiples temas de estudio independientes**, cada uno en su propia rama de Git. No existe un tema fijo — cada rama (`###-nombre-tema`) es un proyecto de aprendizaje autónomo.

**Reglas del modelo**:
- Cada tema vive en una rama independiente: `###-nombre-corto`
- La rama `main` contiene solo la infraestructura compartida (plantillas, agentes, constitución)
- Cada rama tiene su propio ciclo completo: especificar -> clarificar -> planificar -> tareas -> implementar
- Los temas NO comparten notas entre ramas salvo referencia cruzada explícita
- Un tema puede generar múltiples productos (notas, quizzes, resúmenes, proyectos)

## Roles del Proyecto

| Rol | Objetivos Principales | Responsabilidades Clave |
|-----|----------------------|------------------------|
| Estudiante | Aprender, practicar y dominar temas | Definir temas, estudiar activamente, completar ejercicios |
| Tutor (Agente) | Guiar el aprendizaje y evaluar comprensión | Explicar conceptos, generar ejercicios, dar retroalimentación |
| Curador (Agente) | Organizar y estructurar el material | Seleccionar fuentes, crear mapas conceptuales, estructurar contenido |

## Glosario del Dominio

- **Tema**: Proyecto de aprendizaje autónomo con objetivos y plan propios
- **Rama**: Branch de Git que contiene un tema de estudio completo
- **Spec**: Especificación formal de un tema (objetivos, alcance, prerequisitos)
- **Mapa Conceptual**: Representación visual de las relaciones entre conceptos
- **Active Recall**: Técnica de recuperación activa de información de la memoria
- **Repetición Espaciada**: Revisión de material a intervalos crecientes
- **Técnica Feynman**: Explicar un concepto en palabras propias como prueba de comprensión
- **Quiz**: Evaluación de autoevaluación sobre el material estudiado

## Flujo de Trabajo

- Los temas DEBEN seguir el patrón de rama: `###-descripcion-corta`
- Cada tema DEBE tener una especificación en `specs/###-nombre/spec.md` antes de comenzar
- Las especificaciones DEBEN definir prerequisitos y objetivos de aprendizaje
- El flujo completo por tema: `/speckit.especificar` -> `/speckit.clarificar` -> `/speckit.planificar` -> `/speckit.tareas` -> `/speckit.implementar`
- Los agentes DEBEN usar PubMed y WebSearch para fundamentar contenido con fuentes verificables
- Formato de citación: **APA 7** en todo el repositorio

## Gobernanza

Esta constitución tiene precedencia sobre todas las demás prácticas del proyecto. En caso de conflicto, este documento prevalece.

**Procedimiento de enmienda**:
1. Documentar el cambio propuesto a `.specify/memory/constitution.md`
2. Indicar el tipo de cambio de versión (MAYOR / MENOR / PARCHE) y la justificación
3. Revisar impacto en plantillas dependientes antes de aplicar

**Política de versionamiento**:
- MAYOR: Eliminación o redefinición incompatible de un principio existente
- MENOR: Nuevo principio o sección agregada
- PARCHE: Clarificaciones, correcciones de redacción

**Versión**: 1.0.0 | **Ratificada**: 2026-03-13 | **Última Enmienda**: 2026-03-13
