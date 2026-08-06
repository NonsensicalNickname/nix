{ inputs, ... }:
{
    imports =
        with inputs;
        [
            niri.homeModules.niri
            nvf.homeManagerModules.default
            sops-nix.homeManagerModules.sops
        ]
        ++ [
            ./packages.nix
            ./programs.nix
            ./services.nix
            ./misc.nix
            ./config
        ];

    config.home = {
        username = "ceri";
        homeDirectory = "/home/ceri";
        stateVersion = "25.11";

        sessionVariables = {
            EDITOR = "nvim";
            BROWSER = "librewolf";
            TERMINAL = "foot";
        };
    };
}
