# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/apokaliph/.zshrc'

autoload -Uz compinit
compinit
eval "$(starship init zsh)"
# End of lines added by compinstall
export PATH="$HOME/.local/bin:$PATH"
