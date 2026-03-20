{
	description = "PieriNixOS";

	inputs = {
		# Repo oficial de pacotes nixos
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

		# Home Manager
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Stylix para temas centralizados
		stylix = {
			url = "github:danth/stylix/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs: {
		nixosConfigurations.pieri-notebook = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				# Configuration.nix
        ./configuration.nix
        {
          nixpkgs.config.allowUnfree = true;
        }

				# Stylix
				stylix.nixosModules.stylix

				# Home Manager como modulo
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.sharedModules = [
						stylix.homeModules.stylix
          ];

					home-manager.users.pieri = import ./home.nix;
				}
			];
		};
	};
}
