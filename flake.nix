{
	description = "Hyprland on NixOS";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		my-mvc-vim = {
			url = "github:TylerDurham/my-mvc.vim";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
	let
    inherit (nixpkgs) lib;
    hostname = import ./hostname.nix;
    username = "dtd";

		mkHost = hostname: cfg: nixpkgs.lib.nixosSystem {
			system = cfg.system;
			specialArgs = { inherit inputs nixpkgs hostname username; };
			modules = [
				./configuration.nix
				{ modules = cfg.modules or {}; }
				./modules/desktop.nix
				./modules/system/development.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.${username} = import ./modules/home.nix;
						extraSpecialArgs = { inherit username inputs; };
						backupFileExtension = "backup";
					};
				}
			];
		};
	in {
    nixosConfigurations = lib.mapAttrs mkHost (import ./hosts.nix);
	};
}
