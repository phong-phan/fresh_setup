alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
alias vi='vim'
set -o vi
alias cl='clear'
alias l='ls -lash'
alias o='tree .'
alias mkdir='mkdir -p'
alias ports='ss -tnlp'
alias his='history'
alias ex='exit'
alias ..='cd ../'
export EDITOR=vim
export VISUAL=vim
custom=$(ip -4 -o addr show | awk '!/127.0.0.1/ {print $4; exit}' | cut -d/ -f1)
export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@"$custom"-\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]>\[\e[m\] "

