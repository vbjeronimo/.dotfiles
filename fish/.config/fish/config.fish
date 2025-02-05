set -U fish_greeting

alias cdr="cd (git rev-parse --show-toplevel)"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

pyenv init - fish | source
