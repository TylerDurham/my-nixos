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
    pavucontrol
    plexamp
    plex-desktop
    rofi
    spotify
    starship
    swaynotificationcenter
    swayosd
    swww
    waybar
    wl-clipboard
  ];
}
