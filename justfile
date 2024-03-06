#
# Recipes
#

stow_ignore := "__gen$"
stow_source := "./packages"
stow_target := env_var("HOME")
stow_command := "stow --ignore='" + stow_ignore + "'" + " --dir=" + stow_source + " --target=" + stow_target

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
  {{stow_command}} --restow *

# Uninstall all packages
uninstall:
  {{stow_command}} --delete *

# Configure package
configure-pkg PACKAGE:
  ./packages/{{PACKAGE}}/__gen/generate
