{
    pkgs,
    lib,
    config,
    ...
}:
let
    inherit (import ../../../utils { inherit lib; }) mkIfElse;
    inherit (lib) mkIf;
    legacy = config.modules.boot.legacy;
    needsDDCCI = config.modules.device.display.external;
in
{
    boot.loader = mkIfElse legacy {
        body = {
            grub.enable = true;
            grub.device = "nodev";
        };

        elseBody = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };

    boot.extraModulePackages = mkIf needsDDCCI [ config.boot.kernelPackages.ddcci-driver ];
}
