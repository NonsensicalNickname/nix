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
            display = {
                name = "eDP-1";
                scale = 1.3;
            };
        };

        # TODO: trait
        modules.environment.game = {
            enable = true;
            emulation.enable = true;
        };

        system.stateVersion = "26.11";
    };
}
