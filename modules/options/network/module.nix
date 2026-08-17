{
    lib,
    ...
}:
let
    inherit (lib.options) mkOption;
    inherit (lib.types) enum;
in
{
    options.modules.network = {
        dnsResolver = mkOption {
            type = enum [
                "resolved"
                "unbound"
            ];
            default = "resolved";
        };
    };
}
