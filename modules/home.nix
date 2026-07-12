{ config, lib, pkgs, ... }:

{
  imports = [
    ./home/git.nix
    ./home/dropbox.nix
    ./home/development.nix
    ./home/xdg.nix
    ./home/gtk.nix
    ./home/shell.nix
  ];

  home.username = "dtd";
  home.homeDirectory = "/home/dtd";
  home.stateVersion = "26.05";
  home.sessionVariables = rec {
    EDITOR = "nvim";
  };

  services.hyprpolkitagent.enable = true;

  home.packages = [
    (pkgs.brave.override {
      commandLineArgs = "--password-store=basic";
    })
  ];
}
