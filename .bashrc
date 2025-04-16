#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

clear

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
PS1='[\u@\h \W]\$ '
