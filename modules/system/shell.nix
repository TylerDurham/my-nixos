{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bat
    starship
    curl
    fzf
    gvfs
    lsd
    neovim
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
