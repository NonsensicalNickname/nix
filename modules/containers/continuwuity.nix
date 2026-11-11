{
    lib,
    config,
    pkgs,
    ...
}:
let
    inherit (lib) mkIf;
    secrets = config.age.secrets;
    keyFile = "/run/livekit.key";
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
                                client = "https://matrix.cdwn.gay";
                            };

                            matrix_rtc = {
                                foci = [
                                    {
                                        type = "livekit";
                                        livekit_service_url = "https://matrix.cdwn.gay/livekit/jwt";
                                    }
                                ];
                            };

                            # TODO section
                            auto_join_rooms = [ ];
                            admins_list = [ "@ceridwen:matrix.cdwn.gay" ];
                        };
                    };
                };

                services.livekit = {
                    enable = true;
                    openFirewall = true;
                    inherit keyFile;
                    settings.rtc = {
                        tcp_port = 7881;
                        udp_port = 7882;
                        port_range_start = 0;
                        port_range_end = 0;
                        use_external_ip = true;
                    };
                };

                services.lk-jwt-service = {
                    enable = true;
                    livekitUrl = "wss://matrix.cdwn.gay/livekit/sfu";
                    inherit keyFile;
                };

                systemd.services.livekit-key = {
                    before = [
                        "lk-jwt-service.service"
                        "livekit.service"
                    ];
                    wantedBy = [ "multi-user.target" ];
                    path = with pkgs; [
                        livekit
                        coreutils
                        gawk
                    ];

                    script = ''
                        echo "Key missing, generating key"
                        echo "lk-jwt-service: $(livekit-server generate-keys | tail -1 | awk '{print $3}')" > "${keyFile}"
                    '';

                    serviceConfig.Type = "oneshot";
                    unitConfig.ConditionPathExists = "!${keyFile}";
                };

                systemd.services.lk-jwt-service.environment.LIVEKIT_FULL_ACCESS_HOMESERVERS = "matrix.cdwn.gay";

                networking = {
                    firewall.allowedTCPPorts = [
                        6167
                        7880
                        7881
                        8080
                    ];

                    firewall.allowedUDPPorts = [
                        7882
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
