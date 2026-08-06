{
    description = "gay little system";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

        flake-parts.url = "github:hercules-ci/flake-parts";
        flake-parts.inputs.nixpkgs.follows = "nixpkgs";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        niri.url = "github:sodiboo/niri-flake";
        niri.inputs.nixpkgs.follows = "nixpkgs";

        nvf.url = "github:NotAShelf/nvf";
        nvf.inputs.nixpkgs.follows = "nixpkgs";

        fenix.url = "github:nix-community/fenix";
        fenix.inputs.nixpkgs.follows = "nixpkgs";

        sops-nix.url = "github:Mic92/sops-nix";
        sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs =
        inputs:
        inputs.flake-parts.lib.mkFlake { inherit inputs; } {
            systems = [ "x86_64-linux" ];

            imports = [
                ./hosts
            ];
        };
}
