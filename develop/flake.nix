{
  description = "Development flake for Team3132 comp-robot";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let 
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
        devShells."x86_64-linux".default = pkgs.mkShell rec {
            buildInputs = with pkgs; [
                openjdk17
            ];

            LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";
            JAVA_HOME = "${pkgs.openjdk17}";
        };
  };
}
