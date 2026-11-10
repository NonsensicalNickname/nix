{
    lib,
    config,
    pkgs,
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

        hostBridge = "br-containers";
        localAddress = "10.100.0.2/24";

        config =
            {
                config,
                ...
            }:
            {
                services.matrix-continuwuity = {
                    enable = true;
                    settings = {
                        global = {
                            server_name = "matrix.cdwn.gay";
                            allow_registration = true;
                            registration_token = "543ut43utw%$#%^$5"; # TODO secret
                            allow_encryption = true;
                            allow_federation = true;
                            allow_room_creation = false;
                            trusted_servers = [ "matrix.org" ]; # TODO expand
                            address = [ "0.0.0.0" ];
                            new_user_displayname_suffix = "";

                            well_known = {
                                server = "matrix.cdwn.gay:443";
                            };

                            # TODO section
                            auto_join_rooms = [ ];
                            admins_list = [ "@ceridwen:matrix.cdwn.gay" ];
                        };
                    };
                };

                networking = {
                    firewall.allowedTCPPorts = [
                        6167
                    ];

                    useHostResolvConf = lib.mkForce false;
                    nameservers = [ "10.100.0.1" ];

                    defaultGateway = {
                        address = "10.100.0.1";
                        interface = "eth0";
                    };
                };

                system.stateVersion = config.system.nixos.release;
            };
    };
}
