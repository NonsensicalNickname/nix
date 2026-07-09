{ configured, ... }:
let
    displayName = configured.device.display.name;
in
{
    services.mako = {
        enable = true;
        settings = {
            actions = true;
            anchor = "top-right";
            background-color = "#000000";
            border-color = "#FFFFFF";
            border-radius = 0;
            default-timeout = 0;
            # font = "monospace 10";
            height = 100;
            icons = true;
            ignore-timeout = false;
            layer = "top";
            margin = 10;
            markup = true;
            width = 300;
        };
    };

    services.mpd = {
        enable = true;
        musicDirectory = "/home/ceri/Music/";
        extraConfig = ''
            audio_output {
                type "pipewire"
                name "pipedwire"
            }
        '';
    };

    services.mpd-mpris.enable = true;

    services.wpaperd.enable = true;
    services.wpaperd.settings.${displayName}.path = ./../../res/walls/rpm-squares.png;
}
