{ config, lib, pkgs, ... }:

{
  imports = [
      ./home/git.nix
      ./home/desktop.nix
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

	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo 'I use NixOS, btw...'";
            rebuild-nix = "sudo nixos-rebuild switch --flake $HOME/Projects/my-nixos#nixos";
		};
	};
}
