#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

export DOTFILES="$HOME"/.dotfiles
export SECOND_BRAIN="$HOME"/second-brain

export PATH="$HOME/bin:$PATH"

alias l="exa"
alias ls="exa"
alias ll="exa --long --all --icons --git --total-size"
alias lf="exa --long --all --icons --git --only-files"
alias ld="exa --long --all --icons --git --only-dirs --total-size" 

alias t="exa --tree --icons"
alias tt="exa --tree --all --icons"
alias tf="exa --tree --all --icons --only-files"
alias td="exa --tree --all --icons --only-dirs"

alias sb="cd $SECOND_BRAIN"
alias ".."="cd .."

#================================================

eval "$(starship init bash)"

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec startx
fi
