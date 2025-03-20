# FRESH SETUP

https://private-user-images.githubusercontent.com/67781194/424823950-e5e29b9f-159f-47f7-be48-262d51424302.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDI0NDczMDQsIm5iZiI6MTc0MjQ0NzAwNCwicGF0aCI6Ii82Nzc4MTE5NC80MjQ4MjM5NTAtZTVlMjliOWYtMTU5Zi00N2Y3LWJlNDgtMjYyZDUxNDI0MzAyLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTAzMjAlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwMzIwVDA1MDMyNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTc1YmEyOTM3NzAxNGJhN2U3Y2RjZjI0OGFiODYxYTIyNjdkZjEwZmY3MGViMTBhMmI5MzgzZWFjMjYyZGU3NWUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.z6x0eprQOjA1MGQ_G8jsD-AIwv2Tt8mtPkVjqU99FzM

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


