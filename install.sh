#!/bin/bash

#
# Check for root
#
if [ "$EUID" -ne 0 ]
then
  echo "Please run as root"
  exit 1
fi

#
# Package dependencies to download
#
PACKAGES=(
  feh
  vim
  i3
)

aptGetUpdated=false
for pkg in "${PACKAGES[@]}"; do
  if [ $(dpkg-query -W -f='${Status}' $pkg 2>/dev/null | grep -c "ok installed") -eq 0 ]
  then
    if [ !$aptGetUpdated ] # Lazy update apt-get
    then
      sudo apt-get update
    fi
    sudo apt-get install -y $pkg
  fi
done

#
# Symlinks
#
rm -fr ~/Pictures/wallpapers
ln -s $(pwd)/img/wallpapers ~/Pictures/wallpapers

rm -f ~/.vimrc
ln -s $(pwd)/.vimrc ~/.vimrc

rm -f ~/.config/i3/config
ln -s $(pwd)/config ~/.config/i3/config

rm -f ~/.fonts
ln -s $(pwd)/fonts ~/.fonts


#
# Reload things. Order matters, so
# put things at the bottom
#
fc-cache -f -v ~/.fonts

