{ pkgs, ... }:
{
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableKvm = true;
    virtualisation.virtualbox.host.addNetworkInterface = false;

    virtualisation.waydroid = {
        enable = true;
        package = pkgs.waydroid-nftables;
    };

    users.extraGroups.vboxusers.members = [ "ceri" ];
}
