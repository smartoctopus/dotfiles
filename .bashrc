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
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"

# GPG
export GPG_TTY=$(tty)

# EDITOR
export VISUAL="vim"
export EDITOR="$VISUAL"

# Core aliases
alias ..='cd ..'
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias vi="vim"

# Other aliases
alias zed='zeditor'
alias windows='quickemu --vm ~/vms/windows-10.conf'

# Prompt
PS1='[\u@\h \W]\$ '

# mise-en-place
eval "$(~/.local/bin/mise activate bash)"
