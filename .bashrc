# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export GPG_TTY=$(tty)

set -o vi
shopt -s globstar
shopt -s dotglob

bash_home="$HOME/.config/bash"
[ -f "$bash_home/aliases.bash" ] && . "$bash_home/aliases.bash"
[ -d "$bash_home/functions" ] &&
    for i in $bash_home/functions/*; do . "$i"; done
[ -d "$bash_home/completions" ] &&
    for i in $bash_home/completions/*; do . "$i"; done

command -v fzf >/dev/null && eval "$(\fzf --bash)"

git_prompt="/usr/share/git/completion/git-prompt.sh"
[ -f "$git_prompt" ] && . "$git_prompt"

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_DESCRIBE_STYLE=1
GIT_PS1_SHOWCOLORHINTS=1

PS1='\[\033[30;47m\]\u@\h\[\033[00m\] \W$(__git_ps1 " %s") \$ '
