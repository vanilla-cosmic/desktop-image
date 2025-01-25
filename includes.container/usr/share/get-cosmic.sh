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

BASE_URL="https://download.copr.fedorainfracloud.org/results/ryanabx/cosmic-epoch/fedora-41-x86_64"
FILES=(
  # cosmic-app-library
  "08517080-cosmic-app-library/cosmic-app-library-1.0.0~alpha.5.1%5Egit20250115.647d238-1.fc41.x86_64.rpm"

  # cosmic-applets
  "08568688-cosmic-applets/cosmic-applets-1.0.0~alpha.5.1%5Egit20250124.726c828-1.fc41.x86_64.rpm"

  # cosmic-bg
  "08517067-cosmic-bg/cosmic-bg-1.0.0~alpha.5.1%5Egit20241009.fd44edf-1.fc41.x86_64.rpm"

  # cosmic-calendar
  "08544621-cosmic-comp/cosmic-comp-1.0.0~alpha.5.1%5Egit20250118.b87049b-1.fc41.x86_64.rpm"

  # cosmic-desktop
  "08517069-cosmic-desktop/cosmic-desktop-1.0.0~alpha.5.1%5E20250115-1.fc41.noarch.rpm"

  # cosmic-dock
  "08553978-cosmic-edit/cosmic-edit-1.0.0~alpha.5.1%5Egit20250117.3effc64-1.fc41.x86_64.rpm"

  # cosmic-epoch
  "08517071-cosmic-epoch/cosmic-epoch-1.0.0~alpha.5.1%5E20250115-1.fc41.noarch.rpm"

  # cosmic-files
  "08568685-cosmic-files/cosmic-files-1.0.0~alpha.5.1%5Egit20250124.ceab783-1.fc41.x86_64.rpm"

  # cosmic-greeter
  "08568686-cosmic-greeter/cosmic-greeter-1.0.0~alpha.5.1%5Egit20250124.5527c9b-1.fc41.x86_64.rpm"

  # cosmic-icon-theme
  "08517072-cosmic-icon-theme/cosmic-icon-theme-1.0.0~alpha.5.1%5Egit20250110.52ad55c-1.fc41.noarch.rpm"

  # cosmic-idle
  "08517085-cosmic-idle/cosmic-idle-1.0.0~alpha.5.1%5Egit20241224.7899fcc-1.fc41.x86_64.rpm"

  # cosmic-launcher
  "08565562-cosmic-launcher/cosmic-launcher-1.0.0~alpha.5.1%5Egit20250123.538d391-1.fc41.x86_64.rpm"

  # cosmic-notifications
  "08517075-cosmic-notifications/cosmic-notifications-1.0.0~alpha.5.1%5Egit20250114.5c33113-1.fc41.x86_64.rpm"

  # cosmic-osd
  "08524593-cosmic-osd/cosmic-osd-1.0.0~alpha.5.1%5Egit20250116.9b4e2be-1.fc41.x86_64.rpm"

  # cosmic-panel
  "08565563-cosmic-panel/cosmic-panel-1.0.0~alpha.5.1%5Egit20250123.107f597-1.fc41.x86_64.rpm"

  # cosmic-player
  "08568690-cosmic-player/cosmic-player-1.0.0~alpha.5.1%5Egit20250124.63735cd-1.fc41.x86_64.rpm"

  # cosmic-randr
  "08517076-cosmic-randr/cosmic-randr-1.0.0~alpha.5.1%5Egit20250113.da7df14-1.fc41.x86_64.rpm"

  # cosmic-screenshot
  "08517061-cosmic-screenshot/cosmic-screenshot-1.0.0~alpha.5.1%5Egit20250114.10a564d-1.fc41.x86_64.rpm"

  # cosmic-session
  "08517077-cosmic-session/cosmic-session-1.0.0~alpha.5.1%5Egit20250114.6e48e12-1.fc41.x86_64.rpm"

  # cosmic-settings
  "08565566-cosmic-settings/cosmic-settings-1.0.0~alpha.5.1%5Egit20250123.6f05e9e-1.fc41.x86_64.rpm"

  # cosmic-settings-daemon
  "08544623-cosmic-settings-daemon/cosmic-settings-daemon-1.0.0~alpha.5.1%5Egit20250118.fe529ae-1.fc41.x86_64.rpm"

  # cosmic-store
  "08517062-cosmic-store/cosmic-store-1.0.0~alpha.5.1%5Egit20250114.6473636-1.fc41.x86_64.rpm"

  # cosmic-term
  "08565567-cosmic-term/cosmic-term-1.0.0~alpha.5.1%5Egit20250123.23a5851-1.fc41.x86_64.rpm"

  # cosmic-wallpapers
  "08568903-cosmic-wallpapers/cosmic-wallpapers-1.0.0~alpha.5.1%5Egit20241031.cb8e6d6-1.fc41.noarch.rpm"

  # cosmic-workspaces
  "08568687-cosmic-workspaces/cosmic-workspaces-1.0.0~alpha.5.1%5Egit20250124.88b35e3-1.fc41.x86_64.rpm"

  # pop-launcher
  "08529530-pop-launcher/pop-launcher-1.2.3%5Egit20250117.d458992-1.fc41.x86_64.rpm"

  # xdg-desktop-portal-cosmic
  "08561064-xdg-desktop-portal-cosmic/xdg-desktop-portal-cosmic-1.0.0~alpha.5.1%5Egit20250122.e76630c-1.fc41.x86_64.rpm")

echo "Downloading RPM files..."
for file in "${FILES[@]}"; do
  wget "${BASE_URL}/${file}" -P ./rpm_files
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
