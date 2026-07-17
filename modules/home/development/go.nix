{ lib, pkgs, osConfig, ... }:
{
  config = lib.mkIf (osConfig.modules.development.enable or false) {
    home.packages = [
      pkgs.go
      pkgs.gopls
      pkgs.gotools
      pkgs.grc
    ];

    # grc config: main rules file + the go test colorizer it references
    # home.file.".grc/grc.conf".source = ./grc.conf;
    # home.file.".grc/conf.gotest".source = ./conf.gotest;
  };
}
