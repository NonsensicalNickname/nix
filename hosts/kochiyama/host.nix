{ ... }:
{
    imports = [ ./hardware.nix ];
    config.modules = {
        device.display = {
            name = "eDP-1";
            scale = 1.3;
        };

        # TODO: trait maybe
        environment.game = {
            enable = true;
            emulation.enable = true;
        };
    };

    config.system.stateVersion = "26.11";
}
