{
    config,
    lib,
    ...
}:
let
    inherit (lib) mkEnableOption;
    inherit (lib.options) mkOption;
    inherit (lib.types) str;
in
{
    options.modules.boot = {
        legacy = mkEnableOption "legacy";
        bootdev = mkOption {
            type = str;
            default = "nodev";
            description = "The device used by grub to boot. DEVICE NOT PARTITION.";
        };
    };
}
