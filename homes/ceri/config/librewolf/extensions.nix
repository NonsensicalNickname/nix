{ ... }:
let
    mkExtensions =
        extensionIDs:
        builtins.listToAttrs (
            map (uuid: {
                name = uuid;
                value = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${uuid}/latest.xpi";
                    installation_mode = "force_installed";
                    private_browsing = true;
                };
            }) extensionIDs
        );
in
{
    programs.librewolf.policies = {
        DefaultDownloadDirectory = "\${home}/Downloads";
        ExtensionSettings = (
            mkExtensions [
                "uBlock0@raymondhill.net"
                "DesModder@jared-hughes.github.io"
                "{b5501fd1-7084-45c5-9aa6-567c2fcf5dc6}" # ruffle
                "firemonkey@eros.man"
                "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" # stylus
                "FirefoxColor@mozilla.com"
                "{9bbf6724-d709-492e-a313-bfed0415a224}" # WAVE
            ]
        );
    };
}
