{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    ghostty
    grimblast
    # handbrake
    hyprlauncher
    hyprshutdown
    inotify-tools
    kitty
    libappindicator-gtk3
    libnotify
    libsecret
    # makemkv
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
    vlc
    waybar
    wl-clipboard
  ];
  
}
