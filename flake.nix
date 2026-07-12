{
	description = "Hyprland on NixOS";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
	let
    inherit (nixpkgs) lib;
    hostname = import ./hostname.nix;

		mkHost = hostname: cfg: nixpkgs.lib.nixosSystem {
			system = cfg.system;
			specialArgs = { inherit inputs nixpkgs hostname; };
			modules = [
				./configuration.nix
				{ modules = cfg.modules or {}; }
				./modules/desktop/_desktop.nix
				./modules/optional/docker.nix
				./modules/optional/mise.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.dtd = import ./modules/home/_home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	in {
    nixosConfigurations = lib.mapAttrs mkHost (import ./hosts.nix);
	};
}
