{ pkgs, ... }:

{
  imports = [
    ./media.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    ghostty
    grimblast
    kitty
    libappindicator-gtk3
    libnotify
    libsecret
    neovim
    pavucontrol
    rofi
    # rustdesk
    starship
    swaynotificationcenter
    swayosd
    swww
    waybar
    wl-clipboard
    yazi
  ];
}
