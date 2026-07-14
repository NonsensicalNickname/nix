{
    pkgs,
    lib,
    config,
    ...
}:
let
    inherit (lib.modules) mkIf;
    virt = config.modules.environment.virtualisation;
    virtualbox = virt.virtualbox.enable;
    waydroid = virt.waydroid.enable;
in
{
    virtualisation.virtualbox = mkIf virtualbox {
        host.enable = true;
        host.enableKvm = true;
        host.addNetworkInterface = false;
    };

    users.extraGroups.vboxusers.members = mkIf virtualbox [ "ceri" ];

    virtualisation.waydroid = mkIf waydroid {
        enable = true;
        package = pkgs.waydroid-nftables;
    };
}
