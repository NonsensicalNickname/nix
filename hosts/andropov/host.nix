{
    config,
    lib,
    pkgs,
    ...
}:
{
    imports = [ ./hardware.nix ];
    config = {
        # Modify module config here, e,g.
        modules.style.rgb.enable = true;

        modules.environment.virtualisation = {
            virtualbox.enable = true;
            waydroid.enable = true;
        };

        # Defaults are 1920 x 1080 and DP-1
        modules.device = {
            display.refreshRate = 164.955;
        };

        system.stateVersion = "25.11";
    };
}
