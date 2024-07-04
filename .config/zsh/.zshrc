echo "... Loading .zshrc"
ZSH_DISABLE_COMPFIX=true

# --- PLUGINS
plugins=(
    "$XDG_CONFIG_HOME/zsh/zsh.d/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
    "$XDG_CONFIG_HOME/zsh/zsh.d/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"
    "/usr/share/fzf/key-bindings.zsh" 
)

for plg in $plugins; do
    test -f "$plg" && source "$plg"
done

# --- EXPORTS
export KEYTIMEOUT=1

# --- KEYBINDINGS
bindkey '^F' forward-word 
bindkey '^E' end-of-line
bindkey '^A' beginning-of-line
bindkey '^W' backward-kill-word
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

# --- OPTIONS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

# --- VARIABLES
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE="(pwd|token|secret|password)"
HISTCONTROL=ignoredups:erasedups
HISTFILE="$XDG_DATA_HOME/zsh/history"

# --- ALIASES
alias ls="ls --color=tty"
alias l="ls"
alias ll="ls -la"
alias o="open ."
alias vim="nvim"
alias vi="nvim"
alias gcm="git commit -m"
alias gsa="git status -uall"
alias gps="git push"
alias gap="git add -p"
alias gpf="git pull && git fetch --prune"

# --- PROMPT
eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/oh-my-posh/config.yml)"

zstyle ':completion:*:*:git:*' script "$XDG_CONFIG_HOME/zsh/zsh.d/completion/git-completion.bash"
fpath=("$XDG_CONFIG_HOME/zsh/zsh.d/completion" $fpath)

autoload -Uz compinit

ZSH_COMPDUMP="${XDG_CACHE_HOME:-~/.cache}/zsh/zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
compinit -i -d "${ZSH_COMPDUMP}"

# --- AUTO COMPLETE
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. "$HOME/.cargo/env"
