{ pkgs, ... }:
{
    services.hardware.openrgb.enable = true;

    services.mpd.enable = false;

    services.hardware.deepcool-digital-linux.enable = true;

    services.dbus.implementation = "broker";

    services.displayManager.sessionPackages = [
        pkgs.niri
    ];

    services.displayManager.defaultSession = "niri";
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        wayland.compositor = "weston";
        theme = "catppuccin-macchiato-mauve";
    };

    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = true;
        };
    };

    services.resolved.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    services.pcscd.enable = true;
}
