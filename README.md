# FRESH SETUP

## A project make new Linux machines looks and feel better

![Image](https://github.com/user-attachments/assets/e5e29b9f-159f-47f7-be48-262d51424302)


- Update, installing additional handy packages,custom profile for RHEL-based and Debian-based machines.
- Auto detect non-root user, user name does not matter but need sudo for this to work.
- Backup current profile .bashrc and .vimrc  before running.
- Structure:

├──dotfile : profile settings

├──packages:

│  ├──deb_pkg_list: List of packages for Debian-based

│  └──rpm_pkg_list: List of packages for RHEL-based

├──README.md

└── setup.sh: run file
- Usage:
```
bash setup.sh
```


