# dot

Personal dotfiles repository.

> Casually overengineering my dotfiles installation.

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

## Requirements

| Tool                                                 | Command | Description                                                                          |
| ---------------------------------------------------- | ------- | ------------------------------------------------------------------------------------ |
| [GNU stow](https://www.gnu.org/software/stow/)       | `stow`  | Create symlinks for the dotfiles in the target directory.                            |
| [Just command runner](https://github.com/casey/just) | `just`  | Command runner to provide an easy installation interface.                            |
| [Bash shell](https://www.gnu.org/software/bash/)     | `bash`  | Used as script interpreter for generator scripts of certain dotfiles like gitconfig. |
| [find](https://www.gnu.org/software/bash/)           | `find`  | Used to dynamically determine all packages that need to be generated.                |
