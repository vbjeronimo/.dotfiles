#!/bin/bash

alias "cdr"='cd $(git rev-parse --show-toplevel)'

alias l="exa"
alias ls="exa"
alias ll="exa --long --all --icons --git --group-directories-first"

alias t="exa --tree --icons"
alias tt="exa --tree --all --icons"

alias ".."="cd .."
alias sb="cd $SECOND_BRAIN && nvim"

alias bat="batcat"
