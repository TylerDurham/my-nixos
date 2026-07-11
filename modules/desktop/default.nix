{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.desktop;
in
{
  imports = [
    ../system/audio.nix
    ../system/bluetooth.nix
    ../system/plymouth.nix
    ./hyprland.nix
  ];

  options.modules.desktop = {
    enable = mkEnableOption "Desktop packages and services.";
  };

  config = mkIf cfg.enable {
    modules.hyprland.enable = true;
    modules.bluetooth.enable = true;
    modules.audio.enable = true;

    environment.systemPackages = with pkgs; [
      inotify-tools
      nautilus
      nerd-fonts.jetbrains-mono
      nwg-look
      obsidian
      signal-desktop
      xdg-terminal-exec
    ];
  };

}

