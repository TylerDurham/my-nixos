{ lib, pkgs, osConfig, ... }:
{
  config = lib.mkIf (osConfig.modules.development.enable or false) {
    home.packages = [
      pkgs.go
      pkgs.gopls
      pkgs.gotools
    ];
  };
}
