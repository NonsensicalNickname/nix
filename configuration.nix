{ config, lib, pkgs, ... }:

{
	imports = [ ./hardware-configuration.nix ];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nix-goose"; 
	networking.networkmanager.enable = true;  

	time.timeZone = "Australia/Sydney";

	i18n.defaultLocale = "en_GB.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_AU.UTF-8";
		LC_IDENTIFICATION = "en_AU.UTF-8";
		LC_MEASUREMENT = "en_AU.UTF-8";
		LC_MONETARY = "en_AU.UTF-8";
		LC_NAME = "en_AU.UTF-8";
		LC_NUMERIC = "en_AU.UTF-8";
		LC_PAPER = "en_AU.UTF-8";
		LC_TELEPHONE = "en_AU.UTF-8";
		LC_TIME = "en_AU.UTF-8";
	};
	console.keyMap = "us";

	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	nix.settings.experimental-features = [ "nix-command" ];

	users.users.ceri = {
		isNormalUser = true;
		extraGroups = [ "wheel" "input" "networkmanager" ];
		packages = with pkgs; [];
	};
	users.defaultUserShell = pkgs.fish;

	environment.systemPackages = with pkgs; [
		vim 
		git
		wget
		tree

		foot
		fuzzel
		ironbar
		wpaperd
		xwayland-satellite
		mako

		librewolf
		vesktop
		rmpc

		fishPlugins.z
		fishPlugins.done
		fishPlugins.autopair
		fishPlugins.fzf-fish
		fishPlugins.gruvbox
	];

	programs.niri.enable = true;

	programs.fish.enable = true;
	programs.command-not-found.enable = false;

	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = true;
		};
	};
	services.mpd = {
		enable = true;
		musicDirectory = "/home/ceri/Music";
		extraConfig = ''
			audio_output {
				type "pipewire"
					name "pipe-out"
			}
		'';
	};

	system.stateVersion = "25.11"; 

}
