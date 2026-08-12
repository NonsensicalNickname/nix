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

    programs.fish.enable = (shell.name == "fish");
    programs.command-not-found.enable = (shell.name != "fish");

    programs.zsh.enable = (shell.name == "zsh");

    documentation.dev.enable = true;
}
