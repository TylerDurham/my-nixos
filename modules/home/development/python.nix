{ lib, pkgs, osConfig, ... }:
{
  config = lib.mkIf (osConfig.modules.development.enable or false) {
    home.packages = [
      pkgs.black
      pkgs.isort
      pkgs.python3
      pkgs.uv
    ];
  };
}
