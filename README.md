# Implementación de patrones de diseño en una aplicación móvil

El sistema es una aplicación de banca móvil que permite a los usuarios consultar su saldo, transferir fondos y ver su historial de transacciones. Los usuarios interactúan con la aplicación a través de una interfaz de usuario que muestra los detalles de la cuenta y permite la entrada de datos para realizar transferencias. El sistema debe ser robusto, escalable y mantener un alto nivel de seguridad y confiabilidad. Los actores involucrados son el usuario, el sistema de banca móvil y el backend de la banca. Las propiedades operativas incluyen latencia máxima de 2 segundos para consultas de saldo, idempotencia de transferencias por número de operación y canal, y un umbral de tolerancia a fallos del 99.9%.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Técnicas de patrones de diseño mobile |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 40 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Identificación de patrones de diseño necesarios

**Objetivo:** Determinar los patrones de diseño adecuados para la solución del problema.

**Tiempo estimado:** 8 horas

**Instrucciones:**

- Analiza el sistema de banca móvil y enumera los patrones de diseño que se pueden aplicar para mejorar su estructura y funcionalidad.
- Considera patrones como Singleton, Factory, Observer, Strategy y Command, y cómo cada uno puede ser útil en diferentes partes del sistema.

**Entregable:** Lista de patrones de diseño con una breve descripción de cómo se aplicarán en el sistema.

<details>
<summary>Pistas de conocimiento</summary>

- Piensa en cómo cada patrón puede resolver problemas específicos en el dominio de la banca móvil.
- Considera la escalabilidad y la mantenibilidad del código al elegir los patrones.

</details>

### Fase 2: Implementación de patrones de diseño en el código

**Objetivo:** Aplicar los patrones de diseño identificados en la implementación del código.

**Tiempo estimado:** 24 horas

**Instrucciones:**

- Implementa el código de la aplicación de banca móvil utilizando los patrones de diseño elegidos en la fase anterior.
- Asegúrate de que el código respete los patrones de diseño y que cada patrón se aplique según la circunstancia a resolver.

**Entregable:** Código fuente de la aplicación de banca móvil con los patrones de diseño implementados.

<details>
<summary>Pistas de conocimiento</summary>

- Revisa la documentación de los patrones de diseño para asegurarte de que estás implementándolos correctamente.
- Prueba el código para verificar que los patrones de diseño están funcionando como se espera.

</details>

### Fase 3: Evaluación y mejora del código

**Objetivo:** Evaluar la implementación de los patrones de diseño y realizar mejoras necesarias.

**Tiempo estimado:** 8 horas

**Instrucciones:**

- Evalúa el código implementado en la fase anterior y realiza las mejoras necesarias para asegurar que los patrones de diseño se están aplicando correctamente y que el código es robusto, escalable y mantiene un alto nivel de seguridad y confiabilidad.
- Documenta las mejoras realizadas y justifica las decisiones tomadas.

**Entregable:** Código fuente mejorado de la aplicación de banca móvil con documentación de las mejoras realizadas.

<details>
<summary>Pistas de conocimiento</summary>

- Considera los trade-offs y las decisiones de diseño tomadas durante la implementación.
- Piensa en cómo puedes mejorar la calidad del código y la aplicación de los patrones de diseño.

</details>

## Dimensiones Evaluadas

- **queEs**: En la fase 1, ¿qué es un patrón de diseño y por qué son importantes en el desarrollo de software?
- **paraQueSirve**: En la fase 1, ¿para qué sirve cada patrón de diseño identificado en el sistema de banca móvil?
- **comoSeUsa**: En la fase 2, ¿cómo se usa el patrón Singleton para gestionar la creación de objetos en la aplicación?
- **erroresComunes**: En la fase 2, ¿cuáles son los errores comunes al implementar el patrón Factory y cómo se pueden evitar?
- **queDecisionesImplica**: En la fase 3, ¿qué decisiones implica la evaluación y mejora del código con respecto a la aplicación de los patrones de diseño?

## Criterios de Evaluacion

- Identificar los patrones de diseño adecuados para el sistema de banca móvil.
- Implementar el código utilizando los patrones de diseño elegidos.
- Evaluar y mejorar el código para asegurar que los patrones de diseño se están aplicando correctamente.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
flutter pub get && flutter analyze
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
