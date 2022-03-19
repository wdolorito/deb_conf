#!/bin/sh
APT=apt-get
SCRIPTS=scripts
USER=vncuser
SYSD_DIR=/home/$USER/.local/share/systemd/user
sed -i 's/main/main\ contrib\ non-free/g' /etc/apt/sources.list &&
${APT} update &&
${APT} install -y task-xfce-desktop task-ssh-server tightvncserver \
                  nano wget curl p7zip-full p7zip-rar file \
                  filezilla transmission inkscape chromium \
                  git clang lldb lld cmake ninja-build \
                  build-essential default-jdk nodejs npm &&

/usr/sbin/useradd -m -s /bin/bash $USER &&
mkdir -p $SYSD_DIR &&
cp /root/$SCRIPTS/vnc-server.service $SYSD_DIR &&
chown $USER:$USER $SYSD_DIR/vnc-server.service &&
su - $USER -c "systemctl --user daemon-reload" &&
loginctl enable-linger $USER &&
su - $USER -c "systemctl --user enable vnc-server.service" &&
echo "SET VNC SESSION PASSWORD" &&
su - $USER -c vncpasswd &&
echo "SET USER PASSWD" &&
passwd $USER &&
su - $USER -c "systemctl --user start vnc-server.service"