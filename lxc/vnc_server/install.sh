#!/bin/sh
DOWNLOAD_KEYSERVER=keyserver.ubuntu.com
LXC_HOME=~/.local/share/lxc
LXC_START=lxc-unpriv-start
LXC_STOP=lxc-stop
LXC_ATTACH=lxc-unpriv-attach
SCRIPTS=scripts
CNAME=vnc-server

lxc-create -t download -n $CNAME -- -d debian -r bullseye -a amd64 &&
$LXC_START -n $CNAME &&
cp -r $SCRIPTS $LXC_HOME/$CNAME/rootfs/tmp &&
$LXC_ATTACH -n $CNAME -- cp -rf /tmp/$SCRIPTS /root &&
$LXC_ATTACH -n $CNAME -- /root/$SCRIPTS/set_ip.sh &&
$LXC_ATTACH -n $CNAME -- /root/$SCRIPTS/config.sh &&
$LXC_ATTACH -n $CNAME -- /root/$SCRIPTS/install_codium.sh &&
echo "SETUP COMPLETE"