#
# Settings
#

set dotenv-load

#
# Variables
#

environment := env("DOT_ENVIRONMENT", "desktop")

# Set default packages, that apply to all environments.
default_packages := "fish starship git neovim.minimal"
# Set all available packages in given environment.
all_packages := if environment == "desktop" {
  default_packages + " zellij kitty ghostty scripts"
} else {
  default_packages + " tmux"
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
  ./generate.sh single {{PACKAGE}} {{environment}}

# Generate all packages
generate:
  ./generate.sh multi "{{all_packages}}" {{environment}}

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
