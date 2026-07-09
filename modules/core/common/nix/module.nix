{ ... }:
{
    nixpkgs.config = {
        allowUnfree = true;
    };

    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    nixpkgs.config.permittedInsecurePackages = [
        "librewolf-bin-151.0.1-2"
        "pnpm-10.29.2"
        "librewolf-bin-unwrapped-151.0.1-2"
        #"librewolf-unwrapped-151.0.2-1"
    ];

    environment.sessionVariables.NH_FLAKE = "$HOME/.config/nix";

    programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
    };
}
