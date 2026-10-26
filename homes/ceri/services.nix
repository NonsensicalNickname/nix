{
    configured,
    flakeroot,
    ...
}:
let
    displayName = configured.device.display.name;
    user = configured.system.mainUser;
    walls = "/home/${user}/.config/wpaperd/walls";
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
        musicDirectory = "/home/${configured.system.mainUser}/Music/";
        extraConfig = ''
            audio_output {
                type "pipewire"
                name "pipedwire"
            }
            audio_output {
               type   "fifo"
               name   "cava"
               path   "/tmp/mpd.fifo"
               format "44100:16:2"
            }
        '';
    };

    services.mpd-mpris.enable = true;

    # Maybe this source should use a fetcher
    # Put these somewhere else soon?
    xdg.configFile."wpaperd/walls/rpm-squares.png" = {
        enable = true;
        source = "${flakeroot}/res/walls/rpm-squares.png";
    };

    xdg.configFile."wpaperd/walls/rpm-lines.png" = {
        enable = true;
        source = "${flakeroot}/res/walls/rpm-lines.png";
    };

    services.wpaperd.enable = true;
    services.wpaperd.settings.${displayName}.path = builtins.toPath "${walls}/rpm-squares.png";
}
