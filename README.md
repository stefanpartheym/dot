> [!WARNING]
> This repository is deprecated. Use [stefanpartheym/dotfiles](https://github.com/stefanpartheym/dotfiles) instead.

# dot

Personal dotfiles repository.

> Casually overengineering my dotfiles installation.

## Generating dotfiles

Some dotfiles are based on a template (The `.gitconfig` for instance). Thus, it is necessary to generate them. The `just install` command will automatically trigger the generation process.

However, if you want to manually generate them, use the following commands:

```sh
# Generate all dotfiles packages
just generate

# Generate a certain dotfiles package
just generate-pkg PACKAGE_NAME
```

## Install dotfiles

```sh
# Install all dotfiles packages
just install

# Install all a certain dotfiles package
just install-pkg PACKAGE_NAME
```

For more information about the available commands run:

```sh
just -l
```

## Install default shell, fonts and additional CLI tools

```sh
# Install default shell (fish)
./install-shell.sh

# Install additional CLI tools (nvim, tmux, zellij, etc.)
./install-tools.sh

# Install default fonts (Fira Code, Hack, Lato, etc.)
./install-fonts.sh
```

## Requirements

The following tools are required on your system to install the dotfiles:

| Tool                                                 | Command |
| ---------------------------------------------------- | ------- |
| [Just command runner](https://github.com/casey/just) | `just`  |
| [GNU stow](https://www.gnu.org/software/stow/)       | `stow`  |
| [GNU sed](https://www.gnu.org/software/sed/)         | `sed`   |
