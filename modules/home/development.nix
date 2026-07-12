{ lib, pkgs, osConfig, ... }:

{
  config = lib.mkIf (osConfig.modules.development.enable or false) {

    home.packages = [
      pkgs.bun
      pkgs.gcc
      pkgs.github-cli
      pkgs.gnumake
      pkgs.go
      pkgs.just
      pkgs.nodejs
      pkgs.python3
      pkgs.stylua
      pkgs.tree-sitter
      pkgs.uv
    ];

    programs.mise = {
      enable = true;
    };

    programs.zsh.initContent = ''
      eval "$(mise activate zsh)"
    '';

    programs.bash.initExtra = ''
      eval "$(mise activate bash)"
    '';
  };
}

