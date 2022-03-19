#!/bin/sh
SCRIPTS=scripts
sleep 10 &&
cp -f /root/$SCRIPTS/interfaces /etc/network &&
cp -f /root/$SCRIPTS/eth0-static /etc/network/interfaces.d &&
systemctl restart networking