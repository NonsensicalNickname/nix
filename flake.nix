{
    description = "gay little system";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        niri.url = "github:sodiboo/niri-flake";
        niri.inputs.nixpkgs.follows = "nixpkgs";

        ironbar.url = "github:JakeStanger/ironbar";
        ironbar.inputs.nixpkgs.follows = "nixpkgs";

        nvf.url = "github:NotAShelf/nvf";
        nvf.inputs.nixpkgs.follows = "nixpkgs";

        sops-nix.url = "github:Mic92/sops-nix";
        sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs : {
        nixosConfigurations.nix-goose = nixpkgs.lib.nixosSystem {
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        extraSpecialArgs = { inherit inputs; };
                        users.ceri = ./home.nix; 
                    };
                }
            ];
        };
    };
}
