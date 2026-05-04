---
title: Instalación
layout: default
nav_order: 2
---

# Instalación
{: .no_toc }

## Tabla de contenidos
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Existen dos formas de instalar **newk**: mediante el **script automático** (recomendado) o **manualmente**, instalando cada dependencia por tu cuenta.

## Instalación mediante script (recomendada)

Descarga `install.sh` desde el repositorio y ejecútalo en un sistema **GNU/Trisquel** o de la familia **Debian/Ubuntu**. Puedes hacerlo en una máquina virtual si prefieres no tocar tu sistema principal.

```bash
wget https://raw.githubusercontent.com/naldoco/HaskellKatasLab/main/install/install.sh
chmod +x install.sh
./install.sh
```

{: .note }
> El script descarga e instala **todas** las dependencias listadas más abajo. Si prefieres tener control granular, sigue la instalación manual.

## Instalación manual

Necesitarás los siguientes elementos instalados.

### Haskell stack

[Documentación oficial](https://docs.haskellstack.org/en/stable/install_and_upgrade/)

```bash
wget -qO- https://get.haskellstack.org/ | sh
```

### git

```bash
sudo apt install git
```

### xdotool

Manipulación de ventanas X11 desde la línea de comandos.

```bash
sudo apt install xdotool
```

### wmctrl

Control de ventanas y escritorios.

```bash
sudo apt install wmctrl
```

### gnome-terminal

```bash
sudo apt install gnome-terminal
```

### inotify-tools

Necesario para que `newk` reaccione cuando guardas un archivo.

```bash
sudo apt install inotify-tools
```

### cdargs

Marcadores de directorios para Bash.

```bash
sudo apt install cdargs
```

### wget

```bash
sudo apt install wget
```

### emacs

El editor por defecto del entorno.

```bash
sudo apt install emacs
```

### xbindkeys

Para asociar atajos globales del teclado a comandos.

```bash
sudo apt install xbindkeys
xbindkeys --defaults > ~/.xbindkeysrc
gedit ~/.xbindkeysrc &
```

Añade la [configuración específica de atajos](atajos) y guarda el archivo. Después recarga `xbindkeys`:

```bash
killall -s1 xbindkeys ; xbindkeys -f ~/.xbindkeysrc
```

### meld

Herramienta visual de diff y merge.

```bash
sudo apt install meld
```

### pygmentize

[Cómo instalar Pygments en Ubuntu](https://stackoverflow.com/questions/26215738/how-to-install-pygments-on-ubuntu/56544663#56544663)

```bash
sudo apt-get install python3-pygments
```

### PCRE

Expresiones regulares compatibles con Perl.

```bash
sudo apt-get install libpcre3 libpcre3-dev
```

---

## Siguientes pasos

Con todo instalado, continúa con la página de [**Uso**](uso) para arrancar tu primera kata.
