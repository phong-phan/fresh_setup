#!/bin/bash

echo "Configuring the machine now please wait"
# Common packages for both CentOS and Debian-based distros
COMMON_PACKAGES="bash-completion curl wget tree telnet net-tools vim"

# Function for CentOS/RHEL-based systems
function rhel_provision() {
	yum clean all && yum -y update
	yum -y install epel-release
	yum -y install $COMMON_PACKAGES bind-utils
	backup_file /root/.bashrc
	backup_file /root/.vimrc
	configure_bashrc /root
	configure_vimrc /root
	source /root/.bashrc
	bash
}

# Function for Debian-based systems
function debian_provision() {
	sudo apt clean
	sudo apt update -y && sudo apt upgrade -y
	sudo apt install -y $COMMON_PACKAGES dnsutils
	backup_file /home/$(whoami)/.bashrc
	backup_file /home/$(whoami)/.vimrc
	configure_bashrc /home/$(whoami)
	configure_vimrc /home/$(whoami)
	source /home/$(whoami)/.bashrc
	bash
}

# Backup existing config files with a timestamp
function backup_file() {
	local file=$1
	if [ -f "$file" ]; then
		cp -pv "$file" "${file}_$(date +%Y%m%d)"
	fi
}

# Configure .bashrc with custom settings
function configure_bashrc() {
	local target_dir=$1
	cat << BASH > "$target_dir/.bashrc"
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
BASH
}

# Configure .vimrc with custom settings
function configure_vimrc() {
	local target_dir=$1
	cat << VIM > "$target_dir/.vimrc"
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
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
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
VIM
}

# Detect the distro type and provision accordingly
if [ -f /etc/os-release ]; then
	if grep -qi 'ubuntu\|debian' /etc/os-release ; then
		debian_provision
	elif grep -qi 'centos\|rocky\|rhel' /etc/os-release ; then
		rhel_provision
	fi
fi
