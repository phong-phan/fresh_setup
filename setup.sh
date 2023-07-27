#!/bin/bash

echo "Provisioning the machine, please hanging there"


function cent_provision() {
	echo "Update server"
	yum clean all && yum -y update
	echo "Install needed packages"
	yum -y install bash-completion bash-completion-extras curl wget epel-release wget htop tree sysstat iotop telnet net-tools bind-utils
	echo "Applying config for bash and vim"
	cp -pv /root/.bashrc /root/.bashrc_$(date +%Y%m%d)
	cp -pv /root/.vimrc /root/.vimrc_$(date +%Y%m%d)
	cat  << BASH > /root/.bashrc
	alias rm='rm -i'
	alias cp='cp -i'
	alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
alias vi='vim'
set -o emacs
alias cl='clear'
alias l='ls -lash'
alias mkdir='mkdir -p'
alias ports='ss -tnlp'
alias his='history'
alias ex='exit'
alias ..='cd ../'
custom=\$(ifconfig | grep 'inet '| grep -v '127.0.0.1'  | awk '{print \$2}'| head -n1)
export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@"\$custom"-\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]#\[\e[m\] "
BASH
cat << VIM > /root/.vimrc
set nocompatible "Use this vimrc for system-wide instead of personal vimrc for each dir, project...
set shiftwidth=4 "Set shiftwidth
set tabstop=4
set scrolloff=15 "Left 10 last line, instead of move cursor to the end of file when scrolling
set ignorecase "better for searching, worse for replacing
set omnifunc=syntaxcomplete#Complete
set number
set wrap
set linebreak "break long lines into multiple smaller lines
set encoding=utf-8
set showcmd "show cmd at the last line of the screen
set showmatch "highlight the matching
set wildmenu "enhanced completion
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set smarttab  "when in the beginning of a blank line insert a tab
set hlsearch "highlight all previous search match
set incsearch "move to the first match when searching
set cc=
set fillchars+=vert:\▏
set clipboard=unnamedplus "yy puy content into clipboard
set wildmode=longest:full,full "enhanced completion
set title
set completeopt-=preview
set background=dark
set guicursor+=n-v-c:blinkon0
VIM
source /root/.bashrc
bash

}
function debian_provision() {
	echo "Update server"
	sudo apt clean
	sudo apt update -y && sudo apt upgrade -y
	echo "Install needed packages"
	sudo apt install -y bash-completion  curl wget  wget htop tree sysstat iotop telnet net-tools
	echo "Applying config for bash and vim"
	cp -pv /home/u1/.bashrc /home/u1/.bashrc_$(date +%Y%m%d)
	cp -pv /home/u1/.vimrc /home/u1/.vimrc_$(date +%Y%m%d)
	cat  << BASH > /home/u1/.bashrc
	alias rm='rm -i'
	alias cp='cp -i'
	alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
alias vi='vim'
set -o emacs
alias cl='clear'
alias l='ls -lash'
alias mkdir='mkdir -p'
alias ports='ss -tnlp'
alias his='history'
alias ex='exit'
alias ..='cd ../'
custom=\$(ifconfig | grep 'inet '| grep -v '127.0.0.1'  | awk '{print \$2}'| head -n1)
export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@"\$custom"-\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]#\[\e[m\] "
BASH
cat << VIM > /home/u1/.vimrc
set nocompatible "Use this vimrc for system-wide instead of personal vimrc for each dir, project...
set shiftwidth=4 "Set shiftwidth
set tabstop=4
set scrolloff=15 "Left 10 last line, instead of move cursor to the end of file when scrolling
set ignorecase "better for searching, worse for replacing
set omnifunc=syntaxcomplete#Complete
set number
set wrap
set linebreak "break long lines into multiple smaller lines
set encoding=utf-8
set showcmd "show cmd at the last line of the screen
set showmatch "highlight the matching
set wildmenu "enhanced completion
set smarttab  "when in the beginning of a blank line insert a tab
set hlsearch "highlight all previous search match
set incsearch "move to the first match when searching
set cc=
set fillchars+=vert:\▏
set clipboard=unnamedplus "yy puy content into clipboard
set wildmode=longest:full,full "enhanced completion
set title
set completeopt-=preview
set background=dark
set guicursor+=n-v-c:blinkon0
VIM
source /home/u1/.bashrc
bash

}


if [ -f /etc/os-release ]; then
	if [ "$(grep 'Ubuntu' /etc/os-release )" ] ; then
		if [ $? -eq 0 ]; then
			echo "Debian-based distro"
			debian_provision
		fi
	elif [ "$(grep "CentOS Linux" /etc/os-release )" ]; then
		if [ $? -eq 0 ]; then
			echo "REHL-based distro"
			cent_provision
		fi
	fi
fi
