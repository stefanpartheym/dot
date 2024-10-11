#!/usr/bin/env sh

#
# Installer for additional tools (nvim, zellij, tmux, ...).
#

source ./utils.sh

test -f ./.env && source ./.env
test -z "$DOT_ENVIRONMENT" && DOT_ENVIRONMENT="desktop"

#-------------------------------------------------------------------------------

# Specific for linux systems:
# Install xclip clipboard tool
if test $PLATFORM_LINUX -eq 1; then
  info "Installing xclip (clipboard tool)"
  $PKG_INSTALL xclip
  result
fi

info "Installing stow (symlink farm manager)"
$PKG_INSTALL stow
result

info "Installing fzf (fuzzy finder)"
$PKG_INSTALL fzf
result

info "Installing zoxide (replacement for cd)"
$PKG_INSTALL zoxide
result

info "Installing eza (replacement for ls)"
$PKG_INSTALL eza
result

info "Installing bat (replacement for cat)"
$PKG_INSTALL bat
result

info "Installing fd (replacement for locate)"
$PKG_INSTALL fd
result

info "Installing ripgrep (replacement for grep)"
$PKG_INSTALL ripgrep
result

info "Installing jq (Command-line JSON processor)"
$PKG_INSTALL jq
result

info "Installing delta (git diff pager)"
$PKG_INSTALL git-delta
result

info "Installing yazi and dependencies (cli file manager)"
$PKG_INSTALL yazi unarchiver ffmpegthumbnailer poppler
result

info "Installing neovim (replacement for vim)"
$PKG_INSTALL neovim
result

info "Installing glow (markdown viewer)"
$PKG_INSTALL glow
result

# Conditionally install software in `server` and `desktop` environments.
if [ "$DOT_ENVIRONMENT" == "server" ]; then
  info "Installing tmux"
  $PKG_INSTALL tmux
  result
else
  info "Installing zellij"
  $PKG_INSTALL zellij
  result

  info "Installing starship prompt"
  $PKG_INSTALL starship
  result

  info "Installing pass (password-store)"
  $PKG_INSTALL pass pass-otp pass-ln browserpass browserpass-chromium
  result
fi
