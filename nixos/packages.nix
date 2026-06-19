{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
  nerd-fonts.jetbrains-mono
];
  environment.systemPackages = with pkgs; [
    bat
    curl
    fzf
    ghostty
    hyprlauncher
    hyprshutdown
    kitty
    nerd-fonts.jetbrains-mono
    lsd
    nautilus
    neovim
    nwg-look
    ripgrep
    rofi
    starship
    stow
    swww
    swayosd
    swaynotificationcenter
    terminus_font
    tmux
    vim
    waybar
    wget
    wl-clipboard
  ];
}
