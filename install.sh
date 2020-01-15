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
  zsh
  curl
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
 
    # Install oh-my-zsh if we are installing zsh
    if [ "$pkg" = "zsh" ]
    then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
  fi
done

#
# Symlinks
#
rm -fr ~/Pictures/wallpapers
ln -s $(pwd)/img/wallpapers ~/Pictures/wallpapers

rm -f ~/.vimrc
ln -s $(pwd)/.vimrc ~/.vimrc

rm -f ~/.zshrc
ln -s $(pwd)/.zshrc ~/.zshrc

rm -f ~/.config/i3/config
ln -s $(pwd)/i3-config ~/.config/i3/config

mkdir -p ~/.config/i3status
rm -f ~/.config/i3status/config
ln -s $(pwd)/i3status-config ~/.config/i3status/config

rm -f ~/.fonts
ln -s $(pwd)/fonts ~/.fonts


#
# Reload things. Order matters, so
# put things at the bottom
#
fc-cache -f -v ~/.fonts  # Reload font cache
chsh -s $(which zsh)  # Set default terminal as zsh
i3-msg restart  # Reset i3
setxkbmap -layout us -option ctrl:nocaps  # Remap capslock to ctrl

#
# Check tings we can't do from the script
# i.e. to fix in the future
#
if [ "$SHELL" != "/usr/bin/zsh" ]
then
  echo "Set the default terminal as zsh by executing the following command"
  echo "(not as root)"
  echo "chsh -s \$(which zsh)"
fi
