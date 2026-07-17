{
    config,
    ...
}:
let
    cfg = config.modules.containers;
in
{
    imports = [
        ./webserver.nix
    ];

    networking.nat = {
        enable = true;
        # Use "ve-*" when using nftables instead of iptables
        internalInterfaces = [ "ve-+" ];
        externalInterface = "ens3";
        # Lazy IPv6 connectivity for the container
        enableIPv6 = true;
    };

    # networking.nftables.enable = true;

    boot.enableContainers = cfg.enable;
}
