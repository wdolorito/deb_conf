# Notes to bring a rolling Debian/Devuan stable installation up with lxc

## File listing:

```
.
├── apt
│   ├── chimaera
│   │   ├── ceres.list
│   │   ├── ceres.pref
│   │   ├── chimaera.list
│   │   ├── chimaera.pref
│   │   ├── daedalus.list
│   │   └── daedalus.pref
│   ├── debian
│   │   ├── bullseye.list
│   │   ├── bullseye.pref
│   │   ├── testing.list
│   │   ├── testing.pref
│   │   ├── unstable.list
│   │   └── unstable.pref
│   └── update.sh
├── lxc
│   ├── container.service
│   ├── container.timer
│   ├── default.conf
│   ├── enable_timer
│   ├── lxc-usernet
│   ├── vnc-remote.service
│   ├── vnc-remote.timer
│   └── vnc_server
│       ├── install.sh
│       └── scripts
│           ├── config.sh
│           ├── eth0-static
│           ├── install_codium.sh
│           ├── interfaces
│           ├── set_ip.sh
│           └── vnc-server.service
├── README.md
└── third_party
    ├── atom.list
    ├── google_chrome.list
    ├── opera.list
    ├── skype.list
    ├── spotify.list
    ├── sublime.list
    ├── teamviewer.list
    ├── ubuntuzilla.list
    ├── vagrant.list
    ├── vivaldi.list
    ├── vscode.list
    ├── vscodium.list
    └── yarn.list
```

File locations are commented at the top of each file.

```apt/update.sh``` is a simple shell script to update the system.  It will ```dist-upgrade``` and track Debian Bullseye or Devuan Chimaera when the respective preference files are placed in ```/etc/apt/preferences.d```.

With a properly set up Debian systemd ```lxc``` system, the files under ```lxc/vnc_server``` will create and setup a vncserver under the default lxc bridge (10.0.3.1) at 10.0.3.250:5910 running xfce.  Extra installed software is listed in ```lxc/vnc_server/scripts/config.sh``` and can be deleted and/or added to there.  These are the author's preferences for a standard desktop, which include development tools (git, C, C++, clang, java, node) and a few packages that are not included as dependencies for ```task-xfce-desktop```.

To access the newly created vncserver, add some ```iptables``` rules to forward a port to the container from the running Debian systemd ```lxc``` system:
```
# port 8000 to 10.0.3.250:22
iptables -t nat -A PREROUTING -p tcp --dport 8000 -j DNAT --to-destination 10.0.3.250:22
iptables -t nat -A POSTROUTING -p tcp -d 0.0.0.0 --dport 22 -j SNAT --to-source 10.0.3.250
```
From a system on the LAN, ```ssh``` to the container and forward the ports over the connection:
```
Example host IP 192.168.1.200:
ssh -2p 8000 -L 5910:localhost:5910 192.168.1.200
```
Start a vnc client, such as [https://www.realvnc.com/en/connect/download/viewer/](https://www.realvnc.com/en/connect/download/viewer/), and connect to ```localhost:5910```.  The XFCE desktop will appear after putting in the ```vncpasswd```.

All ```.list``` files are generated from [https://debgen.simplylinux.ch](https://debgen.simplylinux.ch) except for ```vscodium.list```.  The commands to install the GPG keys for the third party repos are in a comment at the bottom of their respective ```.list``` files.