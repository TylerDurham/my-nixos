{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # environment.systemPackages = with pkgs; [
  #   # bat
  #   # curl
  #   # fzf
  #   # gnome-keyring
  #   # gvfs
  #   # gzip
  #   # imagemagick
  #   # matugen
  #   # jq
  #   # lsd
  #   # power-profiles-daemon
  #   # go
  #   # nixd
  #   # nixfmt-rfc-style
  #   # nodejs
  #   # python3
  #   # tree-sitter
  #   # ripgrep
  #   # stow
  #   # tmux
  #   # vim
  #   # wget
  #   # zoxide
  #   # unzip
  # ];
}
