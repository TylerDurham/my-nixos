{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    ghostty
    grimblast
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
    obsidian
    pavucontrol
    pinta
    playerctl
    plex-desktop
    plexamp
    rofi
    rustdesk
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
