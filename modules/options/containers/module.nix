{
    lib,
    config,
    ...
}:
let
    inherit (lib.options) mkOption;
    inherit (lib.types) listOf str bool;
in
{
    options.modules.containers = {
        enable = mkOption {
            type = bool;
            default = (builtins.length config.modules.containers.enabledContainers > 0);
            description = "Automatically set based on the length of enabledContainers";
        };

        enabledContainers = mkOption {
            type = listOf str;
            default = [ ];
            description = "List of containers to run";
        };
    };
}
