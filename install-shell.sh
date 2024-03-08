#!/usr/bin/env sh

#
# Installer for the fish shell.
#

source ./utils.sh

info "Installing fish shell"
$PKG_INSTALL fish
result

fish_path=$(which fish)

info "Configuring fish as default shell for current user"
cat /etc/shells | grep fish >/dev/null ||
  sudo sh -c "echo \"$fish_path\" >> /etc/shells" &&
  chsh -s $fish_path
result
