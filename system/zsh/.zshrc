HISTFILE=~/.bash_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory histignoredups
PROMPT=$'%F{green}%B%n@%m%b%f:%F{blue}%B%~%b%f$ '

autoload -Uz compinit && compinit
zstyle ':completion:*' menu false

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey '^I' forward-word