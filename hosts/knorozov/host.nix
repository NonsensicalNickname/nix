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
    };
}
