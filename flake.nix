{
	description = "Hyprland on NixOS";
	
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
            # nixpkgs.config.allowFreePredicate = (pkg: true);
            specialArgs = { inherit nixpkgs; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager 
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.dtd = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];	
		};	
	};
}
