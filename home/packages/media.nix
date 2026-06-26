{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # handbrake
    # makemkv
    imv
    mpv
    pinta
    playerctl
    plex-desktop
    plexamp
    spotify
    vlc
  ];
}
