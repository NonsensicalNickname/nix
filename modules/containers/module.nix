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

    networking.firewall.allowedTCPPorts = [
        80
        443
        8448 # matrix
        64738 # murmur
    ];

    networking.firewall.allowedUDPPorts = [
        64738 # murmur
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

    services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        clientMaxBodySize = "20m";

        virtualHosts = {
            "cdwn.gay" = {
                forceSSL = true;
                enableACME = true;

                locations."/" = {
                    proxyPass = "http://10.100.0.3:80";
                };
            };

            "matrix.cdwn.gay" = {
                forceSSL = true;
                useACMEHost = "cdwn.gay";

                locations."/" = {
                    proxyPass = "http://10.100.0.2:6167$request_uri";
                };

                locations."/.well-known/matrix/server" = {
                    extraConfig = ''
                        return 200 '{"m.server":"matrix.cdwn.gay:443"}';
                    '';
                };
            };
        };
    };

    security.acme = {
        acceptTerms = true;
        certs."cdwn.gay" = {
            email = "ceridwen@tutamail.com";
            group = config.services.nginx.group;
            extraDomainNames = [
                "matrix.cdwn.gay"
                "barking.cdwn.gay"
            ];
        };
    };

    boot.enableContainers = cfg.enable;
}
