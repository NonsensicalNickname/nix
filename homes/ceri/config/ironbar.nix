{ pkgs, config, ... }:
{
    programs.ironbar = {
        enable = true;
        package = pkgs.ironbar;
        config = {
            monitors.DP-1 = {
                position = "bottom";
                height = 12;
                start = [
                    { type = "workspaces"; }
                    {
                        type = "focused";
                        icon_size = 16;
                        show_title = false;
                    }
                ];
                center = [
                    {
                        type = "music";
                        player_type = "mpd";
                        show_status_icon = false;
                        icons.volume = "";

                        truncate.mode = "middle";
                        truncate.max_length = 45;

                        truncate_popup_album.mode = "end";
                        truncate_popup_album.max_length = 30;

                        truncate_popup_artist.mode = "end";
                        truncate_popup_artist.max_length = 30;

                        truncate_popup_title.mode = "end";
                        truncate_popup_title.max_length = 30;
                    }
                ];
                end = [
                    { type = "tray"; }
                    {
                        type = "sys_info";
                        format = [ "C:{cpu_percent} M:{memory_percent}" ];
                    }
                    { type = "clock"; }
                ];
            };
        };
        style = ''
            * {
                border: none;
                box-shadow: none;
                background-image: none;
                font-family: JetBrainsMono NF;
            }

            #bar, popover, popover contents, calendar {
                background-color: #232136;
            }

            box, button, label {
                background-color: @dark-primary;
                color: @white;
            }

            button {
                padding-left: 0.5em;
                padding-right: 0.5em;
            }

            button:hover, button:active {
                background-color: @dark-secondary;
            }

            .sysinfo {
                margin-left: 0.5em;
                margin-right: 0.5em;
            }

            .focused {
                margin-left: 1em;
            }

            .workspaces .item.focused, .workspaces .item.visible {
                background-color: #44415a;
                margin-left: 0em;
            }

            .clock {
                margin-right: 0.5em;
                font-weight: normal;
            }

            .popup-clock .calendar-clock {
                font-size: 2.0em;
            }

            .popup-clock .calendar {
                color: @white; 
                font-size: 1.0em
            }

            .popup-music {
                min-width: 20em;
            }

            .popup-music .volume .icon {
                font-size: 0;
            }

            scale.slider trough {
              background: black;
            }

            scale.slider trough slider {
              min-width: 2px;
              min-height: 2px;
              background: white;
            }

            scale.slider.horizontal trough slider {
              margin: -5px 0px -5px 0px;
              min-height: 12px;
            }

            scale.slider.horizontal trough highlight {
              background: linear-gradient(to right, #232136, #c4a7e7);
            }

            scale.slider.vertical trough slider {
              margin: 0px -5px 0px -5px;
              min-width: 12px;
            }

            scale.slider.vertical trough highlight {
                background: linear-gradient(to top, #232136, #c4a7e7);
            }
        '';
    };
}
