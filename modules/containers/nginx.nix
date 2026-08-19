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
                pkgs,
                ...
            }:
            {
                services.nginx.enable = true;
                services.nginx.virtualHosts."cdwn.gay" = {
                    enableACME = true;
                    forceSSL = true;
                    serverAliases = [ "www.cdwn.gay" ];
                    root = "${
                        (pkgs.stdenv.mkDerivation {
                            name = "cdwn.gay";
                            src = ./.;
                            installPhase = ''
                                mkdir $out && cd $out
                                touch index.html
                                echo "hi its me" >> index.html
                            '';
                        })
                    }";
                    locations."/robots.txt" = {
                        extraConfig = ''
                            rewrite ^/(.*)  $1;
                            return 200 "User-agent: *\nDisallow: /";
                        '';
                    };
                };

                security.acme.acceptTerms = true;
                security.acme.certs."cdwn.gay".email = "ceridwen@tutamail.com";

                services.unbound.enable = true;

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

                system.stateVersion = config.system.nixos.release;
            };
    };
}
