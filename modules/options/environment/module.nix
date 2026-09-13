{
    lib,
    pkgs,
    ...
}:
let
    inherit (lib.options) mkOption;
    inherit (lib) mkEnableOption;
    inherit (lib.types) bool str raw;
in
{
    options.modules.environment = {
        useHomeManager = mkOption {
            type = bool;
            default = true;
            description = "Should this system use home manager";
        };

        virtualisation = {
            virt-manager = {
                enable = mkEnableOption "virt-manager";
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

        shell = {
            name = mkOption {
                type = str;
                default = "fish";
                description = "Name of the primary user shell";
            };

            package = mkOption {
                type = raw;
                default = pkgs.fish;
                description = "Package for the primary user shell";
            };
        };
    };
}
