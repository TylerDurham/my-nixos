{ config, lib, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./development.nix
    # ./packages
    ./dropbox.nix
    # ./packages/devices.nix
    ./xdg.nix
    ./gtk.nix
    ./shell.nix
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
