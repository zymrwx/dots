[ -f ~/.bashrc ] && . ~/.bashrc

export HISTSIZE="5000"
export HISTFILESIZE="50000"
export HISTIGNORE="cd:cd -:cd ..:pwd:ls:exit"
export HISTCONTROL=ignoreboth

[ -d "$HOME/.local/bin" ] &&
    export PATH="$(find ${HOME}/.local/bin/ -type d |
    paste -sd ':' -):${PATH}"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="vim"
export PAGER="less"

export ABDUCO_SOCKET_DIR="$XDG_RUNTIME_DIR"
export DVTM_EDITOR="vim"
export DVTM_PAGER="less -R"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

[ -d "$XDG_STATE_HOME/bash" ] || mkdir -p "$XDG_STATE_HOME/bash"
export HISTFILE="$XDG_STATE_HOME/bash/history" && touch "$HISTFILE"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export PASSWORD_STORE_DIR="$HOME/doc/.gpg/pass"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

[ -d "$XDG_DATA_HOME/dic" ] || mkdir -p "$XDG_DATA_HOME/dic"
export STARDICT_DATA_DIR="$XDG_DATA_HOME"

command -v cls > /dev/null && cls -d > /dev/null 2>&1

[ "$(tty)" = "/dev/tty1" ] &&
    ! pidof -s Xorg >/dev/null &&
    command -v startx >/dev/null &&
    exec startx
