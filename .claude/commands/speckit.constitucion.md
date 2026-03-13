---
description: Crear o actualizar la constitución del proyecto de aprendizaje a partir de entradas interactivas o proporcionadas, asegurando que todas las plantillas dependientes se mantengan sincronizadas.
handoffs:
  - label: Crear Especificación
    agent: speckit.especificar
    prompt: Implementar la especificación del tema. Quiero estudiar...
---

## Entrada del Usuario

```text
$ARGUMENTS
```

**DEBES** considerar la entrada del usuario antes de proceder (si no está vacía).

## Esquema

Estás actualizando la constitución del proyecto en `.specify/memory/constitution.md`. Este archivo puede contener tokens de marcador de posición entre corchetes. Tu trabajo es (a) recopilar/derivar valores concretos, (b) llenar la plantilla con precisión, y (c) propagar cualquier enmienda a artefactos dependientes.

**Nota**: Si `.specify/memory/constitution.md` no existe, copiar desde `.specify/templates/constitution-template.md`.

Seguir este flujo de ejecución:

1. Cargar la constitución existente en `.specify/memory/constitution.md`.
   - Identificar cada token de marcador de la forma `[IDENTIFICADOR_EN_MAYÚSCULAS]`.
   **IMPORTANTE**: El usuario puede requerir menos o más principios que los de la plantilla.

2. Recopilar/derivar valores para marcadores:
   - Si la entrada del usuario proporciona un valor, usarlo.
   - En su defecto, inferir del contexto existente del repo.
   - Para fechas: `FECHA_RATIFICACIÓN` es la fecha de adopción original, `FECHA_ÚLTIMA_ENMIENDA` es hoy.
   - `VERSIÓN_CONSTITUCIÓN` debe incrementarse según versionamiento semántico.

3. Redactar contenido actualizado:
   - Reemplazar cada marcador con texto concreto
   - Preservar jerarquía de encabezados
   - Asegurar que cada Principio tenga: nombre, reglas, justificación

4. Lista de verificación de propagación de consistencia:
   - Leer `.specify/templates/plan-template.md` y asegurar alineación
   - Leer `.specify/templates/spec-template.md` para alineación
   - Leer `.specify/templates/tasks-template.md` y asegurar consistencia

5. Producir un Informe de Impacto de Sincronización:
   - Cambio de versión: antigua -> nueva
   - Lista de principios modificados
   - Plantillas que requieren actualizaciones

6. Validación antes de salida final:
   - Sin tokens de corchetes sin resolver
   - Línea de versión coincide con el informe
   - Fechas en formato ISO AAAA-MM-DD
   - Principios son declarativos, verificables

7. Escribir la constitución completada de vuelta a `.specify/memory/constitution.md`.

8. Resumen final al usuario con:
   - Nueva versión y justificación del cambio
   - Archivos señalados para seguimiento manual
   - Mensaje de commit sugerido
