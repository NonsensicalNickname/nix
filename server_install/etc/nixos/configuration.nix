{ config, lib, pkgs, ... }:

{
    imports =
        [ 
            ./hardware-configuration.nix
        ];

    boot.loader.grub.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "bimgus"; 
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

    users.users = {
        ceri = {
            password = "pw";
            isNormalUser = true;
            extraGroups = [ "wheel" "input" "networkmanager" ]; 
        };
    };
    users.users.root.password = "root";

    environment.systemPackages = with pkgs; [
        vim 
        wget
        git
        fastfetch
        hyfetch
    ];

    systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

    services.openssh.enable = true;
    users.users.ceri.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYRz8gcRysrisod32rt4r2NSdcarg+fy0WPgf7LJP04 ceri@goose"
    ];

    users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYRz8gcRysrisod32rt4r2NSdcarg+fy0WPgf7LJP04 ceri@goose"
    ];

    services.dbus.implementation = "dbus";

    networking.firewall.enable = false;

    system.stateVersion = "26.05"; 

}

