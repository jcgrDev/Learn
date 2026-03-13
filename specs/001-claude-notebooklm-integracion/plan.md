# Plan de Estudio: Integración Claude Code ↔ NotebookLM

**Rama**: `001-claude-notebooklm-integracion` | **Fecha**: 2026-03-13 | **Spec**: [spec.md](spec.md)
**Entrada**: Especificación del tema desde `/specs/001-claude-notebooklm-integracion/spec.md`
**Formato de Citación**: APA 7

**Nota**: Esta plantilla se completa con el comando `/speckit.planificar`. Ver `.specify/templates/plan-template.md` para el flujo de trabajo de ejecución.

## Resumen

Integrar NotebookLM con Claude Code mediante el MCP server `jacob-bd/notebooklm-mcp-cli` (Python/uv), configurándolo a nivel global para acceder a notebooks existentes y nuevos desde cualquier proyecto. El enfoque es 100% práctico: instalar, autenticar, conectar notebooks existentes, y establecer un flujo de trabajo con SpecKit.

## Contexto de Aprendizaje

**Nivel de Profundidad**: Práctico — configuración e integración (no teórico sobre MCP internals)
**Fuentes Principales**: Repositorio GitHub jacob-bd/notebooklm-mcp-cli, documentación CLI
**Herramientas de Estudio**: Claude Code, terminal, NotebookLM (cuenta existente con notebooks)
**Enfoque de Aprendizaje**: Práctico — hands-on setup y verificación por pasos
**Tiempo Disponible**: Sesión única de configuración + verificación
**Conocimientos Previos**: MCP en Claude Code (familiaridad básica), Python/uv (instalado), NotebookLM (uso previo con notebooks existentes)
**Tipo de Evaluación**: Verificación funcional — cada paso produce un resultado observable
**Limitaciones Conocidas**: El MCP server usa APIs internas no documentadas de Google; la autenticación por cookies puede expirar y requerir re-login periódico

## Verificación de Constitución

*COMPUERTA: Debe pasar antes del estudio de Fase 0. Re-verificar después del diseño de Fase 1.*

| Principio | Estado | Notas |
|-----------|--------|-------|
| I. Comprensión Profunda | ✅ Cumple | El plan busca entender cómo funciona la integración MCP, no solo ejecutar comandos |
| II. Fuentes Verificables | ✅ Cumple | Repositorio open-source con documentación y código fuente disponible |
| III. Aprendizaje Activo | ✅ Cumple | 100% práctico — cada objetivo se verifica haciendo |
| IV. Progresión Estructurada | ✅ Cumple | Instalación → Autenticación → Conexión → Flujo de trabajo |
| V. Honestidad Intelectual | ✅ Cumple | Limitaciones documentadas (APIs no oficiales, autenticación por cookies) |
| VI. Aplicación y Transferencia | ✅ Cumple | La integración se usa inmediatamente en el flujo SpecKit existente |
| VII. Alcance Realista | ✅ Cumple | 3 objetivos concretos, sin scope creep (Notion fuera del alcance) |

## Estructura del Proyecto

### Documentación (este tema)

```text
specs/001-claude-notebooklm-integracion/
├── plan.md              # Este archivo
├── research.md          # Evaluación de recursos (Fase 0)
├── data-model.md        # Mapa conceptual (Fase 1)
├── quickstart.md        # Guía rápida de inicio (Fase 1)
├── contracts/           # Plantillas de verificación (Fase 1)
│   ├── 01-instalacion.md
│   ├── 02-flujo-speckit.md
│   └── 03-gestion-notebooks.md
└── tasks.md             # Tareas de implementación (Fase 2)
```

### Estructura de Notas (raíz del repositorio)

```text
notas/
├── notebooklm-guia.md           # Guía existente — ACTUALIZAR con info MCP
└── notebooklm-mcp-setup.md      # Documentación de la configuración final
```

**Decisión de Estructura**: Estudio práctico de configuración. Las notas principales se actualizan en `notas/notebooklm-guia.md` (ya existente). No se necesita estructura nueva de notas porque el producto final es la configuración funcional, no material de estudio teórico.

## Seguimiento de Complejidad

> Sin violaciones de constitución detectadas. No se requiere justificación.
