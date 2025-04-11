#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
    for key in ~/.ssh/id_*; do
        # Skip public keys
        [[ -f "$key" && "$key" != *.pub ]] && ssh-add "$key"
    done
fi
clear

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
PS1='[\u@\h \W]\$ '
