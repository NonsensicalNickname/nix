{ pkgs, ... }:
{
    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
        acpi
    ];

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
                serif = [ "Liberation Serif" ];
                sansSerif = [ "Liberation Sans" ];
                monospace = [ "JetBrainsMono NF" ];
            };
        };
    };

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

    security.rtkit.enable = true;
    security.polkit.enable = true;
    security.soteria.enable = true;

    networking.firewall.enable = false;
}
