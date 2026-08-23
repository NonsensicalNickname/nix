{
    lib,
    config,
    ...
}:
let
    inherit (lib) mkIf;
    enabledContainers = config.modules.containers.enabledContainers;
    name = "continuwuity";
in
{
    containers.${name} = mkIf (builtins.elem name enabledContainers) {
        autoStart = true;
        privateNetwork = false;

        hostAddress = "192.168.100.30";
        localAddress = "192.168.100.31";
        hostAddress6 = "fc00::5";
        localAddress6 = "fc00::6";

        config =
            {
                config,
                ...
            }:
            {
                services.caddy.enable = true;
                services.caddy.virtualHosts."matrix.cdwn.gay" = {
                    extraConfig = ''
                        reverse_proxy 127.0.0.1:8008
                    '';
                    serverAliases = [
                        "matrix.cdwn.gay:8448"
                        "www.matrix.cdwn.gay"
                        "www.matrix.cdwn.gay:8448"
                    ];
                };

                services.matrix-continuwuity = {
                    enable = true;
                    settings = {
                        global = {
                            server_name = "matrix.cdwn.gay";

                            trusted_servers = [ "matrix.org" ];
                            new_user_displayname_suffix = "";
                            auto_join_rooms = [ ];
                            admins_list = [ ];
                        };
                    };
                };

                services.unbound.enable = true;

                networking = {
                    firewall.allowedTCPPorts = [
                        8448
                        443
                    ];

                    nat = {
                        enable = true;
                        internalInterfaces = [ "ve-+" ];
                        externalInterface = "ens3";
                        enableIPv6 = true;

                        forwardPorts = [
                            {
                                destination = "192.168.100.31:8448";
                                sourcePort = 8448;
                            }
                            {
                                destination = "192.168.100.31:443";
                                sourcePort = 443;
                            }
                        ];
                    };
                };

                system.stateVersion = config.system.nixos.release;
            };
    };
}
