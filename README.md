# newk
**newk** is free software. It's a bash script to set up and perform **Haskell programming katas** using **TDD** methodology, **git**, and other standard tools. We recommend using it in specific HaskellKatas hackathons and with the **Codewars**'s katas (https://www.codewars.com/).

The development of the newk application and its use will focus on the **GNU/Trisquel 11.0 "Aramo"** operating system, although we know that it can be installed directly on systems such as **Ubuntu** or **Debian**, and is easily portable to any other **GNU/Linux** system.


**HaskellKatas** is a self-driving method to practice programming. It's not (only) about solving problems, but to drill the use of katas into a deep understanding of programming, in other words, to learn through training and the pleasure of discovery by yourself.

![]() <a href="img/HaskellKatas_IDE.png" ><img src="img/HaskellKatas_IDE.png" alt="HaskellKatas IDE" width="640"></a>

# More info:

* **Mozilla Day (UAH):** Katas con Haskell para entrenamiento (Feb 2020) (https://www.meetup.com/es-ES/Haskell-MAD/events/268851383/)****
* **World.Party2K21:** Construye un entorno de Katas potente y flexible (Oct 2020) (https://youtu.be/v3Qg02xYsqw?t=420)

# Install (via script) (recommended)
Please, download **install.sh** from the repository and execute it on a GNU/Trisquel or a Debian/Ubuntu-like operating system. You can install it into a virtual machine.

   https://gitlab.com/HaskellKatas/katas--proof-of-concept/-/raw/master/install/install.sh?inline=false

# Install (by hand)

You should already have installed the following elements:

### Haskell stack

https://docs.haskellstack.org/en/stable/install_and_upgrade/

    wget -qO- https://get.haskellstack.org/ | sh

### git

https://linuxize.com/post/how-to-install-git-on-debian-9/

    sudo apt install git

### xdotool

https://www.howtoinstall.co/en/debian/stretch/xdotool

    sudo apt install xdotool

### wmctrl

https://en.wikipedia.org/wiki/Wmctrl

    sudo apt install wmctrl

### gnome-terminal

https://www.howtoinstall.co/en/debian/stretch/gnome-terminal

    sudo apt install gnome-terminal

### inotify-tools

https://www.howtoinstall.co/en/debian/stretch/inotify-tools

    sudo apt install inotify-tools

### cdargs

https://www.howtoinstall.co/en/debian/stretch/cdargs

    sudo apt install cdargs

### wget

https://www.howtoinstall.co/en/debian/stretch/wget

    sudo apt install wget

### emacs

https://www.howtoinstall.co/en/debian/stretch/emacs

    sudo apt install emacs

### xbindkeys

https://www.linux.com/news/start-programs-pro-xbindkeys

    sudo apt install xbindkeys

    xbindkeys --defaults > ~/.xbindkeysrc

    gedit ~/.xbindkeysrc &

(add specific configuration -see later-, and save file)

    killall -s1 xbindkeys ; xbindkeys -f ~/.xbindkeysrc

### meld

https://meldmerge.org

    sudo apt install meld

## pygmentize

https://stackoverflow.com/questions/26215738/how-to-install-pygments-on-ubuntu/56544663#56544663

    sudo apt-get install python3-pygments

## PCRE

https://www.cyberciti.biz/faq/debian-ubuntu-linux-install-libpcre3-dev/

    sudo apt-get install libpcre3 libpcre3-dev

#### Specific shortcuts configuration:

    ## newk shortcuts
    #
    #"Terminal window from which the kata was launched"
    "newk -p"
      shift+alt + p

    #"Quit kata environment (main windows)"
    "newk -q"
      shift+alt + q

    # Show Terminal initial window
    "wmctrl -a 'HaskellKatas'"
      shift+alt + 0

    # Show "stack ghci" window
    "wmctrl -a 'stack ghci' ; wmctrl -a 'git diff' ; sleep 0.2 ; xdotool key alt+1"
      shift+alt + 1

    # Show "git diff" window
    "wmctrl -a 'git diff' ; wmctrl -a 'stack ghci' ; sleep 0.2 ; xdotool key alt+2"
      shift+alt + 2

    # Show "stack build" window
    "wmctrl -a 'stack build'"
      shift+alt + 3

    # Show "Command - git" window
    "wmctrl -a 'Command - git'"
      shift+alt + 4

    # Show editor window (emacs)
    "wmctrl -a 'KATA: '"
      shift+alt + 5

    # Show Firefox's window of title: 'Solutions | Codewars - Mozilla Firefox
    "wmctrl -a '| Codewars - Mozilla Firefox'"
      shift+alt + 6

    # Show Chromium's window of title: 'Codewars - Chromium'
    "wmctrl -a '| Codewars - Chromium'"
      shift+alt + 7

