---
title: Atajos de teclado
layout: default
nav_order: 4
---

# Atajos de teclado
{: .no_toc }

## Tabla de contenidos
{: .no_toc .text-delta }

1. TOC
{:toc}

---

`newk` apoya su flujo en **atajos globales** gestionados por [`xbindkeys`](https://www.linux.com/news/start-programs-pro-xbindkeys). Estos atajos te permiten saltar entre las ventanas del entorno (editor, REPL, watcher, diff, navegador) sin perder el foco mental.

## Configuración de `~/.xbindkeysrc`

Añade el siguiente bloque a tu `~/.xbindkeysrc` y recarga con `killall -s1 xbindkeys ; xbindkeys -f ~/.xbindkeysrc`.

```
## Atajos de newk
#
# Terminal "padre" desde la que se lanzó la kata
"newk -p"
  shift+alt + p

# Cerrar el entorno de la kata (ventanas principales)
"newk -q"
  shift+alt + q

# Mostrar la terminal inicial de HaskellKatas
"wmctrl -a 'HaskellKatas'"
  shift+alt + 0

# Mostrar la ventana de "stack ghci"
"wmctrl -a 'stack ghci' ; wmctrl -a 'git diff' ; sleep 0.2 ; xdotool key alt+1"
  shift+alt + 1

# Mostrar la ventana de "git diff"
"wmctrl -a 'git diff' ; wmctrl -a 'stack ghci' ; sleep 0.2 ; xdotool key alt+2"
  shift+alt + 2

# Mostrar la ventana de "stack build"
"wmctrl -a 'stack build'"
  shift+alt + 3

# Mostrar la ventana "Command - git"
"wmctrl -a 'Command - git'"
  shift+alt + 4

# Mostrar la ventana del editor (emacs)
"wmctrl -a 'KATA: '"
  shift+alt + 5

# Mostrar la ventana de Firefox: 'Solutions | Codewars - Mozilla Firefox'
"wmctrl -a '| Codewars - Mozilla Firefox'"
  shift+alt + 6

# Mostrar la ventana de Chromium: 'Codewars - Chromium'
"wmctrl -a '| Codewars - Chromium'"
  shift+alt + 7
```

## Resumen visual

| Atajo | Acción |
|---|---|
| `Shift + Alt + P` | Trae al frente la terminal **padre** de la kata |
| `Shift + Alt + Q` | **Cerrar** el entorno de la kata |
| `Shift + Alt + 0` | Terminal inicial de **HaskellKatas** |
| `Shift + Alt + 1` | REPL `stack ghci` |
| `Shift + Alt + 2` | `git diff` |
| `Shift + Alt + 3` | `stack build` (watcher) |
| `Shift + Alt + 4` | Ventana de comandos `git` |
| `Shift + Alt + 5` | Editor (`emacs`) sobre el archivo de la kata |
| `Shift + Alt + 6` | Codewars en **Firefox** |
| `Shift + Alt + 7` | Codewars en **Chromium** |

{: .note }
> Si tu entorno de escritorio captura alguna combinación `Shift+Alt+N`, tendrás que liberarla en los ajustes del sistema (por ejemplo, en GNOME: *Settings → Keyboard → Keyboard Shortcuts*).
