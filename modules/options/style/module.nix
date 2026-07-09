{
    pkgs,
    lib,
    ...
}:
let
    inherit (lib.options) mkOption;
    inherit (lib.types)
        either
        listOf
        package
        str
        int
        attrs
        enum
        bool
        ;

    mkPalette =
        slug:
        if builtins.pathExists ./palettes${slug}.nix then
            (import ./palettes/${slug}.nix).colourscheme.palette
        else
            throw "${slug} not found in palettes";
in
{
    options.modules.style = {
        cursor = {
            name = mkOption {
                type = str;
                default = "BreezeX-RosePine-Linux";
                description = "Cursor name within package";
            };

            package = mkOption {
                type = package;
                default = pkgs.rose-pine-cursor;
                description = "Cursor package";
            };

            size = mkOption {
                type = int;
                default = 20;
                description = "Cursor size";
            };
        };

        wallpapers = mkOption {
            type = either str (listOf str);
            default = [ ];
            description = "Wallpaper(s)";
        };

        rgb = {
            # TODO: Actually provide a means of configuring openrgb
            enable = mkOption {
                type = bool;
                default = false;
                description = "RGB control via OpenRGB";
            };
        };

        colourscheme = rec {
            name = mkOption {
                type = str;
                default = "Rosé Pine Moon";
                description = "Name of the colourscheme";
            };

            slug = mkOption {
                type = str;
                default = "rose-pine-moon";
                description = "Slug (used as filename, etc)";
            };

            palette = mkOption {
                type = attrs;
                default = mkPalette name;
                description = "Attrset of a base16 colourscheme";
            };

            variant = mkOption {
                type = enum [
                    "dark"
                    "light"
                ];
                default = "dark";
                description = "dark / light";
            };
        };
    };
}
