{ ... }:
{
    imports = [ ./hardware.nix ];
    config.modules = {
        style.rgb.enable = true;

        environment.virtualisation = {
            virt-manager.enable = true;
            waydroid.enable = true;
        };

        # TODO: trait maybe
        environment.game = {
            enable = true;
            emulation.enable = true;
        };

        # Defaults are 1920 x 1080 and DP-1
        device.display = {
            name = "DP-2";
            refreshRate = 240.000;
            width = 2560;
            height = 1440;
            external = true;
        };

        network.dnsResolver = "unbound";
    };

    config.system.stateVersion = "25.11";
}
