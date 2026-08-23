{
    description = "gay little system";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

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

        agenix.url = "github:ryantm/agenix";
        agenix.inputs.nixpkgs.follows = "nixpkgs";

        frc-nix.url = "github:frc4451/frc-nix";
        frc-nix.inputs.nixpkgs.follows = "nixpkgs";
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
