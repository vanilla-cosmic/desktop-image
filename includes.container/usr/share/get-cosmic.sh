#!/bin/bash

BASE_URL="https://download.copr.fedorainfracloud.org/results/ryanabx/cosmic-epoch/fedora-41-x86_64"
FILES=(
  "08517080-cosmic-app-library/cosmic-app-library-1.0.0~alpha.5.1%5Egit20250115.647d238-1.fc41.x86_64.rpm"
  "08517066-cosmic-applets/cosmic-applets-1.0.0~alpha.5.1%5Egit20250114.2c79ca4-1.fc41.x86_64.rpm"
  "08517067-cosmic-bg/cosmic-bg-1.0.0~alpha.5.1%5Egit20241009.fd44edf-1.fc41.x86_64.rpm"
  "08544621-cosmic-comp/cosmic-comp-1.0.0~alpha.5.1%5Egit20250118.b87049b-1.fc41.x86_64.rpm"
  "08517069-cosmic-desktop/cosmic-desktop-1.0.0~alpha.5.1%5E20250115-1.fc41.noarch.rpm"
  "08553978-cosmic-edit/cosmic-edit-1.0.0~alpha.5.1%5Egit20250117.3effc64-1.fc41.x86_64.rpm"
  "08517071-cosmic-epoch/cosmic-epoch-1.0.0~alpha.5.1%5E20250115-1.fc41.noarch.rpm"
  "08529528-cosmic-files/cosmic-files-1.0.0~alpha.5.1%5Egit20250116.f883081-1.fc41.x86_64.rpm"
  "08517073-cosmic-greeter/cosmic-greeter-1.0.0~alpha.5.1%5Egit20250114.116ef79-1.fc41.x86_64.rpm"
  "08517072-cosmic-icon-theme/cosmic-icon-theme-1.0.0~alpha.5.1%5Egit20250110.52ad55c-1.fc41.noarch.rpm"
  "08517085-cosmic-idle/cosmic-idle-1.0.0~alpha.5.1%5Egit20241224.7899fcc-1.fc41.x86_64.rpm"
  "08517074-cosmic-launcher/cosmic-launcher-1.0.0~alpha.5.1%5Egit20250114.70153f4-1.fc41.x86_64.rpm"
  "08517075-cosmic-notifications/cosmic-notifications-1.0.0~alpha.5.1%5Egit20250114.5c33113-1.fc41.x86_64.rpm"
  "08524593-cosmic-osd/cosmic-osd-1.0.0~alpha.5.1%5Egit20250116.9b4e2be-1.fc41.x86_64.rpm"
  "08524308-cosmic-panel/cosmic-panel-1.0.0~alpha.5.1%5Egit20250116.fc24dc6-1.fc41.x86_64.rpm"
  "08547541-cosmic-player/cosmic-player-1.0.0~alpha.5.1%5Egit20250119.4fee3f8-1.fc41.x86_64.rpm"
  "08517076-cosmic-randr/cosmic-randr-1.0.0~alpha.5.1%5Egit20250113.da7df14-1.fc41.x86_64.rpm"
  "08517061-cosmic-screenshot/cosmic-screenshot-1.0.0~alpha.5.1%5Egit20250114.10a564d-1.fc41.x86_64.rpm"
  "08517077-cosmic-session/cosmic-session-1.0.0~alpha.5.1%5Egit20250114.6e48e12-1.fc41.x86_64.rpm"
  "08544624-cosmic-settings/cosmic-settings-1.0.0~alpha.5.1%5Egit20250118.9ce8046-1.fc41.x86_64.rpm"
  "08544623-cosmic-settings-daemon/cosmic-settings-daemon-1.0.0~alpha.5.1%5Egit20250118.fe529ae-1.fc41.x86_64.rpm"
  "08517062-cosmic-store/cosmic-store-1.0.0~alpha.5.1%5Egit20250114.6473636-1.fc41.x86_64.rpm"
  "08517063-cosmic-term/cosmic-term-1.0.0~alpha.5.1%5Egit20250114.df1e7dd-1.fc41.x86_64.rpm"
  "08517084-cosmic-wallpapers/cosmic-wallpapers-1.0.0~alpha.5.1%5Egit20241031.cb8e6d6-1.fc41.noarch.rpm"
  "08524595-cosmic-workspaces/cosmic-workspaces-1.0.0~alpha.5.1%5Egit20250116.e3b65d4-1.fc41.x86_64.rpm"
  "08529530-pop-launcher/pop-launcher-1.2.3%5Egit20250117.d458992-1.fc41.x86_64.rpm"
  "08529529-xdg-desktop-portal-cosmic/xdg-desktop-portal-cosmic-1.0.0~alpha.5.1%5Egit20250116.7afb043-1.fc41.x86_64.rpm"
)

echo "Downloading RPM files..."
for file in "${FILES[@]}"; do
  wget "${BASE_URL}/${file}" -P ./rpm_files
done

echo "Installing required tools..."
sudo apt-get install -y rpm2cpio alien cpio

echo "Converting and installing RPM files..."
cd ./rpm_files || exit
for rpm in *.rpm; do
  rpm2cpio "$rpm" | cpio -idmv
  sudo alien --scripts --to-deb "$rpm"
done

sudo dpkg -i *.deb
sudo apt-get install -f -y

echo "Installation complete!"
