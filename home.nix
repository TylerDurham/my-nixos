{ config, lib, pkgs, ... }:

{
  imports = [
    ./home/git.nix
    ./home/bash.nix
    ./home/development.nix
    ./home/packages
    ./home/dropbox.nix
    ./home/xdg.nix
    ./home/zsh.nix
    ./home/gtk.nix
  ];

  home.username = "dtd";
  home.homeDirectory = "/home/dtd";
  home.stateVersion = "26.05";

  services.hyprpolkitagent.enable = true;

  home.packages = [
    (pkgs.brave.override {
      commandLineArgs = "--password-store=basic";
    })
  ];
}
