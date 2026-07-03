{ config, lib, pkgs, ... }:
{
    imports = [ 
        /etc/nixos/hardware-configuration.nix 
        ./nix-ld.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "goose"; 
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

    users.users = {
        ceri = {
            isNormalUser = true;
            extraGroups = [ "wheel" "input" "networkmanager" ]; 
        };

        postgres = {
            isSystemUser = true;
            createHome = false;
            group = "postgres";
        };
    };

    users.groups.postgres = {};

    services.mpd.enable = false;

    users.defaultUserShell = pkgs.fish;

    fonts = {
        packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            fira-code
            fira-code-symbols
            liberation_ttf
            paratype-pt-sans
            paratype-pt-serif
            font-awesome_7
        ];

        fontconfig = {
            defaultFonts = {
                serif = [  "Liberation Serif" ];
                sansSerif = [ "Liberation Sans" ];
                monospace = [ "JetBrainsMono NF" ];
            };
        };
    };

    nixpkgs.config.permittedInsecurePackages = [
        "librewolf-bin-151.0.1-2"
        "pnpm-10.29.2"
        "librewolf-bin-unwrapped-151.0.1-2"
        #"librewolf-unwrapped-151.0.2-1"
    ];

    environment.systemPackages = with pkgs; [
        vim 
        git
        wget
        fd
        psmisc
        tree
        wl-clipboard
        unzip
        fastfetch
        hyfetch
        tealdeer
        bat
        wiremix
        btop
        syncthing
        nautilus
        pinentry-curses
        ascii 
        file
        cloc 
        mpv 
        imv 
        zathura 
        yt-dlp
        libnotify
        usbutils
        pciutils
        lm_sensors
        brightnessctl

        net-tools
        inetutils

        gcc
        factor-lang
        jdk17
        python3
        mlton
        ghc
        haskellPackages.hoogle
        haskell-language-server
        # stack
        gforth

        xwayland-satellite
        jq
        drawterm-wayland

        librewolf-bin

        (catppuccin-sddm.override { flavor = "macchiato"; accent = "mauve"; })
    ];

    programs.fish.enable = true;
    programs.command-not-found.enable = false;

    services.hardware.deepcool-digital-linux.enable = true;

    services.dbus.implementation = "broker";

    services.displayManager.sessionPackages = [
        pkgs.niri
    ];

    services.displayManager.defaultSession = "niri";
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        wayland.compositor = "weston";
        #wayland.compositorCommand = "";
        theme = "catppuccin-macchiato-mauve";
    };

    security.polkit.enable = true;
    security.soteria.enable = true;

    xdg.portal = {
        config.common = {
            default = [
                "gnome"
            ];
            "org.freedesktop.portal.ScreenCast" = [
                "gnome"
            ];
        };

        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [ 
            pkgs.xdg-desktop-portal-gnome
            pkgs.xdg-desktop-portal-gtk 
        ];
    };

    environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = true;
        };
    };

    services.resolved.enable = true;
    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    virtualisation.waydroid = {
        enable = true;
        package = pkgs.waydroid-nftables;
    };

    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableKvm = true;
    virtualisation.virtualbox.host.addNetworkInterface = false;
    users.extraGroups.vboxusers.members = [ "ceri" ];

    services.pcscd.enable = true;
    programs.gnupg.agent = {
       enable = true;
       pinentryPackage = pkgs.pinentry-curses;
       enableSSHSupport = true;
    };

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; 
        dedicatedServer.openFirewall = true; 
    };

    networking.firewall.enable = false;

    system.stateVersion = "25.11"; 
}
