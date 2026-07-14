{
    pkgs,
    lib,
    config,
    ...
}:
let
    inherit (lib) mkIf mkMerge;
    legacy = config.modules.boot.legacy;
in
{
    boot.loader = mkMerge [
        (mkIf (!legacy) {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        })

        (mkIf legacy {
            grub.enable = true;
            grub.device = "nodev";
        })
    ];
}
