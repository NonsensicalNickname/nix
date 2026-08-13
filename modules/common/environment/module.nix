{
    lib,
    config,
    pkgs,
    ...
}:
let
    inherit (lib) mkIf;
    shell = config.modules.environment.shell;
in
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

            man-pages
            man-pages-posix

            shell.package
        ];
    };

    programs.${shell.name}.enable = true;
    programs.command-not-found.enable = false;

    documentation.dev.enable = true;
}
