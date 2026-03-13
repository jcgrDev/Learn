# Ejemplos del Orquestador

## Ejemplo 1: Inicio de tema de estudio

**Entrada**: "Quiero aprender cálculo diferencial desde cero"

**Salida**:
```
-> Ruta: /speckit.especificar

Tu intención es definir un nuevo tema de estudio. Iniciando con la especificación vía el Agente Definidor de Tema.

Ejecutar: /speckit.especificar Quiero aprender cálculo diferencial desde cero
```

## Ejemplo 2: Enrutamiento a mitad de flujo

**Entrada**: "Tengo un plan de estudio pero no estoy seguro de que cubra todo lo necesario"

**Salida**:
```
-> Ruta: /speckit.checklist

Tu plan existe pero necesita validación de calidad. Enrutando al Agente Autor de Checklist para generar verificaciones de cobertura.

Ejecutar: /speckit.checklist
```

## Ejemplo 3: Intención ambigua multi-fase

**Entrada**: "Quiero planificar y también empezar a estudiar"

**Salida**:
```
Pregunta clarificadora: ¿Ya tienes un plan de estudio, o necesitas crearlo primero?

(a) Necesito crear un plan primero -> /speckit.planificar
(b) El plan existe; necesito descomponerlo en tareas -> /speckit.tareas
```

## Ejemplo 4: Búsqueda de recursos

**Entrada**: "Necesito encontrar los mejores libros sobre teoría de grafos"

**Salida**:
```
-> Agente: investigador-agent

Tu intención es buscar recursos de estudio. Enrutando al Agente Investigador de Fuentes para compilar materiales sobre el tema.
```

## Ejemplo 5: Autoevaluación

**Entrada**: "Quiero ver cuánto entendí del objetivo 1"

**Salida**:
```
-> Ruta: /speckit.quiz

Tu intención es evaluar tu comprensión. Generando un quiz enfocado en el Objetivo 1.

Ejecutar: /speckit.quiz objetivo 1
```

## Ejemplo 6: Ingestión de recurso

**Entrada**: "Quiero estudiar este PDF que tengo sobre estadística"

**Salida**:
```
-> Ruta: /speckit.ingerir

Tu intención es incorporar un recurso al flujo de estudio. Iniciando ingestión para extraer conceptos clave.

Ejecutar: /speckit.ingerir [ruta del PDF]
```
