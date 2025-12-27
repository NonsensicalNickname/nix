{
	description = "gay little system";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	};

	outputs = { self, nixpkgs }: {
		nixosConfigurations.nix-goose = nixpkgs.lib.nixosSystem {
			modules = [ ./configuration.nix ];
		};
	};
}
