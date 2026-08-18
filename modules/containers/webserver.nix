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
            networking.nat = {
                enable = true;
                # Use "ve-*" when using nftables instead of iptables
                internalInterfaces = [ "ve-+" ];
                externalInterface = "ens3";
                enableIPv6 = true;
            };
            # hostAddress = "192.168.100.10";
            # localAddress = "192.168.100.11";
            # hostAddress6 = "fc00::1";
            # localAddress6 = "fc00::2";
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
                    };

                    services.unbound.enable = true;

                    system.stateVersion = config.system.nixos.release;
                };

            # autoStart = true;
            # ephemeral = true;
            # privateNetwork = false;

            # bindMounts."/var/www/webserver" = {
            #     hostPath = "/home/ceri/webserver";
            #     isReadOnly = true;
            # };

            # hostAddress = "192.168.100.50";
            # localAddress = "192.168.100.51";

            # config = { containerPkgs, ... }: {
            #     networking.useDHCP = lib.mkDefault true;

            #     services.httpd = {
            #         enable = true;
            #         adminAddr = "ceridwen@tutamail.com";
            #         # virtualHosts."localhost" = {
            #         #     documentRoot = "/var/www/webserver";
            #         #     serverAliases = [ ];
            #         # };
            #     };

            #     networking.firewall.allowedTCPPorts = [ 80 ];
            #     environment.systemPackages = with containerPkgs; [ ];
            #     system.stateVersion = config.system.nixos.release;
            # };
        };
    };
}
