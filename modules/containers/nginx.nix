{
    lib,
    config,
    ...
}:
let
    inherit (lib) mkIf;
    enabledContainers = config.modules.containers.enabledContainers;
    name = "nginx";
in
{
    containers.${name} = mkIf (builtins.elem name enabledContainers) {
        autoStart = true;
        privateNetwork = false;

        hostAddress = "192.168.100.20";
        localAddress = "192.168.100.21";
        hostAddress6 = "fc00::3";
        localAddress6 = "fc00::4";

        config =
            {
                config,
                ...
            }:
            {
                services.httpd = {
                    enable = true;
                    adminAddr = "ceridwen@tutamail.com";
                };

                networking = {
                    firewall.allowedTCPPorts = [
                        80
                        443
                    ];
                    nat = {
                        enable = true;
                        internalInterfaces = [ "ve-+" ];
                        externalInterface = "ens3";
                        enableIPv6 = true;

                        forwardPorts = [
                            {
                                destination = "192.168.100.21:80";
                                sourcePort = 80;
                            }
                            {
                                destination = "192.168.100.21:443";
                                sourcePort = 443;
                            }
                        ];
                    };
                };

                services.unbound.enable = true;

                services.nginx.enable = true;
                services.nginx.virtualHosts."cdwn.gay" = {
                    enableACME = true;
                    forceSSL = true;
                    # root = "${}";
                    serverAliases = [ "www.cdwn.gay" ];
                };

                security.acme.acceptTerms = true;
                security.acme.certs."cdwn.gay".email = "ceridwen@tutamail.com";

                system.stateVersion = config.system.nixos.release;
            };
    };
}
