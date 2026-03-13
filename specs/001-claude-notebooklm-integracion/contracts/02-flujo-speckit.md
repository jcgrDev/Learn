# Verificación: Objetivo 2 — Flujo de Trabajo SpecKit ↔ NotebookLM

**Objetivo**: Establecer un flujo de trabajo integrado entre comandos SpecKit y NotebookLM
**Prioridad**: P1

## Checklist de Verificación

### Subir Fuentes

- [x] Desde Claude Code, agregar una URL como fuente a un notebook (`source_add`)
  - ✅ Wikipedia: Wonderlic test agregada al notebook "Wonderlic test" (source_id: 5ef4b16c)
- [x] Verificar que la fuente aparece en el notebook
  - ✅ Fuente procesada y disponible para consultas

### Consultas con Citaciones

- [x] Hacer una consulta a un notebook con fuentes (`notebook_query`)
  - ✅ 3 consultas exitosas con conversación encadenada
- [x] La respuesta incluye citaciones de las fuentes subidas
  - ✅ 4, 18 y 34 citaciones respectivamente, referenciando múltiples fuentes
- [x] Las citaciones son verificables contra el material original
  - ✅ Comparación con `source_get_content`: "50 multiple choice questions in 12 minutes" coincide exactamente

### Integración con `/speckit.ingerir`

- [x] Documentado flujo complementario SpecKit + NotebookLM en `notas/notebooklm-guia.md`
  - SpecKit para estructura/planificación, NotebookLM para consultas con citaciones
- [x] Tabla comparativa de roles de cada herramienta agregada
- [x] Flujo recomendado cuando ambos tienen el mismo recurso documentado

## Ejercicio de Verificación

1. ✅ Recurso elegido: Wikipedia - Wonderlic test (URL pública)
2. ✅ Agregado al notebook "Wonderlic test" desde Claude Code
3. ✅ 3 preguntas realizadas con respuestas fundamentadas
4. ✅ Todas las respuestas citan correctamente las fuentes (con IDs verificables)
5. ✅ Contenido original verificado con `source_get_content` — sin alucinaciones

## Criterio de Éxito

✅ **COMPLETADO**: Se puede subir un recurso y recibir respuestas con citaciones verificables, todo desde Claude Code sin abrir el navegador.
