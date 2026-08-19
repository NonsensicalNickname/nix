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
        ./nginx.nix
    ];

    # networking.nftables.enable = true;

    boot.enableContainers = cfg.enable;
}
