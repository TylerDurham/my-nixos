{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.mise;
in
{
  options.modules.mise = {
    enable = mkEnableOption "mise dev tool version manager";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.mise ];
    home-manager.users.dtd.programs.zsh.initContent = ''
      eval "$(mise activate zsh)"
    '';
  };
}
