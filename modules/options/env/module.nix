{
    inputs',
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (lib.options) mkOption;
    inherit (lib.types) bool enum package;
in
{
    options.modules.env = {
        useHomeManager = mkOption {
            type = bool;
            default = true;
            description = "If home manager should be used";
        };
    };
}
