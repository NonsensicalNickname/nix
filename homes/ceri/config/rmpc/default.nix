{
    # Theme is almost entirely https://github.com/rose-pine/rmpc !!!

    imports = [
        ./theme.nix
        ./config.nix
    ];

    programs.cava.enable = true;
    programs.rmpc.enable = true;
}
