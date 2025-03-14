#!/bin/bash
function update_packages() {
	# Determine which package list to use based on package manager
	if [ "$PKG_MGR" = "apt" ]; then
		COMMON_PACKAGES=$(cat ./packages/deb_pkg_list)
	elif [ "$PKG_MGR" = "dnf" ]; then
		COMMON_PACKAGES=$(cat ./packages/rpm_pkg_list)
	else
		echo "Unsupported package manager: $PKG_MGR"
		exit 1
	fi

	# Check if running as root
	if [ "$EUID" -ne 0 ]; then
		SUDO="sudo"
	else
		SUDO=""
	fi

	# Use $SUDO in commands
	$SUDO $PKG_MGR update -y && $SUDO $PKG_MGR upgrade -y
	$SUDO $PKG_MGR clean all
	$SUDO $PKG_MGR install -y $COMMON_PACKAGES
}

# Backup existing config files with a timestamp
function backup_file() {
	local file=$1
	if [ -f "$file" ]; then
		cp -pv "$file" "${file}_$(date +%Y%m%d)"
	fi
}

# Function for Debian-based systems
function custom_profile() {
	backup_file $HOME/.bashrc
	cp ./dotfile/.bashrc $HOME/.bashrc
	backup_file $HOME/.vimrc
	cp ./dotfile/.vimrc $HOME/.vimrc
	source $HOME/.bashrc
	bash
}
# Detect the distro type and provision accordingly
if [ -f /etc/os-release ]; then
	if grep -qi 'ubuntu\|debian' /etc/os-release ; then
		PKG_MGR="apt"
		update_packages
		custom_profile
	elif grep -qi 'centos\|rocky\|rhel' /etc/os-release ; then
		PKG_MGR="dnf"
		update_packages
		custom_profile
	fi
fi
