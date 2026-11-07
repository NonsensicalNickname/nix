{
    lib,
    config,
    ...
}:
let
    inherit (lib) mkIf;
    secrets = config.age.secrets;
    enabledContainers = config.modules.containers.enabledContainers;
    name = "continuwuity";
in
{
    containers.${name} = mkIf (builtins.elem name enabledContainers) {
        autoStart = true;
        privateNetwork = true;

        hostAddress = "192.168.100.20";
        localAddress = "192.168.100.21";
        hostAddress6 = "fc00::3";
        localAddress6 = "fc00::4";

        config =
            {
                config,
                pkgs,
                ...
            }:
            {
                services.matrix-continuwuity = {
                    enable = true;
                    settings = {
                        global = {
                            server_name = "cdwn.gay";
                            # Listening on localhost by default
                            # address and port are handled automatically
                            allow_registration = false;
                            allow_encryption = true;
                            allow_federation = true;
                            trusted_servers = [ "matrix.org" ];
                        };
                    };
                };

                services.nginx.enable = true;
                services.nginx.virtualHosts."cdwn.gay" = {
                    useACMEHost = "cdwn.gay";
                    forceSSL = true;
                    serverAliases = [ "www.cdwn.gay" ];

                    locations."/_matrix/" = {
                        extraConfig = ''
                            proxy_pass http://127.0.0.1:6167$request_uri;
                            proxy_set_header Host $host;
                            proxy_set_header X-Real-IP $remote_addr;
                            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                            proxy_set_header X-Forwarded-Proto $scheme;
                        '';
                    };

                    listen = [
                        {
                            addr = "127.0.0.1";
                            port = 443;
                            ssl = true;
                        }
                        {
                            addr = "127.0.0.1";
                            port = 8448;
                            ssl = true;
                        }
                    ];
                };

                security.acme.acceptTerms = true;
                security.acme.certs."cdwn.gay" = {
                    email = "ceridwen@tutamail.com";
                    domain = "cdwn.gay";
                    dnsProvider = "porkbun";
                    dnsPropagationCheck = true;

                    credentialFiles = {
                        "PORKBUN_API_KEY_FILE" = secrets.porkbunAPIKey.path;
                        "PORKBUN_SECRET_API_KEY_FILE" = secrets.porkbunAPISecretKey.path;
                    };
                };

                users.users.nginx.extraGroups = [ "acme" ];

                services.unbound.enable = true;

                system.stateVersion = config.system.nixos.release;
            };
    };

    networking = {
        firewall.allowedTCPPorts = [
            80
            443
            8448
        ];

        nat = {
            enable = true;
            internalInterfaces = [ "ve-+" ];
            externalInterface = "ens3";
            enableIPv6 = true;

            forwardPorts = [
                {
                    destination = "127.0.0.1:80";
                    sourcePort = 80;
                }
                {
                    destination = "127.0.0.1:443";
                    sourcePort = 443;
                }
                {
                    destination = "127.0.0.1:8448";
                    sourcePort = 8448;
                }
            ];
        };
    };

}
