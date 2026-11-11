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

    networking.firewall = {
        allowedTCPPorts = [
            80
            443
            8448 # matrix
            64738 # murmur
            7880
            7881
        ];

        allowedUDPPorts = [
            64738 # murmur
            7882
        ];

        interfaces.br-containers = {
            allowedUDPPorts = [ 53 ];
            allowedTCPPorts = [ 53 ];
        };
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
            {
                sourcePort = 7881;
                destination = "10.100.0.2:7881";
                proto = "tcp";
            }
            {
                sourcePort = 7882;
                destination = "10.100.0.2:7882";
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

                locations = {
                    "/" = {
                        proxyPass = "http://10.100.0.2:6167$request_uri";
                    };

                    "/.well-known/matrix/server" = {
                        extraConfig = ''
                            default_type application/json;
                            return 200 '{"m.server":"matrix.cdwn.gay:443"}';
                        '';
                    };

                    "/.well-known/matrix/client" = {
                        extraConfig = ''
                            default_type application/json;
                            return 200 '
                                {
                                    "m.homeserver": {
                                        "base_url": "https://matrix.cdwn.gay"
                                    },
                                    "m.identity_server": {
                                        "base_url": "https://matrix.cdwn.gay"
                                    },
                                    "org.matrix.msc3575.proxy": {
                                        "url": "https://matrix.cdwn.gay"
                                    },
                                    "org.matrix.msc4143.rtc_foci": [
                                        {
                                            "type": "livekit",    "livekit_service_url": "https://matrix.cdwn.gay/livekit/jwt"
                                        }
                                    ]
                                } 
                            ';
                        '';
                    };

                    "^~ /livekit/jwt/" = {
                        priority = 400;
                        proxyPass = "http://10.100.0.2:${toString config.services.lk-jwt-service.port}/";
                    };

                    "^~ /livekit/sfu/" = {
                        extraConfig = ''
                            proxy_send_timeout 120;
                            proxy_read_timeout 120;
                            proxy_buffering off;

                            proxy_set_header Accept-Encoding gzip;
                            proxy_set_header Upgrade $http_upgrade;
                            proxy_set_header Connection "upgrade";
                        '';

                        priority = 400;
                        proxyPass = "http://10.100.0.2:${toString config.services.livekit.settings.port}/";
                        proxyWebsockets = true;
                    };
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
