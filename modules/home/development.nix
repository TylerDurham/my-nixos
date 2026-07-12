{ lib, pkgs, osConfig, ... }:

{
  imports = [
    ./development/go.nix
    ./development/node.nix
    ./development/python.nix
  ];

  config = lib.mkIf (osConfig.modules.development.enable or false) {

    home.packages = [
      pkgs.gcc
      pkgs.nixd
      pkgs.github-cli
      pkgs.gnumake
      pkgs.just
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

