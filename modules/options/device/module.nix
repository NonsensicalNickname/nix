{
    lib,
    ...
}:
let
    inherit (lib.options) mkOption;
    inherit (lib) mkEnableOption;
    inherit (lib.types)
        bool
        str
        int
        float
        ;
in
{
    options.modules.device = {
        # TODO: List of displays + primary display
        display = {
            name = mkOption {
                type = str;
                default = "DP-1";
                description = "The default display name";
            };

            width = mkOption {
                type = int;
                default = 1920;
                description = "The default display width";
            };

            height = mkOption {
                type = int;
                default = 1080;
                description = "The default display height";
            };

            scale = mkOption {
                type = float;
                default = 1.0;
                description = "Fractional scaling for this display";
            };

            refreshRate = mkOption {
                type = float;
                default = 60.0;
                description = "The default display refresh rate";
            };

            external = mkOption {
                type = bool;
                default = false;
                description = "If this display is an external display";
            };
        };
    };
}
