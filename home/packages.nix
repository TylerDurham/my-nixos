{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
    hyprlauncher
    hyprshutdown
    kitty
    nautilus
    neovim
    nwg-look
    rofi
    starship
    swww
    swayosd
    swaynotificationcenter
    waybar
    wl-clipboard
  ];
}
