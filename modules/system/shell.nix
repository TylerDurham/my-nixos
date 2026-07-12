{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bat
    starship
    curl
    fzf
    gvfs
    lsd
    neovim                    # extensible terminal text editor
    ripgrep
    stow
    tmux
    tree
    vim
    wget
    yazi
    zoxide
  ];
}
