#!/bin/bash

echo "Provisioning the machine, please hanging there"


function cent_provision() {
	yum clean all && yum -y update
	yum -y install epel-release
	yum -y install bash-completion curl wget htop tree sysstat iotop telnet bind-utils net-tools vim
	if [ -f /root/.bashrc ]; then
		cp -pv /root/.bashrc /root/.bashrc_$(date +%Y%m%d)
	fi
	if [ -f /root/.vimrc ]; then
		cp -pv /root/.vimrc /root/.vimrc_$(date +%Y%m%d)
	fi
	cat  << BASH > /root/.bashrc
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
#Only for VMWare infra
custom=\$(ip address show ens192 | grep -w inet  | awk '{print \$2}'| sed 's/\/.*//g')
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
set statusline+=%F
set laststatus=2
set guicursor+=n-v-c:blinkon0
VIM
source /root/.bashrc
bash

}
function debian_provision() {
	sudo apt clean
	sudo apt update -y && sudo apt upgrade -y
	sudo apt install -y bash-completion  curl wget  wget htop tree sysstat iotop telnet net-tools vim dns-utils
	sudo cp -pv /home/$(whoami)/.bashrc /home/$(whoami)/.bashrc_$(date +%Y%m%d)
	rm -rf  /home/$(whoami)/.bashrc
	if [ -f /home/"$(whoami)"/.vimrc ]; then
		sudo cp -pv /home/$(whoami)/.vimrc /home/$(whoami)/.vimrc_$(date +%Y%m%d)
	fi
	cat  << BASH > /home/"$(whoami)"/.bashrc
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
alias mkdir='mkdir -p'
alias ports='ss -tnlp'
alias his='history'
alias ex='exit'
alias ls='ls --color=auto'
alias o='tree .'
alias ..='cd ../'
custom=$(ip address show ens192 | grep -w inet  | awk '{print $2}'| sed 's/\/.*//g')
export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@"\$custom"-\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]#\[\e[m\] "
BASH
cat << VIM > /home/$(whoami)/.vimrc
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
set statusline+=%F
set laststatus=2
set guicursor+=n-v-c:blinkon0
VIM
source /home/$(whoami)/.bashrc
bash

}


if [ -f /etc/os-release ]; then
	if [ "$(grep 'Ubuntu\|Debian' /etc/os-release )" ] ; then
		if [ $? -eq 0 ]; then
			debian_provision
		fi
	elif [ "$(grep -i "CentOS\|Rocky\|RHEL" /etc/os-release )" ]; then
		if [ $? -eq 0 ]; then
			cent_provision
		fi
	fi
fi

