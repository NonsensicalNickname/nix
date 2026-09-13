{
    pkgs,
    lib,
    config,
    ...
}:
let
    inherit (lib.modules) mkIf;

    inherit (config.modules.environment.virtualisation) waydroid virt-manager;
in
{
    virtualisation.waydroid = mkIf waydroid.enable {
        enable = true;
        package = pkgs.waydroid-nftables;
    };

    virtualisation.libvirtd.enable = virt-manager.enable;
    programs.virt-manager.enable = virt-manager.enable;
    users.users.ceri.extraGroups = mkIf virt-manager.enable [ "libvirtd" ];
}
