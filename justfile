#
# Variables
#

stow_target := env("HOME")
stow_command := "stow --ignore='__gen$' --dir=./packages --target=" + stow_target

# Dynamically determine all available packages.
all_packages := trim(`ls -1 ./packages | tr '\n' ' '`)

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
generate PACKAGE:
  if test -f "./packages/{{PACKAGE}}/__gen/generate"; then \
    ./packages/{{PACKAGE}}/__gen/generate; \
  else \
    echo "No generator found for package: {{PACKAGE}} => skipping..."; \
  fi

# Generate all packages
generate-all:
  for generator in `find ./packages -type f -wholename "./packages/*/__gen/generate"`; do \
    echo "# RUNNING GENERATOR: $generator"; \
    $generator && \
    echo "=> SUCCESS"; \
  done

# Install package
install PACKAGE:
  {{stow_command}} --restow {{PACKAGE}}

# Uninstall package
uninstall PACKAGE:
  {{stow_command}} --delete {{PACKAGE}}

# Install all packages
install-all: generate-all
  {{stow_command}} --restow {{all_packages}}

# Uninstall all packages
uninstall-all:
  {{stow_command}} --delete {{all_packages}}
