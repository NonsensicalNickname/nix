{
    config,
    lib,
    pkgs,
    ...
}:
{
    imports = [ ./hardware.nix ];
    config = {
        system.stateVersion = "26.05";

        environment.shell = {
            name = "zsh";
            package = pkgs.zsh;
        };
    };
}
