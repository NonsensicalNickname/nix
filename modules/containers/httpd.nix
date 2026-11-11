{
    lib,
    config,
    ...
}:
let
    inherit (lib) mkIf;
    enabledContainers = config.modules.containers.enabledContainers;
    name = "httpd";
in
{
    containers.${name} = mkIf (builtins.elem name enabledContainers) {
        autoStart = true;
        privateNetwork = true;

        hostBridge = "br-containers";
        localAddress = "10.100.0.3/24";

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

                networking.firewall.allowedTCPPorts = [
                    80
                ];

                system.stateVersion = config.system.nixos.release;
            };
    };
}
