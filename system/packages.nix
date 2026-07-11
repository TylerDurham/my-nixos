{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    bat
    curl
    fzf
    gnome-keyring
    gvfs
    gzip
    hypridle
    hyprsunset
    hyprlock
    imagemagick
    matugen
    jq
    lsd
    nerd-fonts.jetbrains-mono
    power-profiles-daemon
    go
    nixd
    nixfmt-rfc-style
    nodejs
    python3
    tree-sitter
    ripgrep
    stow
    tmux
    vim
    wget
    xdg-terminal-exec
    zoxide
    unzip
  ];
}
