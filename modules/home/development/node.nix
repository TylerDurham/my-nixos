{ lib, pkgs, osConfig, ... }:
{
  config = lib.mkIf (osConfig.modules.development.enable or false) {
    home.packages = [
      pkgs.nodejs
      pkgs.prettier
      pkgs.bun
    ];
  };
}
