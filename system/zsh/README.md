# Zsh
Zsh (Z shell) is a Unix command interpreter and shell script processor. It is often described as an extended and highly customizable version of Bash.

I switched to this shell for ghost text auto-suggestions and history based auto-completion. I configured it to look and behave like the bash default.

## Setup
*COMPLETED 16/05/2026*

Install
```bash
sudo apt install zsh zsh-autosuggestions
```

Open config
```bash
sudo nano ~/.zshrc
```
```bash
# Use bash command history
HISTFILE=~/.bash_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory histignoredups
# Set prompt colours to Ubuntu default
PROMPT=$'%F{green}%B%n@%m%b%f:%F{blue}%B%~%b%f$ '

# Load zsh tab-completion
autoload -Uz compinit && compinit
# Remove completion select menu
zstyle ':completion:*' menu false

# Load zsh-autosuggestions plugin
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Set suggestion text colour to grey
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Suggestions based on history first, then completion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# TAB to next suggestion word
bindkey '^I' forward-word

# Alias go here
```

Enter zsh
```bash
zsh
```

Reload changes
```bash
source ~/.zshrc
```

Set as default
```bash
chsh -s $(which zsh)
```

## Add Alias
Add to bottom of config
```bash
nano ~/.zshrc
source ~/.zshrc
```

### List of Alias
```bash
# Basic computer temps (OPTIPLEX 5080) (install lm-sensors)
alias temps='s=$(sensors); echo "CPU:  $(echo "$s" | grep Package | awk "{print \$4}")"; echo "NVMe: $(echo "$s" | grep Composite | awk "{print \$2}")"; echo "Fan:  $(echo "$s" | grep fan1 | awk "{print \$2, \$3}")"'

# Basic computer temps (POWEREDGE T340) (install lm-sensors)
alias temps='s=$(sensors); cpu=$(echo "$s" | awk "/Package id 0/ {print \$4}"); pch=$(echo "$s" | awk "/temp1/ {print \$2}"); echo "CPU: $cpu"; echo "PCH: $pch"'

# Ollama prefix for commands into container
alias ollama='podman exec -it ollama ollama'
```


## Back to bash?
Enter zsh
```bash
bash
```

Set bash as default
```bash
chsh -s $(which bash)
```