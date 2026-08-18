{
    lib,
    config,
    ...
}:
let
    inherit (import ../../utils { inherit lib; }) mkContainer;
    enabledContainers = config.modules.containers.enabledContainers;
    name = "webserver";
in
{
    containers.${name} = mkContainer enabledContainers {
        inherit name;
        body = {
            autoStart = true;
            privateNetwork = false;

            hostAddress = "192.168.100.10";
            localAddress = "192.168.100.11";
            hostAddress6 = "fc00::1";
            localAddress6 = "fc00::2";

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
                        firewall.allowedTCPPorts = [ 80 ];
                        nat = {
                            enable = true;
                            internalInterfaces = [ "ve-+" ];
                            externalInterface = "ens3";
                            enableIPv6 = true;

                            forwardPorts = [
                                {
                                    destination = "192.168.100.11:80";
                                    sourcePort = 80;
                                }
                            ];
                        };
                    };

                    services.unbound.enable = true;

                    system.stateVersion = config.system.nixos.release;
                };
        };
    };
}
