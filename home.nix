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
    ];
}
