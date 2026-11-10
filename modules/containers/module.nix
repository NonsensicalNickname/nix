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
    networking.bridges.br-containers.interfaces = [ ];

    networking.interfaces.br-containers.ipv4.addresses = [
        {
            address = "10.100.0.1";
            prefixLength = 24;
        }
    ];

    services.caddy = {
        enable = true;

        virtualHosts."matrix.cdwn.gay".extraConfig = ''
            reverse_proxy 10.100.0.2:6167

            handle_path /.well-known/matrix/server {
                respond {"m.server":"matrix.cdwn.gay:443"}
            }
        '';
    };

    networking.firewall.allowedTCPPorts = [
        80
        443
        8448
    ];

    boot.enableContainers = cfg.enable;
}
