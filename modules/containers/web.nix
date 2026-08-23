{
    lib,
    config,
    ...
}:
let
    inherit (lib) mkIf;
    secrets = config.age.secrets;
    enabledContainers = config.modules.containers.enabledContainers;
    name = "web";
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
                    useACMEHost = "cdwn.gay";
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
