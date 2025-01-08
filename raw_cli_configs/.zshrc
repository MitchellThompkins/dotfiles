#!/bin/bash

# terminal configuration
export PS1="%B%~ > %b"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# git
autoload -Uz compinit && compinit

# alias
alias tat="tmux a -t"
alias ls='ls -GFh'
alias spro='source ~/.profile'
alias rhead='git reset --hard HEAD'

# tools
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"

# Created by `pipx` on 2025-01-02 05:49:38
export PATH="$PATH:/Users/mitchellthompkins/.local/bin"
