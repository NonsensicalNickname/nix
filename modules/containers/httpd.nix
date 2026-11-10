{
    lib,
    config,
    ...
}:
let
    inherit (lib) mkIf;
    secrets = config.age.secrets;
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

                services.unbound.enable = true;

                system.stateVersion = config.system.nixos.release;
            };
    };
}

# security.acme.acceptTerms = true;
# security.acme.certs."cdwn.gay" = {
#     email = "ceridwen@tutamail.com";
#     domain = "cdwn.gay";
#     dnsProvider = "porkbun";
#     dnsPropagationCheck = true;
#
#     credentialFiles = {
#         "PORKBUN_API_KEY_FILE" = secrets.porkbunAPIKey.path;
#         "PORKBUN_SECRET_API_KEY_FILE" = secrets.porkbunAPISecretKey.path;
#     };
# };
#
