{
    config,
    lib,
    ...
}:
let
    inherit (lib.options) mkOption;
    inherit (lib.types) listOf str enum;

in
{
    options.modules.system = {
        mainUser = mkOption {
            type = enum config.modules.system.users;
            default = builtins.elemAt config.modules.system.users 0;
            description = "Main user's name";
        };

        users = mkOption {
            type = listOf str;
            default = [ "ceri" ];
            description = "List of users for home-manager";
        };
    };
}
