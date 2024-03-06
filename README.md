# dot

> Personal dotfiles repository.

## Requirements

| Tool                                                 | Command | Description                                                        |
| ---------------------------------------------------- | ------- | ------------------------------------------------------------------ |
| [GNU stow](https://www.gnu.org/software/stow/)       | `stow`  | Create symlinks for the dotfiles in the target directory.          |
| [Just command runner](https://github.com/casey/just) | `just`  | Tool to run the installation commands for the individual dotfiles. |

### Install requirements

| Package manager | Command               |
| --------------- | --------------------- |
| pacman          | `pacman -S stow just` |
| yay             | `yay -S stow just`    |
