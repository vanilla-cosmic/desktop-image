#!/usr/bin/bash

deb_urls=$(bash get-cosmic-deb-urls.sh)

mkdir -p deb_files
cd deb_files || exit

for url in $deb_urls; do
  wget "$url"
done

sudo dpkg -i ./*.deb
sudo apt-get -f install -y
