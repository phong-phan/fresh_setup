# FRESH SETUP
- Update, installing additional handy packages,custom profile for RHEL-based and Debian-based machines.
- Auto detect non-root user
- Backup current profile before running.
- Structure:

├──dotfile : profile settings

├──packages: list packages for RHEL-based and Debian-based

│  ├──deb_pkg_list

│  └──rpm_pkg_list

├──README.md

└── setup.sh: run file
- Usage:
```
bash setup.sh
```


