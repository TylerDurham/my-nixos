{ config, lib, ... }:

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
  };

}
