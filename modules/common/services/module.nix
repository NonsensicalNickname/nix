{
    pkgs,
    lib,
    config,
    ...
}:
let
    inherit (lib.modules) mkIf;
    rgb = config.modules.style.rgb;
in
{
    services.hardware.openrgb = mkIf rgb.enable {
        enable = true;
    };

    services.mpd.enable = false;

    services.dbus.implementation = "broker";

    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = true;
        };
    };

    services.unbound.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    services.pcscd.enable = true;
}
