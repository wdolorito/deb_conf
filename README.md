# Notes to bring a rolling Debian stable installation up with lxc

## File listing:

```
.
├── lxc
│   ├── container.service
│   ├── container.timer
│   ├── default.conf
│   ├── enable_timer
│   ├── enable_unprivileged
│   ├── lxc-net
│   ├── lxc-usernet
│   ├── startvnc.sh
│   ├── stopvnc.sh
│   └── vnc_remote
├── stable.list
├── stable.pref
├── testing.list
├── testing.pref
├── third_party
│   ├── atom.list
│   ├── dropbox.list
│   ├── ghostwriter.list
│   ├── google_chrome.list
│   ├── llvm.list
│   ├── mariadb.list
│   ├── mongodb-org-4.4.list
│   ├── nginx.list
│   ├── nodejs.list
│   ├── openshot.list
│   ├── opera.list
│   ├── php.list
│   ├── postgresql.list
│   ├── skype.list
│   ├── slack.list
│   ├── spotify.list
│   ├── sublime.list
│   ├── teamviewer.list
│   ├── ubuntuzilla.list
│   ├── vagrant.list
│   ├── virtualbox.list
│   ├── vivaldi.list
│   ├── vscode.list
│   └── yarn.list
├── unstable.list
├── unstable.pref
└── update.sh

```

File locations are commented at the top of each file.

## Special files:
 - vnc_remote
 - enable_unprivileged
 - startvnc.sh
 - stopvnc.sh
 - update.sh

```vnc_remote``` contains commands to install ```mate-desktop-environment``` in to a container and a fix to allow it to run.  Add ```startvnc.sh``` and ```stopvnc.sh``` to a user account of container.  ```startvnc.sh``` will create an HD sized desktop on port 5910.  ```ssh -2L 5910:localhost:5910 <user>@<container ip>``` and then launch a vncviewer application (e.g. Remmina) that opens ```localhost:5910``` to view the desktop.

```enable_unprivileged``` contains commands to enabled unprivileged containers.  Run both commands as root.

```update.sh``` is a simple shell script to update the system.  It will do a ```dist-upgrade``` so it will always track whatever is in the preference files, namely Debian stable.

All ```.list``` files are generated from [https://debgen.simplylinux.ch](https://debgen.simplylinux.ch) except for ```mongodb-org-4.4.list```.  The commands to install the GPG keys for the third party repos are in a comment at the bottom of their respective ```.list``` files.
