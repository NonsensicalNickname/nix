{
	description = "A NixOS system that aims to be gay";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = { self, nixpkgs, ... }@inputs:
		let 
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};

		userSettings = {
			theme = "catppuccin-macchiato";
			font = "jetbrains-mono";
		};

		in {
			nixosConfigurations.nix-goose = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [ 
					./configuration.nix
					inputs.home-manager.nixosModules.default
				];
			};

			#homeConfigurations.nix-goose 
		};
}
