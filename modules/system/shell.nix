{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bat                       # cat clone with syntax highlighting and git integration
    curl                      # command-line tool for transferring data via URLs
    envsubst
    fzf                       # command-line fuzzy finder
    gvfs                      # virtual filesystem for GNOME (trash, mtp, network mounts, etc.)
    lsd                       # modern ls replacement with icons and colors
    neovim                    # extensible terminal text editor
    ripgrep                   # fast recursive grep alternative (rg)
    starship                  # fast, customizable shell prompt
    stow                      # symlink farm manager for dotfiles
    tmux                      # terminal multiplexer
    tree                      # recursive directory listing as a tree
    vim                       # classic terminal text editor
    wget                      # command-line tool for downloading files
    yazi                      # fast terminal file manager
    zoxide                    # smarter cd that learns your frequently used directories
  ];
}
