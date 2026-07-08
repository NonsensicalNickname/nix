{
    config,
    lib,
    pkgs,
    ...
}:
{
    imports = [ ./hardware.nix ];
    # Modify module config here, e,g.
    # config.modules.style.cursor.name = "bimgus";
    system.stateVersion = "25.11";
}
