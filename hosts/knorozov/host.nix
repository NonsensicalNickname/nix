{
    pkgs,
    ...
}:
{
    imports = [ ./hardware.nix ];
    config = {
        system.stateVersion = "26.05";

        modules = {
            environment.shell = {
                name = "zsh";
                package = pkgs.zsh;
            };

            containers.enabledContainers = [
                "nginx"
            ];

            network.dnsResolver = "unbound";
        };
    };
}
