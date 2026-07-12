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
      hypridle               # idle daemon for Hyprland (triggers lock/sleep)
      hyprsunset             # blue light filter for Hyprland
      hyprlock               # GPU-accelerated screen locker for Hyprland
      hyprlauncher           # app launcher built for Hyprland
      hyprshutdown           # power menu / shutdown dialog for Hyprland
      waybar                 # highly customizable Wayland status bar
      rofi                   # application launcher and window switcher
    ];
  };

}



# { pkgs, ... }:
#
# {
#   imports = [
#     ./media.nix
#   ];
#
#   home.packages = with pkgs; [
#     brightnessctl
#     ghostty
#     grimblast
#     kitty
#     libappindicator-gtk3
#     libnotify
#     libsecret
#     neovim
#     pavucontrol
#     rofi
#     # rustdesk
#     starship
#     swaynotificationcenter
#     swayosd
#     swww
#     waybar
#     wl-clipboard
#     yazi
#   ];
# }
