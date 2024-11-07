#
# Bootstrap package manager
#
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c "fisher update"
end

#
# Setup keybindings
#

# <C-y> Accept completion with
bind \cy accept-autosuggestion

#
# Setup environment
#

# Setup starship prompt
if type -q starship
    starship init fish | source
    enable_transience
end

# Disable fish greeting
set fish_greeting

# Configure environment variables
fish_add_path $HOME/.local/bin
set -gx EDITOR nvim

#
# Setup tools
#

# Git
if type -q git
    alias gs="git status"
    alias gb="git branch"
    if type -q fzf
        alias gl="git log --oneline | fzf"
    else
        alias gl="git log --format=oneline --decorate"
    end
    alias gcm="git commit -m"
    alias gd="git diff"
    function gdd --wraps='git difftool -d' --description 'alias gdd=git difftool -d'
        git difftool -d $argv &
    end
    # Aliases for git extensions (stefanpartheym/fish-git-extensions.git)
    alias gcob="gitext_checkout"
    alias gadd="gitext_add"
end

# Docker
if type -q docker-compose
    alias dc="docker-compose"
end

# Kubernetes
if type -q kubectl
    alias kc="kubectl"
end

# eza
if type -q eza
    alias ls="eza --icons"
    alias la="ls -la"
end

# fzf
if type -q fzf
    fzf --fish | source
end

# Tmux
if type -q tmux
    # Create or attach to the default session
    function td --description 'Open tmux default session'
        set -l session_name default
        if tmux ls 2>/dev/null | cut -d ':' -f 1 | grep -qE "^$session_name\$"
            tmux attach -t "$session_name"
        else
            tmux new -s "$session_name"
        end
    end
end

# Zoxide
if type -q zoxide
    # Initialize zoxide.
    # HINT: Use flag `--no-cmd` to init without creating `z` and `zi` aliases.
    zoxide init fish | source
end

# Zellij
if type -q zellij
    # Setup command to attach to defeault session.
    alias zd="zellij a -c default"
    # Setup function to launch a zellij session in the current working directory.
    function zell \
        -a layout \
        -d 'start zellij in current working directory and set session name accordingly'
        set -l session_name $(basename $(pwd))
        if test -z "$layout"
            zellij -s $session_name
        else
            zellij -s $session_name -l $layout
        end
    end
end

#
# Load custom config
#
if test -f ~/.config/fish/custom.fish
    source ~/.config/fish/custom.fish
end
