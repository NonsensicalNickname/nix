{
    pkgs,
    lib,
    config,
    ...
}:
let
    inherit (import ../helpers lib config) mkContainer;
    name = "webserver";
in
{
    containers.${name} = mkContainer {
        inherit name;
        body = {
            autoStart = true;
            privateNetwork = true;
            hostAddress = "192.168.100.10";
            localAddress = "192.168.100.11";
            hostAddress6 = "fc00::1";
            localAddress6 = "fc00::2";
            config =
                {
                    config,
                    pkgs,
                    lib,
                    ...
                }:
                {

                    services.httpd = {
                        enable = true;
                        adminAddr = "ceridwen@tutamail.com";
                    };

                    networking = {
                        firewall.allowedTCPPorts = [ 80 ];

                        # Use systemd-resolved inside the container
                        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
                        # useHostResolvConf = lib.mkForce false;
                    };

                    # services.resolved.enable = true;

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
