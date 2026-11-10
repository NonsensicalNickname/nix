{
    lib,
    pkgs,
    ...
}:
let
    patched-pkgs =
        let
            patched-nixpkgs = pkgs.applyPatches {
                src = pkgs.path;
                patches = lib.singleton (
                    pkgs.fetchpatch {
                        url = "https://github.com/NixOS/nixpkgs/pull/573087.diff";
                        hash = "sha256-xKHQwVpt73iHZMHkR0Z0Mb/oy7lm6PfhkXUZ6rV96sg=";
                    }
                );
            };
        in
        import patched-nixpkgs { inherit (pkgs) config; };
in
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

    environment.systemPackages = [
        (pkgs.catppuccin-sddm.override {
            flavor = "macchiato";
            accent = "mauve";
        })

        pkgs.mumble
        pkgs.chameleos
        pkgs.wob
        patched-pkgs.sable-desktop
    ];
}
