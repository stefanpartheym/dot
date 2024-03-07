#!/usr/bin/env sh

cmd="$1"
pkg="$2"
env="$3"

source_path="./packages"
ignore_pattern='__hooks$'

pkg_path="${source_path}/${pkg}"
pkg_configure_path="${pkg_path}/__hooks/configure"

if test -f "$pkg_configure_path"; then
  # Sourcing the configuration script will set $DOT_PKG_TARGET.
  source $pkg_configure_path $env || exit $?
else
  # Set default target directory, if no configuration script exists.
  DOT_PKG_TARGET="$HOME"
fi

# Make sure the target directory exists.
mkdir -p "$DOT_PKG_TARGET"

stow \
  --ignore="$ignore_pattern" \
  --dir="$source_path" \
  --target="$DOT_PKG_TARGET" \
  --$cmd \
  $pkg
