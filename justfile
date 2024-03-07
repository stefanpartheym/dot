#
# Settings
#

set dotenv-load

#
# Variables
#

environment := env("DOT_ENVIRONMENT", "desktop")

# Dynamically determine all available packages.
all_packages := if environment == "desktop" {
  "fish git kitty neovim.minimal scripts zellij"
} else {
  "fish git neovim.minimal tmux"
}

#
# Recipes
#

# Show this help message
default:
  just -l

# List available packages
list:
  ls -1 ./packages

# Generate package
generate-pkg PACKAGE:
  if test -f "./packages/{{PACKAGE}}/__gen/generate"; then \
    ./packages/{{PACKAGE}}/__gen/generate; \
  else \
    echo "[WARN] No generator found for package: {{PACKAGE}} => skipping..."; \
  fi

# Generate all packages
generate:
  for pkg in {{all_packages}}; do \
    if test -f "./packages/$pkg/__gen/generate"; then \
      echo "[INFO] Generating package: $pkg"; \
      ( \
        ./packages/$pkg/__gen/generate && \
        echo "[INFO] ${pkg}: Done"; \
      ) || \
      ( \
        errcode=$?; \
        echo "[ERR] ${pkg}: Generating package failed with error code: $errcode"; \
        exit $errcode; \
      ) || \
      exit $?; \
    fi \
  done

# Install package
install-pkg PACKAGE:
  ./stow.sh restow {{PACKAGE}} {{environment}}

# Uninstall package
uninstall-pkg PACKAGE:
  ./stow.sh delete {{PACKAGE}} {{environment}}

# Install all packages
install: generate
  for pkg in {{all_packages}}; do just install-pkg $pkg; done

# Uninstall all packages
uninstall:
  for pkg in {{all_packages}}; do just uninstall-pkg $pkg; done
