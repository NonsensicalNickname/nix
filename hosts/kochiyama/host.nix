{
    config,
    lib,
    pkgs,
    ...
}:
{
    imports = [ ./hardware.nix ];
    config = {
        modules.device = {
            display.name = "eDP-1";
        };
        # Modify module config here, e,g.
        # modules.style.cursor.name = "bimgus";
        system.stateVersion = "25.11";
    };
}
