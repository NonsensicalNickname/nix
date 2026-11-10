{
    lib,
    config,
    ...
}:
let
    inherit (lib) mkIf;
    secrets = config.age.secrets;
    enabledContainers = config.modules.containers.enabledContainers;
    name = "murmur";
in
{
    containers.${name} = mkIf (builtins.elem name enabledContainers) {
        autoStart = true;
        privateNetwork = true;

        hostBridge = "br-containers";
        localAddress = "10.100.0.4/24";

        config =
            {
                config,
                ...
            }:
            {
                services.murmur = {
                    enable = true;
                    users = 10;
                    registerHostname = "barking.cdwn.gay";
                    registerName = "the gays";
                    welcometext = "woof woof arf awruff";
                    registerPassword = "yuri";
                    password = "ghfdjkyuivcgfnrd542thjw";
                    registerUrl = "cdwn.gay";
                    openFirewall = true;
                    extraConfig = ''
                        allowping=true
                    '';
                };

                systemd.services.murmur.serviceConfig.RestrictAddressFamilies = lib.mkForce [
                    "AF_UNIX"
                    "AF_INET"
                    "AF_INET6"
                    "AF_NETLINK"
                ];

                networking = {
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
