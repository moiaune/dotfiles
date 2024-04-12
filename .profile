#! /usr/local/bin/bash

source ~/.nvm/nvm.sh
# nvm use lts/gallium

shopt -s autocd
shopt -s histappend

export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1

export EDITOR=nvim
export VISUAL=code

export PATH=$PATH:$HOME/bin
export PATH=$PATH:/Users/mm/go/bin
export PATH="/usr/local/sbin:$PATH"

export PATH=$PATH:$HOME/.composer/vendor/bin

export HISTSIZE=10000
export HISTFILESIZE=10000

if [[ -f ~/.secrets ]]
then
    source ~/.secrets
fi

# bind '"\e[A": history-search-backward'
# bind '"\e[B": history-search-forward'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

OH_MY_POSH_THEMES_DIR="$HOME/.oh-my-posh/themes"
eval "$(oh-my-posh init bash --config "$OH_MY_POSH_THEMES_DIR"/google.omp.yml)"

function mkcd()
{
    mkdir "$1" && cd "$1" || return
}

function nnote() {
    if [[ -z "$1" ]]; then
       $EDITOR "$HOME/notes"
    else
        $EDITOR "$HOME/notes/$1"
    fi
}

# -------
# Aliases
# -------
alias ls="exa"
alias l="ls" # List files in current directory
alias ll="ls -la" # List all files in current directory in long list format
alias o="open ." # Open the current directory in Finder
alias tfmt="terraform fmt -recursive"
alias ctfmt="terraform fmt -check -recursive"
alias vim="nvim"
alias vi="nvim"
alias gh="cd ~/code/github.com"

# ----------------------
# Git Aliases
# ----------------------
alias gcm='git commit -m'
alias gsa='git status -uall'
alias gps='git push'
alias gap='git add -p'

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.cargo/env"

# ----------------------
# FZF AUTO COMPLETE && KEY BINDING
# ----------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ----------------------
# GIT AUTOCOMPLETE
# ----------------------
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash

# ----------------------
export PYENV_VERSION=3.11.1
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# ----------------------
