{ config, lib, pkgs, ... }:
{
	imports = [ /etc/nixos/hardware-configuration.nix ];

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

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	users.users.ceri = {
		isNormalUser = true;
		extraGroups = [ "wheel" "input" "networkmanager" ];
		packages = with pkgs; [];
	};

	users.defaultUserShell = pkgs.fish;

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		fira-code
		fira-code-symbols
	];
	xdg.portal = {
		enable = true;
		xdgOpenUsePortal = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-wlr
		];
	};
	environment.systemPackages = with pkgs; [
		vim 
		git
		wget
		fd
		tree
		fastfetch
		hyfetch
		mpc
		tealdeer
		bat

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

	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	services.mpd = {
		enable = true;
		settings = {
			audio_output = [{
				type = "pipewire";
				name = "pipe-out";
			}];
			music_directory = "/home/ceri/Music";
		};
	};

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true; 
		dedicatedServer.openFirewall = true; 
	};

	system.stateVersion = "25.11"; 
}
