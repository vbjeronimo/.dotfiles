#!/bin/bash

alias "cdr"='cd $(git rev-parse --show-toplevel)'

alias l="exa"
alias ls="exa"
alias ll="exa --long --all --icons --git --group-directories-first"
alias lf="exa --long --all --icons --git --only-files"
alias ld="exa --long --all --icons --git --only-dirs" 

alias t="exa --tree --icons"
alias tt="exa --tree --all --icons"
alias tf="exa --tree --all --icons --only-files"
alias td="exa --tree --all --icons --only-dirs"

alias ".."="cd .."
alias sb="cd $SECOND_BRAIN && nvim"

alias bat="batcat"
