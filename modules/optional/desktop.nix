{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.desktop;
in
{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./hyprland.nix
  ];

  options.modules.desktop = {
    enable = mkEnableOption "Desktop packages and services.";
  };

  config = mkIf cfg.enable {
    modules.hyprland.enable = true;
    modules.bluetooth.enable = true;
    modules.audio.enable = true;
  };
}

