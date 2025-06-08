  # Edit this configuration file to define what should be installed on
  # your system.  Help is available in the configuration.nix(5) man page
  # and in the NixOS manual (accessible by running ‘nixos-help’).
  
  { config, pkgs, inputs, ... }:
  
  {
  imports =
  	[ # Include the results of the hardware scan.
  	./hardware-configuration.nix
  		inputs.home-manager.nixosModules.default
  	];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "nix-goose"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Enable networking
  	networking.networkmanager.enable = true;
  
  # Set your time zone.
  time.timeZone = "Australia/Sydney";
  
  # Select internationalisation properties.
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
  
  # Configure keymap in X11
  services.xserver.xkb = {
  	layout = "us";
  	variant = "";
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ceri = {
  	isNormalUser = true;
  	description = "ceri";
  	extraGroups = [ "networkmanager" "wheel" "input" ];
  	packages = with pkgs; [];
  };
  
  home-manager = {
  	extraSpecialArgs = {inherit inputs;};
  	users = {
  		"ceri" = import ./home-manager/home.nix;
  	};
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	vim 
  		wget
  		git
  ];
  
  nix.settings.experimental-features= [ "nix-command" "flakes" ];
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # List services that you want to enable:
  
  # Enable the OpenSSH daemon.
  services.openssh = {
  	enable = false;
  	ports = [ 22 ];
  	settings = {
  		PasswordAuthentication = true;
  	};
  };
  programs.niri = {
  	enable = true;
  };
  programs.steam = {
  	enable = true;
	extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  system.stateVersion = "25.05"; # Did you read the comment?
  
  }
