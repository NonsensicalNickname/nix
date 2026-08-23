{
    config,
    ...
}:
let
    cfg = config.modules.containers;
in
{
    imports = [
        ./web.nix
        ./continuwuity.nix
    ];

    # networking.nftables.enable = true;

    boot.enableContainers = cfg.enable;
}
