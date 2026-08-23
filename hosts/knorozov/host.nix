{
    pkgs,
    ...
}:
{
    imports = [ ./hardware.nix ];
    config.modules = {
        environment.shell = {
            name = "zsh";
            package = pkgs.zsh;
        };

        containers.enabledContainers = [
            "web"
            # "continuwuity"
        ];

        network.dnsResolver = "unbound";
    };

    config.system.stateVersion = "26.05";
}
