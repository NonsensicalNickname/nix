{
    config,
    ...
}:
let
    cfg = config.modules.containers;
in
{
    imports = [
        ./httpd.nix
        ./continuwuity.nix
        ./murmur.nix
    ];

    networking.nftables.enable = true;
    networking.bridges.br-containers.interfaces = [ ];

    networking.interfaces.br-containers.ipv4.addresses = [
        {
            address = "10.100.0.1";
            prefixLength = 24;
        }
    ];

    networking.firewall.interfaces.br-containers = {
        allowedUDPPorts = [ 53 ];
        allowedTCPPorts = [ 53 ];
    };

    networking.nat = {
        enable = true;
        internalInterfaces = [ "br-containers" ];
        externalInterface = "enp0s31f6";

        forwardPorts = [
            {
                sourcePort = 64738;
                destination = "10.100.0.4:64738";
                proto = "tcp";
            }
            {
                sourcePort = 64738;
                destination = "10.100.0.4:64738";
                proto = "udp";
            }
        ];
    };

    services.caddy = {
        enable = true;

        virtualHosts."matrix.cdwn.gay".extraConfig = ''
            reverse_proxy 10.100.0.2:6167

            handle_path /.well-known/matrix/server {
                respond {"m.server":"matrix.cdwn.gay:443"}
            }
        '';

        virtualHosts."cdwn.gay".extraConfig = ''
            reverse_proxy 10.100.0.3:80
        '';
    };

    networking.firewall.allowedTCPPorts = [
        80
        443
        8448 # matrix
        64738 # murmur
    ];

    networking.firewall.allowedUDPPorts = [
        64738 # murmur
    ];

    boot.enableContainers = cfg.enable;
}
