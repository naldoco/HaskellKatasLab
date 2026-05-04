#!/bin/bash -i
##################################################################################
# install.sh   bash script to automate the installation of Haskell katas (newk)  #
#                                                                                #
# Copyright (c) 2023 Reynaldo Cordero, Mercedes Cordero                          #
##################################################################################

NEWK="newk"

INSTALL_STEP_BY_STEP=""
#INSTALL_STEP_BY_STEP="Yes"    # uncomment if you want a install "step by step"

U="\033[4m"  # underline ON
B="\033[1m"  # bold ON
B_="\033[0m"  # bold OFF  (every other mark is OFF too)

VERSION='v 0.32'

LOG="log.out"
ASCIINEMA_COMMAND="${B}asciinema rec --overwrite ${LOG} -c \"bash -i -c ${0}\"${B_}"

NAME=$(git config user.name 2>/dev/null)
EMAIL=$(git config user.email 2>/dev/null)
COPYRIGHT='Copyright (c) YOURNAME'
GITHUB_USERNAME='YOURUSERNAME'
CATEGORY='Educational'

# The next line is correctly commented. The RESOLVER variable will be dinamically set up later
#RESOLVER="lts-21.25"  # ghc-9.4.8 (Published on 2023-12-16) https://www.stackage.org/

TMP=$(mktemp -d "${TMPDIR:-/tmp/}$(basename "$0").XXXXXXXXXXXX")
cd "${TMP}" || (echo "** ERROR: cd **" ; exit 1)

####
# Install-Skip-Abort message
ISA="[Enter 'Y' or 'Return' to install,
       'n' to skip,
       'a' or Ctrl-C to abort]"

function yesOption()
{
  if [[ -z "${INSTALL_STEP_BY_STEP}" ]] ; then
    echo -n "-y"
  fi
}


function processYNAbort_es()
{
  echo -e "${ISA}"
  trap "exit 1" INT
  if [ "$*" == "" ]; then
    echo -n "[Y/n/(a)bort] "
    if [[ -n "${INSTALL_STEP_BY_STEP}" ]] ; then
      read -r answ
    else
      echo
      echo "==> Y"
      answ="Y"
    fi
    echo "################################################################################"
    if [ "${answ}" == "" ] || [ "${answ}" == "y" ] || [ "${answ}" == "Y" ]; then
      :
    elif [ "${answ}" == "a" ] || [ "${answ}" == "A" ] || [ "${answ}" == "n" ] || [ "${answ}" == "N" ] ; then
      exit 0
    else
      processYNAbort_es "$*"
    fi
  else
    echo "*** : ($*)?"
    echo -n "[Y/n/a] "
    if [[ -n "${INSTALL_STEP_BY_STEP}" ]] ; then
      read -r answ
    else
      echo
      echo "=> Y"
      answ="y"
    fi
    echo "################################################################################"
    if [ "${answ}" == "" ] || [ "${answ}" == "y" ] || [ "${answ}" == "Y" ]; then
      echo "$@"
      "$@"
    elif [ "${answ}" == "n" ] || [ "${answ}" == "N" ] ; then
      echo "Se salta este paso."
    elif [ "${answ}" == "a" ] || [ "${answ}" == "A" ] ; then
      exit 1
    else
      processYNAbort_es "$*"
    fi
  fi
}


## Mensajes de inicio
##
echo -e -n "

${B}Installation script to perform Haskell katas with the ${U}'${NEWK}' program${B_}${B}.${B_}

${U}${VERSION}${B_}.

https://gitlab.com/HaskellKatas/katas--proof-of-concept

Install and configure exclusively standard packages and the ${NEWK} script,
  all free software (FLOSS).

It consists of 22 steps, which are processed automatically whenever possible.

[press 'Return' to start the installation, or Ctrl-C to exit.] "

read -r
echo "################################################################################"


which asciinema >/dev/null 2>&1
if [ "$?" -ne 0 ] ; then
  echo -e "
${B}'asciinema'${B_} is NOT installed.
It is used to keep a log of the installation, which is highly recommended.
   as documentation and for diagnosis of installation problems."


## Install asciinema
## https://command-not-found.com/asciinema

  echo -e "
###################################
${B}0) Install asciinema${B_}  (To record the installation session, so you can revise it later)"

  if [[ -z "${INSTALL_STEP_BY_STEP}" ]] ; then
    INSTALL_STEP_BY_STEP="Yes"
    processYNAbort_es "sudo" "apt" "install" "asciinema"
    INSTALL_STEP_BY_STEP=""
  else
    processYNAbort_es "sudo" "apt" "install" "asciinema"
  fi
  echo
  which asciinema >/dev/null 2>&1
  if [ "$?" -eq 0 ] ; then
    echo
    echo -e "newly installed asciinema"
    echo -e "${B}If you want to use it (recommended)${B_} you must execute the following: "
    echo
    echo -e "${ASCIINEMA_COMMAND}"
    echo
    exit 1
  fi
fi

pgrep -x "asciinema" > /dev/null 2>&1
if [ "$?" -eq 0 ] ; then
  echo -e "
An installation log file is being recorded:

       ${B}${LOG}${B_}"
else
  which asciinema >/dev/null 2>&1
  if [ "$?" -eq 0 ] ; then
    echo -e "
${B}'asciinema'${B_} is currently installed."
  else
    echo -e "
${B}'asciinema'${B_} is NOT currently installed."
  fi
  echo -ne "
You can ${B}continue, without saving a log${B_}, by pressing the '${B}Return${B_}' key,
   or you can ${B}exit${B_} by pressing '${B}Ctrl-C${B_}' and execute.


${ASCIINEMA_COMMAND}

[press 'Return' to continue, or Ctrl-C to exit, and try again] "
  read -r ; echo "##################################################"
fi


## Update before starting to install
##
echo -e "
###################################
${B}1) Update your operating system ${B_} before beginning the installation"

processYNAbort_es "sudo" "apt" "update" "$(yesOption)"
processYNAbort_es "sudo" "apt" "upgrade" "$(yesOption)"


function getNameAndEmail()
{
  trap "exit 1" INT
  if [[ -n "${NAME}" ]] && [[ -n "${EMAIL}" ]] ; then
    echo
    echo "Those already provided will be used:"
    echo -e "First and last name: ${B}${NAME}${B_}"
    echo -e "Email address: ${B}${EMAIL}${B_}"
    echo
  else
    echo
    echo -n "First and last name: "
    read -r NAME
    echo
    echo -n "Email address: "
    read -r EMAIL
    if [[ -n "${NAME}" ]] && [[ -n "${EMAIL}" ]] ; then
      echo
      echo -e "First and last name: ${B}${NAME}${B_}"
      echo -e "Email address: ${B}${EMAIL}${B_}"
      echo "OK? [S/n]"
      echo -n "[Y/n/a] " ; read -r answ
      echo "################################################################################"
      if [ "${answ}" == "" ] || [ "${answ}" == "Y" ] || [ "${answ}" == "y" ]; then
        :
      elif [ "${answ}" == "A" ] || [ "${answ}" == "a" ]; then
        exit 1
      else
        echo "Please try again."
        NAME=""
        EMAIL=""
        getNameAndEmail
      fi
    else
      echo "Please try again."
      NAME=""
      EMAIL=""
      getNameAndEmail
    fi
  fi
}


function gitConfig()
{
  git config user.name >/dev/null 2>&1 && git config user.email >/dev/null 2>&1
  if [ "$?" -ne 0 ] ; then
    echo "
'git' needs your first and last name and your email address."
    getNameAndEmail

    git config --global user.name "${NAME}"
    git config --global user.email "${EMAIL}"
    git config user.name >/dev/null 2>&1
    if [ "$?" -ne 0 ] ; then
      echo "
'git' couldn't set up your name."
      echo
      gitConfig
    fi
    git config user.email >/dev/null 2>&1
    if [ "$?" -ne 0 ] ; then
      echo "
'git' couldn't set up your email address."
      echo
      gitConfig
    fi
  fi
}


## Install git
## https://command-not-found.com/git
## https://linuxize.com/post/how-to-install-git-on-debian-9/
echo -e "
###################################
${B}2) Install git${B_}  (version software control tools)
   and set a minimal configuration."

processYNAbort_es "sudo" "apt" "install" "git" "$(yesOption)"

gitConfig


# https://gitlab.com/HaskellKatas/katas--proof-of-concept
HK_BRANCH="master"
HK_SCHEME="https://"
HK_HOST="gitlab.com"
HK_USER="HaskellKatas"
HK_PATH="Katas--proof-of-concept"

function cloneRepo()
{
  REPO=${TMP}/${HK_PATH}

  git clone --branch=${HK_BRANCH} ${HK_SCHEME}${HK_HOST}/${HK_USER}/${HK_PATH}.git

  if [ "$?" -ne 0 ] ; then
    echo
    echo "Problem cloning the repository
  '${HK_SCHEME}${HK_HOST}/${HK_USER}/${HK_PATH}'
"
    exit 1
  fi
}


function updateProfile()
{
  grep '$HOME/bin'  ~/.profile >/dev/null 2>&1      # single quotes!
  if [ "$?" -ne 0 ] ; then
    if [[ ! ${PATH} =~ ${HOME}/bin ]] ; then
      NEWPATH='$HOME/bin:$PATH'      # single quotes!
      echo "" >> "${HOME}"/.profile
      echo $NEWPATH >> "${HOME}"/.profile

      echo "
The PATH system variable has been updated in the '.profile' file:
${NEWPATH}

When the installation is complete, log out for the new PATH to be effective.
"
    fi
  fi
  grep 'export PATH'  "${HOME}"/.profile >/dev/null 2>&1      # single quotes!
  if [ "$?" -ne 0 ] ; then
    echo "" >> "${HOME}"/.profile
    echo "export PATH" >> "${HOME}"/.profile

    echo "
'export PATH' added to file '.profile':

When the installation is complete, log out for the new PATH to be effective.
"
  fi
}


function _installscripts()
{
  BIN=~/bin
  NEWK2=${NEWK}-$(date +%Y-%m-%d-%H-%M-%S)
  cd "${REPO}" || (echo "** ERROR: cd **" ; exit 1)
  chmod +x ${NEWK}
  if [ -e ${BIN} ]; then
    if [ ! -d ${BIN} ]; then
      echo "
Unable to save '${NEWK}' in ${BIN}.

ls -l ${BIN}

"
      ls -l ${BIN}
      echo
      exit 1
    fi
  else
    mkdir ${BIN}
  fi
  if [ -e ${BIN}/${NEWK} ]; then
    if [ ! -f ${BIN}/${NEWK} ]; then
      echo "
Unable to save  ${NEWK} in ${BIN}.

ls -l ${BIN}/${NEWK}

"
      ls -l ${BIN}/${NEWK}
      echo
      exit 1
    else
      echo "
The current ${BIN}/${NEWK} will be renamed as ${BIN}/${NEWK2}
"
      mv "${BIN}/${NEWK}" "${BIN}/${NEWK2}"
    fi
  fi
  cp -i "${NEWK}" "${BIN}"
  echo "Current PATH:
${PATH}"
  echo "${PATH}" | grep "${BIN}:" || echo "${PATH}" | grep "${BIN}$"
  if [ "$?" -ne 0 ] ; then
    updateProfile
  fi
}


cloneRepo


## Install the ${NEWK} script
## https://gitlab.com/HaskellKatas/katas--proof-of-concept
echo -e "
###################################
${B}3) Install the '${NEWK}' program${B_} (bash script)
   into the '~/bin' folder and set up the PATH variable"

processYNAbort_es "_installscripts"


function _installEmacsConfig()
{
  DIR=~/.emacs.d/
  DIR2=~/.emacs.d-$(date +%Y-%m-%d-%H-%M-%S)/
  DIR3=${REPO}/config/editor/emacs/.emacs.d/
  if [ -d $DIR ]; then
    echo "
Do you want to replace your current emacs configuration with one that supports Haskell (haskell-mode + Dante) and newk?

The ${DIR} directory will be renamed to ${DIR2}.
"
    processYNAbort_es

    mv "${DIR}" "${DIR2}"
    if [ "$?" -ne 0 ] ; then
      echo "
Could not change name. Check the file (permissions issue?)
"
      ls -la ${DIR}
      echo
      exit 1
    fi
  fi
  echo cp -r "${DIR3}" "${DIR}"
  cp -r "${DIR3}" "${DIR}"
  if [ "$?" -ne 0 ] ; then
    echo "
Error updating emacs configuration (~/.emacs.d).
"
  else
    echo "
Emacs configuration updated (~/.emacs.d)."
  fi
}


## Install emacs
## https://command-not-found.com/emacs
## https://www.howtoinstall.co/en/debian/stretch/emacs
echo -e "
###################################
${B}4) Install emacs${B_}  (text editor)"

processYNAbort_es "sudo" "apt" "install" "emacs" "$(yesOption)"

echo -e "
###################################
${B}5) Install a HaskellKata-compliant emacs setup${B_}"

processYNAbort_es "_installEmacsConfig"


## Install xdotool
## https://command-not-found.com/xdotool
## https://www.howtoinstall.co/en/debian/stretch/xdotool
echo -e "
###################################
${B}6) Install xdotool${B_}  (simulate key presses or mouse clicks)"

processYNAbort_es "sudo" "apt" "install" "xdotool" "$(yesOption)"


function _installXresources()
{
  FILE=~/.Xresources
  FILE2=~/.Xresources-$(date +%Y-%m-%d-%H-%M-%S)
  FILE3=${REPO}/config/terminal/xterm/.Xresources
  if [ -f $FILE ]; then
    echo "
Do you want to replace the current xterm configuration with a new one?

(The existing ${FILE} will be renamed to ${FILE2}
and the new version will be copied in its place)
"
    processYNAbort_es

    mv "${FILE}" "${FILE2}"
    if [ "$?" -ne 0 ] ; then
      echo "
Could not change name. Check the file (permissions issue?)
"
      ls -la ${FILE}
      echo
      exit 1
    fi
  fi
  cp "${FILE3}" "${FILE}"
  if [ "$?" -ne 0 ] ; then
    echo "
Error updating xterm configuration (~/.Xresources).
"
  else
    echo "
Xterm configuration updated (~/.Xresources)."
  fi
  xrdb -merge ~/.Xresources
}


## Install xterm
## https://command-not-found.com/xterm
echo -e "
###################################
${B}7) Install xterm${B_}  (standard terminal emulator)"

processYNAbort_es "sudo" "apt" "install" "xterm" "$(yesOption)"


## Copy a configuration file for xterm and load it ~/.Xresources
##
echo -e "
###################################
${B}8) Copy a configuration file for xterm (Xresources)${B_} (font type and size)"

processYNAbort_es "_installXresources"


## Install DejaVu fonts
## https://linux-packages.com/search-page?p=dejavu&st=contain
echo -e "
###################################
${B}9) Install DejaVu fonts${B_}  (to use in the terminal shell)"

processYNAbort_es "sudo" "apt" "install" "fonts-dejavu-core" "$(yesOption)"


## Install inotify-tools
## https://command-not-found.com/inotifywait
## https://www.howtoinstall.co/en/debian/stretch/inotify-tools
echo -e "
###################################
${B}10) Install inotify-tools${B_}  (used to monitor and act upon filesystem events)"

processYNAbort_es "sudo" "apt" "install" "inotify-tools" "$(yesOption)"


## Install wmctrl
## https://command-not-found.com/wmctrl
## https://www.howtoinstall.co/en/debian/stretch/inotify-tools
echo -e "
###################################
${B}11) Install wmctrl${B_}  (interface to standard window management tasks)"

processYNAbort_es "sudo" "apt" "install" "wmctrl" "$(yesOption)"


## Install xclip
## https://command-not-found.com/xclip
echo -e "
###################################
${B}12) Install xclip${B_}  (command line interface to the X11 clipboard)"

processYNAbort_es "sudo" "apt" "install" "xclip" "$(yesOption)"


## Install meld
## https://command-not-found.com/meld
## https://www.howtoinstall.co/en/debian/stretch/meld
echo -e "
###################################
${B}13) Install meld${B_}  (graphical diff viewer and merge application)"

processYNAbort_es "sudo" "apt" "install" "meld" "$(yesOption)"


function _updateBashrc()
{
  grep 'cdargs-bash.sh'  ~/.bashrc >/dev/null 2>&1
  if [ "$?" -ne 0 ] ; then
    echo "source /usr/share/doc/cdargs/examples/cdargs-bash.sh" >> "${HOME}"/.bashrc
    echo "
Added to the '.bashrc' file the line: source /usr/share/doc/cdargs/examples/cdargs-bash.sh '

When the installation is complete, log out for the new PATH to be effective.
"
  fi
}


## Install cdargs
## https://command-not-found.com/cdargs
## https://www.howtoinstall.co/en/debian/stretch/cdargs
echo -e "
###################################
${B}14) Install cdargs${B_}  (directory bookmarks for quick navigation)"

processYNAbort_es "sudo" "apt" "install" "cdargs" "$(yesOption)"


## Set up cdargs
##
echo -e "
###################################
${B}15) Set up 'cdargs'${B_} commands in the .bashrc file for managing bookmarks."
processYNAbort_es "_updateBashrc"


function _installXbindkeysConfig()
{
  FILE=~/.xbindkeysrc
  FILE2=~/.xbindkeysrc-$(date +%Y-%m-%d-%H-%M-%S)
  FILE3=${REPO}/config/shortkeys/xbindkeys/.xbindkeysrc
  if [ -f $FILE ]; then
    echo "
Do you want to replace the current xbindkeys configuration with a new one?

(The existing ${FILE} will be renamed to ${FILE2}
and the new version will be copied in its place)
"
    processYNAbort_es

    mv "${FILE}" "${FILE2}"
    if [ "$?" -ne 0 ] ; then
      echo "
Could not change name. Check the file (permissions issue?)
"
      ls -la ${FILE}
      echo
      exit 1
    fi
  fi
  cp "${FILE3}" "${FILE}"
  if [ "$?" -ne 0 ] ; then
    echo "
Error updating xbindkeys configuration (~/.xbindkeysrc).
"
  else
    echo "
Xbindkeys configuration updated (~/.xbindkeysrc)."
  fi
  killall -s1 xbindkeys 2> /dev/null ; xbindkeys -f ~/.xbindkeysrc
}


## Install xbindkeys
## https://command-not-found.com/xbindkeys
## https://www.linux.com/news/start-programs-pro-xbindkeys
echo -e "
###################################
${B}16) Install xbindkeys${B_}  (create keyboard shortcuts to run shell commands)"

processYNAbort_es "sudo" "apt" "install" "xbindkeys" "$(yesOption)"


## Set up xbindkeys (~/.xbindkeysrc)
##
echo -e "
###################################
${B}17) Set up xbindkeys${B_}"

processYNAbort_es "_installXbindkeysConfig"


## Install pygmentize
## https://command-not-found.com/pygmentize
echo -e "
###################################
${B}18) Install pygmentize${B_}  (syntax highlight)"

processYNAbort_es "sudo" "apt" "install" "python3-pygments" "$(yesOption)"


## Install ghcup dependencies
## https://www.haskell.org/ghcup/install/
# zlib1g-dev is also needed
echo -e "
###################################
${B}19) Install ghcup${B_} dependencies (see: https://www.haskell.org/ghcup/install/)."
# "libffi6" was removed from the recommended list of dependences

processYNAbort_es "sudo" "apt" "install" \
"build-essential" "curl" "libffi-dev" "libgmp-dev" "libgmp10" "libncurses-dev" \
"libtinfo-dev" "zlib1g-dev" "$(yesOption)"


## Install PCRE, used by 'stack'
## https://pkgs.org/download/libpcre3
## apt-cache search pcre | grep -- -dev
echo -e "
###################################
${B}20) Install PCRE${B_}  (Perl Compatible Regular Expressions.
   This library is needed by 'stack' to prepare the Haskell environment)"

processYNAbort_es "sudo" "apt" "install" "libpcre3" "libpcre3-dev" "pkg-config" "$(yesOption)"


# How to install libtinfo-dev
# https://howtoinstall.co/en/libtinfo-dev
# Because an issue of hspec-core-2.9.7: cannot find -ltinfo
# ghc resolver=lts-20.8
echo -e "
###################################
${B}21) Install libtinfo-dev, zlib1g-dev, libsqlite3-dev (specific haskell libraries dependencies)${B_}
   This library is required for a specific -and temporary- issue)"

processYNAbort_es "sudo" "apt" "install" "libtinfo-dev" "zlib1g-dev" "libsqlite3-dev" "$(yesOption)"

## Install ghcup and stack
## https://docs.haskellstack.org/en/stable/install_and_upgrade/
##

function stackConfig()
{
  echo -e "
###################################
Configurando ~/.stack/config.yaml"
  if [ -s ~/.stack/config.yaml ]; then
    # The file is not-empty.
    < ~/.stack/config.yaml grep -zoP \
'templates:\n'\
'  params:\n'\
'#    author-name:\n'\
'#    author-email:\n'\
'#    copyright:\n'\
'#    github-username:\n'
    if [ "$?" -eq 0 ] ; then
      echo "
'stack' needs your first and last name and your email address."
      getNameAndEmail

      sed -i -z 's/'\
'templates:\n'\
'  params:\n'\
'#    author-name:\n'\
'#    author-email:\n'\
'#    copyright:\n'\
'#    github-username:/'\
'templates:\n\  params:\n'\
"    author-name: ${NAME}\n"\
"    author-email: ${EMAIL}\n"\
"    copyright: ${COPYRIGHT}\n"\
"    github-username: ${GITHUB_USERNAME}\n"\
"    category: ${CATEGORY}/" ~/.stack/config.yaml
    else
      echo"
You should verify that the values indicated with XXXXX
are correctly replaced in the ~/.stack/config.yaml file:

templates: 
  params:
    author-name: XXXXX
    author-email: XXXXX
    copyright: XXXXX
    github-username: XXXXX
    category: XXXXX

"
      echo "################################################################################"
    fi
  else
    # The file is empty.
      echo "
'stack' needs your first and last name and your email address."
    getNameAndEmail

    echo -e "templates:
  params:
    author-name: ${NAME}
    author-email: ${EMAIL}
    copyright: ${COPYRIGHT}
    github-username: ${GITHUB_USERNAME}
    category: ${CATEGORY}
" > ~/.stack/config.yaml
  fi
}


function _installGhcupStack()
{
  echo "**** GHCUP ****"

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
BOOTSTRAP_HASKELL_GHC_VERSION=recommended \
BOOTSTRAP_HASKELL_CABAL_VERSION=recommended \
BOOTSTRAP_HASKELL_INSTALL_STACK=1 \
BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
BOOTSTRAP_HASKELL_ADJUST_BASHRC=P \
GHCUP_CURL_OPTS="-k" sh     # GHCUP_CURL_OPTS="-k"  is not safe! (workaround)

}


echo -e "
###################################
${B}22) Install stack using ghcup${B_} (a tool to build and manage Haskell projects)

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
BOOTSTRAP_HASKELL_GHC_VERSION=recommended \
BOOTSTRAP_HASKELL_CABAL_VERSION=recommended \
BOOTSTRAP_HASKELL_INSTALL_STACK=1 \
BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
BOOTSTRAP_HASKELL_ADJUST_BASHRC=P \
GHCUP_CURL_OPTS=\"-k\" sh
"

processYNAbort_es "_installGhcupStack"

source ~/.ghcup/env # ghcup-env

~/.ghcup/bin/stack new dummy  > /dev/null 2>&1

stackConfig

function fetchDependenciesAndUpdateNewk()
{
# Find out te value of RESOLVER based on the version of ghc 
stackageData=$(curl https://www.stackage.org/ 2>/dev/null | grep published)
ghcVersion=$(~/.ghcup/bin/ghc --numeric-version)
v1='org\/'
v2='">'
RESOLVER=$(echo "${stackageData}" | grep "${ghcVersion}" | sed -e "s/.*${v1}//;s/${v2}.*//")
echo "******************************
ghc version: ${ghcVersion}
stack resolver: ${RESOLVER}
******************************"

echo "Update RESOLVER variable in ~/bin/newk"
sed -i 's/^RESOLVER=.*/RESOLVER='\""${RESOLVER}"\"'/' ~/bin/newk

#cd /tmp/ ; stack new helloworld new-template --resolver ${RESOLVER} \
# -p "author-email:value" \
# -p "author-name:value" \
# -p "category:value" \
# -p "copyright:value" \
# -p "github-username:value" \
# build ; cd helloworld ; stack test

LIB_L=helloworld
LIB_U=Helloworld

# https://docs.codewars.com/languages/haskell/
echo -e "${B}${LIB_U}${B_} LIB is being prepared."

# Create and update files to force a compilation and run tests:
cd "${TMP}" || (echo "** ERROR: cd **" ; exit 1)

~/.ghcup/bin/stack new "${LIB_L}" --resolver="${RESOLVER}"

cd "${TMP}/${LIB_L}" || (echo "** ERROR: cd **" ; exit 1)

# Make sure these ghc-options must be off: Wall and Wmissing-export-lists
sed -i \
's/- -Wall/#- -Wall/g; '\
's/- -Wmissing-export-lists/#- -Wmissing-export-lists/g' "package.yaml"

# https://stackoverflow.com/questions/5178828/how-to-replace-all-lines-between-two-points-and-subtitute-it-with-some-text-in-s

# - hspec-codewars # https://github.com/codewars/hspec-codewars
# - hspec-formatters-codewars # https://github.com/codewars/hspec-formatters-codewars
# https://docs.codewars.com/languages/haskell/
# Add dependencies for QuickCheck and hspec
sed -i '/^dependencies:/,/^- base >= 4.7 && < 5/'\
'c\dependencies:\n\- base >= 4.7 && < 5\n'\
'- array\n'\
'- bytestring\n'\
'- containers\n'\
'- heredoc\n'\
'- hscolour\n'\
'- polyparse\n'\
'- pretty-show\n'\
'- unordered-containers\n'\
'- Cabal\n'\
'- HUnit\n'\
'- QuickCheck\n'\
'- attoparsec\n'\
'- haskell-src-exts\n'\
'- hspec\n'\
'- hspec-attoparsec\n'\
'- hspec-contrib\n'\
'- hspec-megaparsec\n'\
'- HUnit-approx\n'\
'- lens\n'\
'- megaparsec\n'\
'- mtl\n'\
'- parsec\n'\
'- persistent\n'\
'- persistent-sqlite\n'\
'- persistent-template\n'\
'- random\n'\
'- regex-pcre\n'\
'- regex-posix\n'\
'- regex-tdfa\n'\
'- split\n'\
'- text\n'\
'- transformers\n'\
'- vector' "package.yaml"

# Add hspec-discover. Add five default extensions
sed -i '/^  source-dirs: src/,/^tests:'/\
'c\  source-dirs: src\n\nbuild-tools:\n- hspec-discover\n\n'\
'default-extensions:\n- InstanceSigs\n- TypeApplications\n'\
'- ScopedTypeVariables\n- GADTSyntax\n- PartialTypeSignatures\n\n'\
'- OverloadedStrings\n\n'\
'tests:' "package.yaml"

# Spec.hs:
cat > test/Spec.hs << EOF
{-# OPTIONS_GHC -F -pgmF hspec-discover #-}
EOF

# "${LIB_U}"Spec.hs:
cat > test/"${LIB_U}"Spec.hs << EOF
module ${LIB_U}Spec (main, spec) where

import Test.Hspec
import Test.QuickCheck

import ${LIB_U}

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "Basic tests" $ do
    it "___DUMMY___" $ do
      id 42 \`shouldBe\` 42
EOF

# Lastly we'll add some shell content for the project to compile:
cat > src/${LIB_U}.hs << EOF
module ${LIB_U} where

${LIB_L} :: undefined
${LIB_L}  = undefined
EOF

echo -e "
###################################
${B}We will now run 'stack test', which downloads the pending Haskell libraries, which can take quite a while.${B_}
"

sleep 2
~/.ghcup/bin/stack test
}


## Fetch haskell selected libraries at once
##
echo -e "
###################################
${B}We complete and test the installation of the Haskell build environment (stack).${B_}
"

fetchDependenciesAndUpdateNewk

## Fetch emacs imports for emacs initialization files
##
echo -e "
###################################
${B}We complete and test the installation of the text editor (Emacs).${B_}
"

GEOM_EMACS="72x25+589+15"

emacs -l ~/.emacs.d/init.el emacs \
 -T "Emacs (haskell-mode & Dante)" --no-splash --geometry="${GEOM_EMACS}"\
 --eval "(message \"Editor Emacs OK.\")" \
 --eval "(sleep-for 2)"\
 --eval "(message \"Editor Emacs OK (haskell-mode & Dante)\")" \
 --eval "(sleep-for 2)"\
 --eval "(message \"Editor Emacs OK (haskell-mode & Dante) (Emacs will close in 3 seconds).\")" \
 --eval "(sleep-for 3)"\
 --eval "(kill-emacs)"

echo -e "
${B}###################################
This is the last step. Please, log out now${B_}, before using ${B}${NEWK}${B_}.

When you log in again, open a terminal and run ${B}${NEWK} --help${B_}

${B}Enjoy! ${B_}

"

echo "killall asciinema"
killall asciinema
sleep 2
