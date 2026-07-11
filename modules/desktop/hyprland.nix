{ config, lib, pkgs, ... }:

with lib;

let 
  cfg = config.modules.hyprland;  
in
{

  options.modules.hyprland = {
    enable = mkEnableOption "Hyprland desktop environment.";
  };

  config = mkIf cfg.enable {

    services.libinput.enable = true;

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      hypridle
      hyprsunset
      hyprlock
      hyprlauncher
      hyprshutdown
    ];
  };

}
