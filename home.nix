{ config, pkgs, inputs, ... }:
{
	imports = [ 
		inputs.niri.homeModules.niri 
		inputs.ironbar.homeManagerModules.default
		./config
	];

	home.username = "ceri";
	home.homeDirectory = "/home/ceri";
	home.stateVersion = "25.11";

	home.sessionVariables = {
		EDITOR = "vim";
		BROWSER = "librewolf";
		TERMINAL = "foot";
	}; 

	home.packages = with pkgs; [
		rmpc
		mpc
		vesktop
		pwvucontrol
	];
}
