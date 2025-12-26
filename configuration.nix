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

	users.users.ceri = {
		isNormalUser = true;
		extraGroups = [ "wheel" "input" "networkmanager" ];
		packages = with pkgs; [];
	};

	environment.systemPackages = with pkgs; [
		vim 
		wget
		tree
		git
	];

	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = true;
		};
	};

	system.stateVersion = "25.11"; 

}
