# Tabla de Enrutamiento del Orquestador

| Señal de Intención del Usuario | Enruta A | Vía Comando |
|---|---|---|
| "aprender", "estudiar", "nuevo tema", "quiero entender" | `definidor-tema-agent` | `/speckit.especificar` |
| "clarificar", "ambigüedades", "poco claro", "preguntas" | `clarificador-agent` | `/speckit.clarificar` |
| "planificar", "plan de estudio", "organizar estudio" | `planificador-agent` | `/speckit.planificar` |
| "checklist", "validar plan", "calidad del plan" | `autor-checklist-agent` | `/speckit.checklist` |
| "tareas", "descomponer", "lista de tareas", "qué estudio" | `descomponedor-tareas-agent` | `/speckit.tareas` |
| "implementar", "comenzar estudio", "ejecutar plan" | (ejecución directa) | `/speckit.implementar` |
| "quiz", "autoevaluación", "evaluar comprensión" | (ejecución directa) | `/speckit.quiz` |
| "resumen", "resumir", "consolidar" | (ejecución directa) | `/speckit.resumen` |
| "ingerir", "leer libro", "procesar artículo" | (ejecución directa) | `/speckit.ingerir` |
| "revisar", "control de calidad", "verificar plan" | `revisor-agent` | (invocación directa) |
| "buscar recursos", "fuentes", "materiales" | `investigador-agent` | (invocación directa) |
| "analizar recurso", "comparar libros", "evaluar fuente" | `curador-contenido-agent` | (invocación directa) |
