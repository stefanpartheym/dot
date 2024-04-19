#!/usr/bin/env sh

#
# Installer for default fonts
#

source ./utils.sh

info "Installing default fonts"
$PKG_INSTALL ttf-lato
result

info "Installing default monospaced fonts"
$PKG_INSTALL ttf-hack ttf-fira-code
result

info "Installing nerd fonts symbols"
$PKG_INSTALL ttf-nerd-fonts-symbols
result

info "Installing fonts for emojis support"
$PKG_INSTALL noto-fonts
result
