{ config, pkgs, inputs, ... }:
{
    imports = [ 
        inputs.niri.homeModules.niri 
        inputs.ironbar.homeManagerModules.default
        inputs.nvf.homeManagerModules.default
        inputs.sops-nix.homeManagerModules.sops
        ./config
    ];
    
    home.username = "ceri";
    home.homeDirectory = "/home/ceri";
    home.stateVersion = "25.11";

    home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "librewolf";
        TERMINAL = "foot";
    }; 

    home.packages = with pkgs; [
        mpc
        nicotine-plus
        legcord
        cloc
        keepassxc
        gdu
        mpv
        imv
        zathura
        sacad
        yazi
        parsec-bin
        yt-dlp
        tageditor
    ];

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
