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
}
