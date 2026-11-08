
#!/bin/bash
set -e

echo "PIYAS RDP INSTALLER"

apt-get update
apt-get install -y xfce4 xfce4-goodies xrdp dbus-x11 curl

if ! id piyas >/dev/null 2>&1; then
    adduser --disabled-password --gecos "" piyas
fi

echo "Set RDP password:"
passwd piyas

echo "xfce4-session" > /home/piyas/.xsession
chown piyas:piyas /home/piyas/.xsession

adduser xrdp ssl-cert

systemctl enable xrdp
systemctl restart xrdp

curl -fsSL https://tailscale.com/install.sh | sh

systemctl enable --now tailscaled

echo "INSTALLATION COMPLETE"
echo "RDP USER: piyas"
echo "RDP PORT: 3389"
echo "Use Tailscale for secure access."
