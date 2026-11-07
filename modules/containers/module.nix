{
    config,
    ...
}:
let
    cfg = config.modules.containers;
in
{
    imports = [
        ./nginx.nix
        ./continuwuity.nix
    ];

    # networking.nftables.enable = true;

    boot.enableContainers = cfg.enable;
}
