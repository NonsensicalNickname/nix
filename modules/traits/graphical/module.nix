{ pkgs, ... }:
{
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

    services.displayManager.sessionPackages = [
        pkgs.niri
    ];

    services.displayManager.defaultSession = "niri";
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        wayland.compositor = "weston";
        theme = "catppuccin-macchiato-mauve";
    };

    environment.systemPackages = with pkgs; [
        (catppuccin-sddm.override {
            flavor = "macchiato";
            accent = "mauve";
        })

        chameleos
        wob
    ];
}
