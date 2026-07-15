{ config, lib, pkgs, username, ... }:

{
  imports = [
    ./home/git.nix
    ./home/dropbox.nix
    ./home/development.nix
    ./home/vim.nix
    ./home/xdg.nix
    ./home/gtk.nix
    ./home/shell.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
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
