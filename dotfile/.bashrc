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
alias l='ls -lash --group-directories-first'
alias mkdir='mkdir -p'
alias ports='ss -tnlp'
alias his='history'
alias ex='exit'
alias ls='ls --color=auto'
alias o='tree .'
alias ..='cd ../'

# Get primary non-loopback IP address
custom=\$(ip -o -4 addr show scope global | awk '{print \$4}' | sed 's/\/.*//g' | head -n 1)
export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@"\$custom"-\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]#\[\e[m\] "
