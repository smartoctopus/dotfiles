#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# HISTORY
export HISTSIZE=500
export HISTFILESIZE=500
export HISTCONTROL=ignoredups:erasedup

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Core aliases
alias ..='cd ..'
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'

# Other aliases
alias zed='zeditor'

# Prompt
PS1='[\u@\h \W]\$ '

# mise-en-place
eval "$(~/.local/bin/mise activate bash)"
