#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "Downloading cosmic packages..."
deb_urls=$(bash /usr/share/get-cosmic-deb-urls.sh)
mkdir -p deb_files
cd deb_files || exit
for url in $deb_urls; do
  echo "Downloading $url"
  wget -q --no-verbose "$url"
done

echo "Installing required tools and dependencies..."
sudo apt-get install -y greetd libdisplay-info-bin libdisplay-info2 libseat1 libxkbcommon0 libinput-bin libinput10 dbus xwayland geoclue-2.0 playerctl gettext
wget https://archive.neon.kde.org/unstable/pool/main/libd/libdisplay-info/libdisplay-info1_0.1.1-1+22.04+jammy+unstable+build3_amd64.deb
sudo apt-get install -y ./libdisplay-info1_0.1.1-1+22.04+jammy+unstable+build3_amd64.deb

echo "Installing cosmic packages"
sudo apt-get install -y ./*.deb

echo "Holding cosmic packages"
for deb in ./*.deb; do
  package=$(dpkg --info "$deb" | grep " Package:" | awk '{print $2}')
  sudo apt-mark hold "$package"
done

if [ $? -ne 0 ]; then
  echo "Failed to install cosmic packages"
  exit 1
fi
