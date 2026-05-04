---
title: Uso
layout: default
nav_order: 3
---

# Uso de newk
{: .no_toc }

## Tabla de contenidos
{: .no_toc .text-delta }

1. TOC
{:toc}

---

`newk` es el script principal del proyecto. Su misión es **abrir y organizar todas las ventanas necesarias** para entrar en flujo y programar una kata: editor, REPL de Haskell, watcher de tests, ventana de `git diff`, navegador con el enunciado, etc.

## Lanzar una kata

Desde la terminal donde tienes disponible `newk` en el `PATH`:

```bash
newk
```

Esto crea (o reutiliza) un proyecto de Haskell vía `stack`, abre el editor sobre el archivo de la kata, lanza `stack ghci` en una ventana aparte, otra ventana con `stack build` en modo watch, y otra con `git diff` para que veas en tiempo real lo que vas cambiando.

## Comandos útiles

| Comando | Qué hace |
|---|---|
| `newk` | Crea/abre la kata y lanza el entorno completo. |
| `newk -p` | Trae al frente la **terminal "padre"** desde la que lanzaste la kata. |
| `newk -q` | Cierra el entorno de kata (todas las ventanas asociadas). |

## Flujo recomendado (TDD)

1. Lee el enunciado de la kata (en Codewars u otra fuente).
2. Escribe **un test que falle** que describa el comportamiento mínimo.
3. Guarda el archivo: el watcher ejecutará los tests automáticamente.
4. Escribe el **mínimo código** para que el test pase.
5. Refactoriza con la red de seguridad de los tests verdes.
6. Repite.

{: .note }
> El método HaskellKatas hace énfasis en la **repetición consciente**: la misma kata, varias veces, te enseña tanto como katas distintas. Buscar la solución más elegante es parte del entrenamiento.

## Configuración de atajos

Para sacarle todo el partido a `newk` necesitas tener configurados los **atajos de teclado** que cambian entre las ventanas del entorno. Consulta la página de [**Atajos**](atajos).

## Codewars

El método se complementa muy bien con las katas de [Codewars](https://www.codewars.com/). Te recomendamos:

- Filtrar por lenguaje **Haskell**.
- Empezar por kyu 8–7 si estás aprendiendo.
- Subir de dificultad cuando hayas resuelto la misma kata varias veces y de varias formas.
