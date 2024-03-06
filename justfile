#
# Recipes
#

stow_target := env("HOME")
stow_command := "stow --ignore='__gen$' --dir=./packages --target=" + stow_target

all_packages := `ls -1 ./packages | tr '\n' ' '`

# Show this help message
default:
  just -l

# List available packages
list:
  ls -1 ./packages

# Install package
install-pkg PACKAGE:
  {{stow_command}} --restow {{PACKAGE}}

# Uninstall package
uninstall-pkg PACKAGE:
  {{stow_command}} --delete {{PACKAGE}}

# Install all packages
install:
  {{stow_command}} --restow {{all_packages}}

# Uninstall all packages
uninstall:
  {{stow_command}} --delete {{all_packages}}

# Generate package
generate PACKAGE:
  ./packages/{{PACKAGE}}/__gen/generate
