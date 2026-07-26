RESET='\[\e[0m\]'
GREEN='\[\e[32m\]'
RED='\[\e[31m\]'
YELLOW='\[\e[33m\]'
CYAN='\[\e[36m\]'
MAGENTA='\[\e[35m\]'

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
node_ip=$(ip -4 -o addr show | awk '!/127.0.0.1/ {print $4; exit}' | cut -d/ -f1)
git_prompt() {
    branch=$(git branch 2>/dev/null | sed -n '/\* /s///p')
    if [ -n "$branch" ]; then
        status=$(git status --porcelain 2>/dev/null)
        if [ -n "$status" ]; then
            echo " ($branch ✗)"
        else
            echo " ($branch ✓)"
        fi
    fi
}


export PS1="${GREEN}[${RESET}${RED}\u${RESET}${YELLOW}@${node_ip}-${GREEN}\h${RESET}:${CYAN}\w${RESET}${MAGENTA}\$(git_prompt)${RESET}${GREEN}]>${RESET} "
