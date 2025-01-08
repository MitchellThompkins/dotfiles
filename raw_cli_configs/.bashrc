
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# terminal configuration
PS1='[\u@\h \W]\$ '

# git
source /usr/share/git/completion/git-completion.bash

# alias
alias tat="tmux a -t"
alias ls='ls --color=auto'
alias spro='source ~/.profile'
alias rhead='git reset --hard HEAD'

export PATH="${PATH}"
