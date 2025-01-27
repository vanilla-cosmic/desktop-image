#!/bin/bash

# -----------------------------------------------------------------------------
# This script is used to download and install the COSMIC Desktop Components
# from the COPR repository. Since the components are not available as DEB
# packages, we transform the RPM packages to DEB packages using the alien
# tool and install them using dpkg.
#
# Source: https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/
#
# Notes for maintainers:
# - Keep the script up-to-date with the latest versions of the components,
#   do not fill the FILES array following the format: <folder>/<rpm>, no
#   need to include the base URL.
# -----------------------------------------------------------------------------

echo "Obtaining copr2url..."
wget https://github.com/mirkobrombin/copr2url/releases/download/continuous/copr2url -O /tmp/copr2url
chmod +x /tmp/copr2url

echo "Generating list of RPM files..."
FILES=($(/tmp/copr2url /usr/share/cosmic-repos.ini))

echo "Downloading RPM files..."
for file in "${FILES[@]}"; do
  wget "${file}" -P ./rpm_files
done

echo "Installing required tools and dependencies..."
sudo apt-get install -y rpm2cpio alien cpio libdisplay-info-bin libseat1 libxkbcommon0 libinput-bin libinput10 dbus xwayland

echo "Converting and installing RPM files..."
cd ./rpm_files || exit
for rpm in *.rpm; do
  rpm2cpio "$rpm" | cpio -idmv
  sudo alien --scripts --to-deb "$rpm"
done

sudo dpkg -i *.deb
sudo apt-get install -f -y

echo "Installation complete!"