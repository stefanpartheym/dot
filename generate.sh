#!/usr/bin/env sh

source ./utils.sh

mode="$1"
pkgs="$2"
env="$3"

source_path="./packages"

case "$mode" in
"multi")
  generate_pkgs=$(prompt "Generate all packages?" "n")
  ;;
"single")
  generate_pkgs=$(prompt "Generate package ${pkgs}?" "n")
  ;;
*)
  generate_pkgs="y"
  ;;
esac

if [ "$generate_pkgs" == "y" ]; then
  for pkg in $pkgs; do
    pkg_path="${source_path}/${pkg}"
    pkg_generate_path="${pkg_path}/__hooks/generate"
    if test -f "$pkg_generate_path"; then
      info "Generating package: $pkg"
      (
        $pkg_generate_path &&
          info "${pkg}: Done"
      ) ||
        (
          errcode=$?
          error "${pkg}: Generating package failed with error code: $errcode" $errcode
        ) ||
        exit $?
    elif [ "$mode" == "single" ]; then
      warn "No generator found for package: ${pkg} => skipping..."
    fi
  done
fi
