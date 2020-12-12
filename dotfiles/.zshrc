
HISTSIZE=1000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Support for UTF-8
alias tmux='tmux -u'
# Fixes bug with prompt width 
export LC_CTYPE=en_US.UTF-8

# Support for Ctrl+Arrow keys
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Use neovim as editor
alias vim=nvim
export EDITOR=nvim

alias ls='ls --color=auto'
export LS_COLORS="$(vivid generate snazzy)"

# Hide gdb startup text
alias gdb='gdb -q'  

alias python='/usr/bin/python3'
alias pip='/usr/bin/pip3'

fpath+=$HOME/.zsh/pure
autoload -Uz promptinit
promptinit
prompt pure

# For virtualenvwrapper
source $(which virtualenvwrapper.sh)