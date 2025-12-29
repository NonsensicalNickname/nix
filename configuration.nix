{ config, lib, pkgs, ... }:
{
	imports = [ /etc/nixos/hardware-configuration.nix ];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;

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
		extraGroups = [ "wheel" "input" "networkmanager" "seat" ];
		packages = with pkgs; [];
	};

	users.defaultUserShell = pkgs.fish;

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		fira-code
		fira-code-symbols
	];

	environment.systemPackages = with pkgs; [
		vim 
		git
		wget
		fd
		tree
		fastfetch
		hyfetch
		tealdeer
		bat

		foot
		fuzzel
		wpaperd
		xwayland-satellite
		mako

		librewolf

		fishPlugins.z
		fishPlugins.done
		fishPlugins.autopair
		fishPlugins.fzf-fish
		fishPlugins.gruvbox

		(catppuccin-sddm.override { flavor = "macchiato"; accent = "mauve"; })
	];

	programs.fish.enable = true;
	programs.command-not-found.enable = false;

	services.hardware.deepcool-digital-linux.enable = true;

	services.displayManager.sessionPackages = [
		pkgs.niri
	];

	services.displayManager.defaultSession = "niri";

	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
		theme = "catppuccin-macchiato-mauve";
	};
	
	security.polkit.enable = true;

	xdg.portal = {
		config.common.default = "*";
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-gtk ];
	};

	environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = true;
		};
	};

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
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
