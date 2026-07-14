{
    lib,
    ...
}:
let
    inherit (lib.options) mkOption;
    inherit (lib) mkEnableOption;
    inherit (lib.types) bool;
in
{
    options.modules.environment = {
        useHomeManager = mkOption {
            type = bool;
            default = true;
            description = "Should this system use home manager";
        };

        virtualisation = {
            virtualbox = {
                enable = mkEnableOption "virtualbox";
            };
            waydroid = {
                enable = mkEnableOption "waydroid";
            };
        };

        game = {
            enable = mkEnableOption "game";
            emulation = {
                enable = mkEnableOption "emulation";
            };
        };
    };
}
