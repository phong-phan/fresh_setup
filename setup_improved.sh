#!/bin/bash

echo "Provisioning the machine, please hang in there..."

function install_packages() {
    local packages=("$@")
    if [ "$(which apt)" ]; then
        sudo apt update && sudo apt install -y "${packages[@]}"
    elif [ "$(which yum)" ]; then
        sudo yum clean all && sudo yum -y update && sudo yum -y install "${packages[@]}"
    else
        echo "Unsupported package manager."
        exit 1
    fi
}

function backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        cp -pv "$file" "$file_$(date +%Y%m%d)"
    fi
}

function configure_bash() {
    local user_home="$1"
    local bashrc_file="$user_home/.bashrc"
    local vimrc_file="$user_home/.vimrc"

    backup_file "$bashrc_file"
    cat << BASH > "$bashrc_file"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
set -o emacs
alias cl='clear'
alias l='ls -lash'
alias o='tree .'
alias mkdir='mkdir -p'
alias ports='ss -tnlp'
alias his='history'
alias ex='exit'
alias ..='cd ../'
custom=\$(ip address show ens192 | grep -w inet  | awk '{print \$2}'| sed 's/\/.*//g')
export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@"\$custom"-\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]#\[\e[m\] "
BASH

    backup_file "$vimrc_file"
    cat << VIM > "$vimrc_file"
set nocompatible
set shiftwidth=4
set tabstop=4
set scrolloff=15
set ignorecase
set omnifunc=syntaxcomplete#Complete
set number
set wrap
set linebreak
set encoding=utf-8
set showcmd
set showmatch
set wildmenu
set smarttab
set hlsearch
set incsearch
set cc=
set fillchars+=vert:\▏
set clipboard=unnamedplus
set wildmode=longest:full,full
set title
set completeopt-=preview
set background=dark
set statusline+=%F
set laststatus=2
set guicursor+=n-v-c:blinkon0
VIM
}

if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ "$ID" =~ ^(ubuntu|debian)$ ]]; then
        install_packages bash-completion curl wget htop tree sysstat iotop telnet net-tools vim
        configure_bash "/home/$(logname)"
    elif [[ "$ID" =~ ^(centos|rocky|rhel)$ ]]; then
        install_packages bash-completion bash-completion-extras net-tools curl wget epel-release wget htop tree sysstat iotop telnet net-tools bind-utils vim
        configure_bash "/root"
    else
        echo "Unsupported distribution."
        exit 1
    fi
else
    echo "Cannot determine OS."
    exit 1
fi

bash
