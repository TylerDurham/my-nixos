# TODO: Need to add this to modules
{ pkgs, ... }:

{
  home.packages = [
    pkgs.github-cli
    pkgs.bun
    pkgs.uv
    pkgs.nodejs_22
    pkgs.stylua
  ];
}
