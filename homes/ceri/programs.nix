{ pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium-fhs;
        profiles.default.extensions = with pkgs.vscode-extensions; [
            vscjava.vscode-java-pack
            vscodevim.vim
        ];
    };

    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "ceridwen15";
                email = "ceridwen@tutamail.com";
                signingkey = "41E1454BBAD931DA";
            };
            commit.gpgsign = true;
        };
    };

    programs.obs-studio = {
        enable = true;

        plugins = with pkgs.obs-studio-plugins; [
            obs-pipewire-audio-capture
            obs-gstreamer
            obs-livesplit-one
        ];
    };

    programs.librewolf = {
        enable = true;
    };

    programs.fuzzel = {
        enable = true;
        settings = {
            main = {
                terminal = "${pkgs.foot}/bin/foot";
                layer = "overlay";
            };
            colors = {
                background = "232136ff";
                text = "e0def4ff";
                prompt = "e0def4ff";
                placeholder = "6e6a86ff";
                input = "e0def4ff";
                match = "ea9a97ff";
                selection = "44415aff";
                selection-text = "e0def4ff";
                selection-match = "ea9a97ff";
                counter = "f6c177ff";
                border = "ea9a97ff";
            };
        };
    };
}
