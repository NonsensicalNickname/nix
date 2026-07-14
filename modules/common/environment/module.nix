{ pkgs, ... }:
{
    imports = [ ./locale.nix ];

    environment = {
        pathsToLink = [
            "/share/applications"
            "/share/xdg-desktop-portal"
        ];

        systemPackages = with pkgs; [
            vim
            acpi
            git
            wget
            fd
            psmisc
            tree
            bat
            btop
            unzip
            usbutils
            pciutils
            lm_sensors
            net-tools
            inetutils
            gcc
            gnumake
            cmake
            nixfmt
        ];
    };
}
