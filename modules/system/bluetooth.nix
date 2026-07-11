{ pkgs, config, lib, ... }:

with lib;

let
  cfg = config.modules.bluetooth;
in
{
  options.modules.bluetooth = {
    enable = mkEnableOption "Bluetooth services and apps.";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;

    services.blueman.enable = true;

    environment.systemPackages = with pkgs; [
      blueman
    ];
  };
}
