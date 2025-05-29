{
	description = "System config for what currently lives in a VM";

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

		in {
			nixosConfigurations.nix-goose = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [ 
					./configuration.nix
					inputs.home-manager.nixosModules.default
				];
			};
		};
}
