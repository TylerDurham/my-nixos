{ pkgs, ... }:

{
  imports = [
    ./media.nix
  ];

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
    rofi
    rustdesk
    signal-desktop
    starship
    swaynotificationcenter
    swayosd
    swww
    waybar
    wl-clipboard
  ];
}
