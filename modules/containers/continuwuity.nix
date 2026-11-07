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
        privateNetwork = false;

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
                            address = [
                                "0.0.0.0"
                                "::1"
                            ];
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

                services.caddy = {
                    enable = true;
                    virtualHosts."matrix.cdwn.gay".extraConfig = ''
                        reverse_proxy 0.0.0.0:6167
                    '';
                    virtualHosts."cdwn.gay".extraConfig = ''
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

                services.unbound.enable = true;

                system.stateVersion = config.system.nixos.release;
            };
    };
}
