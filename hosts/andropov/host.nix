{
    config,
    lib,
    pkgs,
    ...
}:
{
    imports = [ ./hardware.nix ];
    config.modules = {
        style.rgb.enable = true;

        environment.virtualisation = {
            virtualbox.enable = true;
            waydroid.enable = true;
        };

        containers.enabledContainers = [ "webserver" ];

        # TODO: trait maybe
        environment.game = {
            enable = true;
            emulation.enable = true;
        };

        # Defaults are 1920 x 1080 and DP-1
        device = {
            display.refreshRate = 164.955;
            display.external = true;
        };
    };

    config.system.stateVersion = "25.11";
}
