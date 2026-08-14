{
    pkgs,
    lib,
    config,
    configured,
    flakeroot,
    ...
}:
let
    inherit (lib) mkIf;
    inherit (import "${flakeroot}/helpers") mkIfElse;
    display = configured.device.display;
    scripts = "${flakeroot}/res/scripts";
    wobsock = "$XDG_RUNTIME_DIR/wobsock.sock";
in
{
    # TODO:
    # windowrules
    # volume popup thingy perhaps
    # configurable browser etc programs

    programs.niri = {
        enable = true;
        package = pkgs.niri;
        settings = {
            gestures.hot-corners.enable = false;
            prefer-no-csd = true;

            environment.QT_QPA_PLATFORM = "wayland";
            environment.DISPLAY = ":1";

            input.mouse.accel-profile = "flat";
            input.touchpad.dwt = true;

            screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d %H-%M-%S.png";

            outputs.${display.name} = {
                mode = {
                    width = display.width;
                    height = display.height;
                    refresh = display.refreshRate;
                };
                scale = display.scale;
            };

            spawn-at-startup = [
                { sh = "wpaperd"; }
                { sh = "openrgb -b 0"; }
                { sh = "xwayland-satellite :1"; }
                { sh = "steam -silent"; }
                { sh = "mprisence"; }
                { sh = "fcitx5 -d"; }
                { sh = "chameleos --stroke-color \"#00BFFF\" --stroke-width 2"; }
                { sh = "rm -f ${wobsock} && mkfifo ${wobsock} && tail -f ${wobsock} | wob"; }
            ];

            layout = {
                gaps = 6;
                default-column-width.proportion = 0.5;
                border = {
                    enable = true;
                    width = 3;
                    active.color = "#C4A7E7";
                    inactive.color = "#908CAA";
                    urgent.color = "#EB6F92";
                };
                focus-ring.enable = false;
                shadow.enable = false;
                center-focused-column = "never";
            };

            workspaces = {
                "buffer".name = "buffer";
                "browser".name = "browser";
                "term".name = "term";
                "gayming".name = "gayming";
                "education".name = "education";
            };

            binds = with config.lib.niri.actions; {
                "Mod+Q".action.spawn = "foot";
                "Mod+Z".action.spawn = "fuzzel";
                "Mod+B".action.spawn = "librewolf";

                "XF86AudioMute".action.spawn-sh =
                    "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && (wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 0 > ${wobsock}) || wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/[^0-9]//g' > ${wobsock}";
                "XF86AudioRaiseVolume".action.spawn-sh =
                    "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ && wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/[^0-9]//g' > ${wobsock}";
                "XF86AudioLowerVolume".action.spawn-sh =
                    "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/[^0-9]//g' > ${wobsock}";

                "Shift+XF86AudioRaiseVolume".action.spawn-sh =
                    "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.1+ > ${wobsock}";
                "Shift+XF86AudioLowerVolume".action.spawn-sh =
                    "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.1- > ${wobsock}";
                "Shift+delete".action.spawn-sh = "fish ${scripts}/mute.fish";

                # "Mod+XF86AudioRaiseVolume".action.spawn-sh = mkIfElse display.external {
                #     body = "ddcutil setvcp 10 $(($(ddcutil getvcp 10 | sed 's/.*current value =\(.*\),.*/\1/g') + 5))";
                #     elseBody = "";
                # };

                "Mod+Y".action.focus-workspace = "buffer";
                "Mod+U".action.focus-workspace = "browser";
                "Mod+I".action.focus-workspace = "term";
                "Mod+O".action.focus-workspace = "gayming";
                "Mod+P".action.focus-workspace = "education";

                "Mod+Shift+Y".action.move-column-to-workspace = "buffer";
                "Mod+Shift+U".action.move-column-to-workspace = "browser";
                "Mod+Shift+I".action.move-column-to-workspace = "term";
                "Mod+Shift+O".action.move-column-to-workspace = "gayming";
                "Mod+Shift+P".action.move-column-to-workspace = "education";

                "Mod+H".action = focus-column-left;
                "Mod+J".action = focus-window-down;
                "Mod+K".action = focus-window-up;
                "Mod+L".action = focus-column-right;

                "Mod+Shift+H".action = move-column-left;
                "Mod+Shift+J".action = move-window-down;
                "Mod+Shift+K".action = move-window-up;
                "Mod+Shift+L".action = move-column-right;

                "Mod+Minus".action.set-column-width = "-10%";
                "Mod+Equal".action.set-column-width = "+10%";
                "Mod+Shift+Minus".action.set-window-height = "-10%";
                "Mod+Shift+Equal".action.set-window-height = "+10%";
                "Mod+0".action.set-column-width = "50%";

                "F12".action.screenshot = {
                    show-pointer = false;
                };
                "Ctrl+F12".action.screenshot-screen = {
                    show-pointer = false;
                };

                "F10".action.spawn-sh = "hyprpicker | wl-copy";

                "F4".action.spawn-sh = "makoctl dismiss";
                "Mod+D".action.spawn-sh = "fish ${scripts}/define.fish";

                "Mod+Shift+D".action.spawn-sh = "chamel toggle";
                "Mod+Shift+C".action.spawn-sh = "chamel clear";

                "Mod+C".action = close-window;
                "Mod+Shift+F".action = fullscreen-window;
                "Mod+F".action = maximize-column;

                "Ctrl+Alt+Delete".action.spawn-sh = "fish ${scripts}/power_menu.fish";
            };
        };
    };
}
