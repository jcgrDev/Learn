# Tareas: Integración Claude Code ↔ NotebookLM

**Entrada**: Documentos de diseño desde `/specs/001-claude-notebooklm-integracion/`
**Prerequisitos**: plan.md ✅, spec.md ✅, research.md ✅, data-model.md ✅, quickstart.md ✅
**Organización**: Tareas agrupadas por objetivo de aprendizaje — cada uno verificable de forma independiente.

## Formato: `[ID] [P?] [Objetivo] Descripción`

- **[P]**: Puede hacerse en paralelo (sin dependencias)
- **[OAn]**: Objetivo de aprendizaje al que pertenece la tarea

---

## Fase 1: Preparación

**Propósito**: Revisar documentación y entender qué se va a instalar antes de ejecutar comandos.

- [x] T001 [P] Leer `specs/001-claude-notebooklm-integracion/quickstart.md` — visión general del proceso
- [x] T002 [P] Leer `specs/001-claude-notebooklm-integracion/research.md` — limitaciones de cookies y APIs no oficiales
- [x] T003 [P] Revisar `specs/001-claude-notebooklm-integracion/data-model.md` — entender el flujo Claude → MCP → NotebookLM
- [x] T004 Verificar que tienes acceso a notebooklm.google.com con tu cuenta de Google (confirmado: notebooks existentes)

**Punto de control**: Entiendes la arquitectura antes de instalar. ¿Puedes describir el flujo de datos sin mirar el diagrama?

---

## Fase 2: Fundacional (Prerequisitos técnicos)

**Propósito**: Verificar ambiente técnico. BLOQUEA todos los objetivos.

- [x] T005 Verificar que `uv` está disponible: `uv --version` → uv 0.10.7
- [x] T006 Verificar que Claude Code está funcionando: `claude --version` → 2.1.75
- [x] T007 [P] Verificar que tienes al menos un notebook existente en NotebookLM (confirmado por usuario en clarificación)

**Punto de control**: Ambiente listo — los 3 prerequsitos técnicos confirmados.

---

## Fase 3: Objetivo 1 — Instalación y Configuración Global (Prioridad: P1) MVP

**Meta**: `notebooklm-mcp-cli` instalado, autenticado y visible en `claude mcp list`

**Verificación Independiente**: Ejecutar `claude mcp list` desde cualquier directorio y ver el server activo.

### Instalación

- [x] T008 [OA1] Instalar el paquete: `uv tool install notebooklm-mcp-cli` → ya instalado
- [x] T009 [OA1] Verificar instalación: `nlm --version` → 0.3.15

### Autenticación

- [x] T010 [OA1] Iniciar sesión con Google: `nlm login` → ya autenticado (jcgrdev@gmail.com)
- [x] T011 [OA1] Verificar autenticación: `nlm login --check` → ✓ Authentication valid! 18 notebooks

### Configuración Global

- [x] T012 [OA1] Registrar en Claude Code (global): `nlm setup add claude-code` → ✓ Added (user scope)
- [x] T013 [OA1] Confirmar en config de Claude que aparece el MCP server → registrado internamente
- [x] T014 [OA1] Verificar: `claude mcp list` → notebooklm-mcp: ✓ Connected

### Verificación del Objetivo 1

- [x] T015 [OA1] Desde Claude Code, pedir: *"Lista mis notebooks de NotebookLM"* → 18 notebooks listados exitosamente
  - Usar la herramienta `notebook_list` del MCP
  - Resultado esperado: lista de tus notebooks existentes
- [x] T016 [OA1] Completar checklist `contracts/01-instalacion.md` → todos los checks ✅

**Punto de control**: MCP server activo y respondiendo. `claude mcp list` ✅

---

## Fase 4: Objetivo 2 — Flujo de Trabajo SpecKit ↔ NotebookLM (Prioridad: P1)

**Meta**: Subir una fuente, hacer una consulta con citaciones, y documentar el flujo integrado.

**Verificación Independiente**: Consulta con citaciones recibida desde Claude Code sin abrir el navegador.

**Depende de**: Fase 3 completa

### Subir una fuente de prueba

- [x] T017 [OA2] Elegir un recurso de prueba → Wikipedia: Wonderlic test (URL pública)
- [x] T018 [OA2] Desde Claude Code, agregar la fuente a un notebook existente usando `source_add`
  - ✅ Fuente agregada al notebook "Wonderlic test" (source_id: 5ef4b16c), procesada exitosamente

### Consultas con citaciones

- [x] T019 [OA2] Hacer 3 preguntas sobre el recurso subido usando `notebook_query`
  - ✅ 3 consultas exitosas con 4, 18 y 34 citaciones respectivamente
- [x] T020 [OA2] Comparar una respuesta con el contenido original — confirmar fidelidad (sin alucinaciones)
  - ✅ Wikipedia dice "50 multiple choice questions in 12 minutes" — coincide exactamente con la respuesta

### Integración con SpecKit

- [x] T021 [OA2] Documentar complementariedad SpecKit ↔ NotebookLM en `notas/notebooklm-guia.md`
  - ✅ Tabla comparativa + flujo recomendado cuando ambos tienen el mismo recurso
- [x] T022 [OA2] Completar checklist `contracts/02-flujo-speckit.md` → todos los checks ✅

**Punto de control**: Consultas fundamentadas funcionando. El flujo Claude → NotebookLM → citaciones está documentado.

---

## Fase 5: Objetivo 3 — Gestión de Notebooks Existentes (Prioridad: P2)

**Meta**: Listar, consultar y crear notebooks desde Claude Code sin abrir el navegador.

**Verificación Independiente**: Lista de notebooks y consulta exitosa sobre uno existente.

**Depende de**: Fase 3 completa (Fase 4 recomendada)

### Acceder a notebooks existentes

- [x] T023 [OA3] Listar todos los notebooks: `notebook_list` desde Claude Code → 18 notebooks
- [x] T024 [OA3] Seleccionar un notebook con fuentes previas y hacer una consulta
  - ✅ "Wonderlic test" consultado con 3 preguntas, respuestas fundamentadas en fuentes

### Organización

- [x] T025 [OA3] [P] Tags no disponibles en v0.3.15 — usar `alias` como alternativa
  - ✅ Alias "wonderlic" creado para notebook de prueba
- [x] T026 [OA3] Crear un notebook nuevo desde Claude Code: `notebook_create`
  - ✅ "001-claude-notebooklm-integracion" (64ff33b5) con 2 fuentes (GitHub + XDA)
- [x] T027 [OA3] Consultar el notebook recién creado y verificar respuesta
  - ✅ Respuesta con 6 citaciones sobre qué es notebooklm-mcp-cli
- [x] T028 [OA3] Completar checklist `contracts/03-gestion-notebooks.md` → todos los checks ✅

**Punto de control**: Biblioteca de notebooks gestionable desde Claude Code sin navegador.

---

## Fase 6: Integración y Documentación

**Propósito**: Consolidar el conocimiento y actualizar la documentación del proyecto.

- [x] T029 [P] Actualizar `notas/notebooklm-guia.md`:
  - ✅ Estado de integración: "manual" → "MCP disponible"
  - ✅ Sección de instalación con `notebooklm-mcp-cli` agregada
  - ✅ Flujo de trabajo actualizado (pasos [Manual] → [MCP])
  - ✅ Tabla de 35 herramientas MCP disponibles
  - ✅ Sección de limitaciones agregada
  - ✅ CLAUDE.md actualizado
- [x] T030 [P] Documentar problemas encontrados y soluciones en `notas/notebooklm-mcp-setup.md`
  - ✅ 3 problemas documentados: sesión MCP, tags ausentes, respuestas largas
- [x] T031 Verificar criterios de éxito finales desde `spec.md`:
  - CE-001: `claude mcp list` muestra el server ✅
  - CE-002: Notebook creado + 2 fuentes + consulta con citaciones ✅
  - CE-003: Flujo complementario SpecKit ↔ NotebookLM documentado ✅
  - CE-004: `notas/notebooklm-guia.md` actualizado ✅
  - CE-005: Config en `~/.claude/settings.json` global ✅

---

## Dependencias y Orden de Ejecución

### Dependencias entre Fases

- **Fase 1** (Preparación): Sin dependencias — comenzar aquí
- **Fase 2** (Fundacional): Depende de Fase 1 — BLOQUEA Fases 3-5
- **Fase 3** (OA1): Depende de Fase 2 — **MVP mínimo**
- **Fase 4** (OA2): Depende de Fase 3
- **Fase 5** (OA3): Depende de Fase 3 (puede hacerse en paralelo con Fase 4)
- **Fase 6** (Documentación): Depende de Fases 4 y 5

### Oportunidades de Paralelismo

```text
Fase 1 (T001, T002, T003, T004) → pueden ejecutarse en cualquier orden
Fase 5 (T025) → puede hacerse en paralelo con T023-T024
Fase 6 (T029, T030) → pueden hacerse en paralelo entre sí
```

---

## Estrategia de Estudio

### MVP Primero (Fases 1-3 solamente)

1. Fase 1: Preparación — leer docs (15 min)
2. Fase 2: Fundacional — verificar ambiente (5 min)
3. Fase 3: OA1 — instalar, autenticar, configurar (10-15 min)
4. **DETENER y VALIDAR**: `claude mcp list` muestra el server
5. Si funciona → continuar con Fase 4

### Troubleshooting

Si `nlm login` no abre navegador → usar `nlm login --manual`
Si el MCP no aparece en `claude mcp list` → ejecutar `nlm setup add claude-code` de nuevo
Si las cookies expiran → ejecutar `nlm login` para re-autenticar

---

## Notas

- [P] tareas = sin dependencias con otras tareas de la misma fase
- Este tema es 100% práctico — la "comprensión" se verifica haciendo
- Las APIs son no oficiales: si algo falla inesperadamente, revisar el repo para actualizaciones
- Re-autenticación periódica es normal — las cookies de Google expiran
