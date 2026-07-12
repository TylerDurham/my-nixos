{ lib, pkgs, osConfig, ... }:

{
  config = lib.mkIf (osConfig.modules.development.enable or false) {

    programs.zsh.initContent = ''
        eval "$(mise activate zsh)"
    '';

    programs.bash.initExtra = ''
        eval "$(mise activate bash)"
    '';
    home.packages = [
      pkgs.github-cli
      pkgs.bun
      pkgs.uv
      pkgs.tree-sitter
      pkgs.stylua
      pkgs.mise
    ];

  };
}

# # TODO: Need to add this to modules
# { pkgs, ... }:
#
# {
#   imports = [
#     ./mise.nix
#   ];
#
#   home.packages = [
#     pkgs.github-cli
#     pkgs.tree-sitter
#     pkgs.bun
#     pkgs.uv
#     pkgs.nodejs_22
#     pkgs.stylua
#   ];
# }
