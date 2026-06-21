{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    ghostty
    hyprlauncher
    hyprshutdown
    inotify-tools
    kitty
    libappindicator-gtk3
    libnotify
    libsecret
    nautilus
    neovim
    nwg-look
    pavucontrol
    playerctl
    plex-desktop
    plexamp
    rofi
    signal-desktop
    spotify
    starship
    swaynotificationcenter
    swayosd
    swww
    waybar
    wl-clipboard
  ];
  
}
