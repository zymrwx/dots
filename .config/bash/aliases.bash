alias rm="rm -I"
alias cp="cp -i"
alias mv="mv -i"

alias ls='ls -F --color=auto --group-directories-first'
alias la="ls -A"
alias ll="ls -lh --time-style=long-iso"
alias l.="ls -d .*"
alias le="ls | grep -o '.[^.]*$' | sort | uniq"

alias tree="tree -C"

alias less="less -i"
alias grep='grep --color=auto'
alias diff="diff --color=auto"

alias whatis="whatis -l"

alias df="df -h -x tmpfs -x efivarfs -x devtmpfs"
alias du="du -ahLd1"
alias free="free -h"

alias g="git status"
alias ga="git add"
alias gb="git branch"
alias gck="git checkout"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --graph --pretty=format:'%C(auto)%h%d %s <%C(yellow)%an%C(auto)>%C(reset)'"
alias glt="git log --graph --pretty=format:'%C(auto)%h%d %s (%C(magenta)%ar%C(auto))%C(reset)'"
alias gla="git log --graph --pretty=format:'%C(auto)%h%d %s <%C(yellow)%an%C(auto)> %C(magenta)(%ar)%C(reset)'"
alias gln="git log --name-only --show-signature --graph"
alias gr="git remote"
alias gsh="git show"
