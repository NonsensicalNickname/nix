{ config, pkgs, inputs, ... }:
{
    imports = [ 
        inputs.niri.homeModules.niri 
        inputs.ironbar.homeManagerModules.default
        inputs.nvf.homeManagerModules.default
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
        rmpc
        mpc
        vesktop
        cloc
    ];

    services.wpaperd.enable = true;
    services.wpaperd.settings.DP-1.path = "/home/ceri/Pictures/walls/rosepinesquares.png";

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
