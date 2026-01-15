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

        # nix-ld.url = "github:Mic92/nix-ld";
        # nix-ld.inputs.nixpkgs.follows = "nixpkgs";

        fenix.url = "github:nix-community/fenix";
        fenix.inputs.nixpkgs.follows = "nixpkgs";

        sops-nix.url = "github:Mic92/sops-nix";
        sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, fenix, ... }@inputs : {
        nixosConfigurations.goose = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
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
                # nix-ld.nixosModules.nix-ld
                ({ pkgs, ... }: {
                    nixpkgs.overlays = [ fenix.overlays.default ];
                    environment.systemPackages = [
                        (pkgs.fenix.complete.withComponents [
                            "cargo"
                            "clippy"
                            "rust-src"
                            "rustc"
                            "rustfmt"
                        ])
                        pkgs.rust-analyzer
                    ];
                })
            ];
        };
    };
}
