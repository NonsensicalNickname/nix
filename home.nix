{ config, pkgs, inputs, user, ... }:
{
    imports = with inputs; [ 
        niri.homeModules.niri 
        ironbar.homeManagerModules.default
        nvf.homeManagerModules.default
        sops-nix.homeManagerModules.sops
    ] ++ [ ./config ];
    
    home.username = "ceri";
    home.homeDirectory = "/home/ceri";
    home.stateVersion = "25.11";

    home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "librewolf";
        TERMINAL = "foot";
    }; 

    home.packages = with pkgs; [
        # CLI utils
        blahaj 
        cowsay
        mpc 
        hyprpicker
        file
        mpris-scrobbler
        mprisence
        music-discord-rpc

        # GUI apps
        fluffychat
        nicotine-plus
        legcord
        vesktop
        keepassxc 
        r2modman
        tageditor
        parsec-bin 
        firefox-bin

        # TUI apps
        wikiman
        gdu
        yazi
        tiny

        # PL tools
        valgrind
        gdb
        gnumake
        cmake

        (mpv.override {scripts = [mpvScripts.mpris];})
    ];

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

    programs.vscode = {
        enable = true;
        package = pkgs.vscodium-fhs;
        profiles.default.extensions = with pkgs.vscode-extensions; [
            vscjava.vscode-java-pack
            vscodevim.vim
        ];
    };
    # sops.secrets.my-password.neededForUsers = true;

    programs.git = {
        enable = true;
        settings = {
            user = {
                name  = "ceridwen15";
                email = "ceridwen@tutamail.com";
                signingkey = "41E1454BBAD931DA";
            };
            commit.gpgsign = true;
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

    # systemd.user.services.mprisence = {
    #     enable = true;
    #     after = [ "network.target" ];
    #     wantedBy = [ "default.target" ];
    #     description = "rpc for mpris";
    #     serviceConfig = {
    #         Type = "simple";
    #         ExecStart = ''mprisence'';
    #         Restart = "always";
    #         RestartSec=10;
    #     };
    # };

    services.wpaperd.enable = true;
    services.wpaperd.settings.DP-1.path = ./res/walls/rpm-squares.png;

    programs.obs-studio = {
        enable = true;

        plugins = with pkgs.obs-studio-plugins; [
            obs-pipewire-audio-capture
                obs-gstreamer
                obs-livesplit-one
            ];
        };

        programs.fuzzel = {
            enable = true;
            settings = {
                main = {
                    terminal = "${pkgs.foot}/bin/foot";
                    layer = "overlay";
                };
                colors = {
                    background= "232136ff";
                    text= "e0def4ff";
                    prompt= "e0def4ff";
                    placeholder= "6e6a86ff";
                    input= "e0def4ff";
                    match= "ea9a97ff";
                    selection= "44415aff";
                    selection-text= "e0def4ff";
                    selection-match= "ea9a97ff";
                    counter= "f6c177ff";
                    border= "ea9a97ff";
                };
            };
        };
    }
