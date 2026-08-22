{ inputs, ... }:
{
    imports =
        with inputs;
        [
            niri.homeModules.niri
            nvf.homeManagerModules.default
        ]
        ++ [
            ./packages.nix
            ./programs.nix
            ./services.nix
            ./misc.nix
            ./config
        ];

    home = {
        username = "ceri";
        stateVersion = "25.11";

        sessionVariables = {
            EDITOR = "nvim";
            BROWSER = "librewolf";
            TERMINAL = "foot";
        };
    };
}
