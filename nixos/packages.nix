{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    bat
    curl
    fzf
    hypridle
    hyprsunset
    hyprlock
    jq
    lsd
    nerd-fonts.jetbrains-mono
    ripgrep
    stow
    tmux
    vim
    wget
    zoxide
  ];
}
