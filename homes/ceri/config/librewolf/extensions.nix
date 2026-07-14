{ ... }:
{
    # configuring extensions is shite it seems
    # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265/17
    # from above:

    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then, download the XPI by filling it in to the install_url template, unzip it,
    # run `jq .browser_specific_settings.gecko.id manifest.json` or
    # `jq .applications.gecko.id manifest.json` to get the UUID

    programs.librewolf.policies.ExtensionSettings =
        let
            extension = shortId: uuid: {
                name = uuid;
                value = {
                    install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                    installation_mode = "normal_installed";
                };
            };
        in
        builtins.listToAttrs [
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            (extension "desmodder-for-desmos" "DesModder@jared-hughes.github.io")
            (extension "ruffle_rs" "{b5501fd1-7084-45c5-9aa6-567c2fcf5dc6}")
            (extension "firemonkey" "firemonkey@eros.man")
            (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
            (extension "firefox-color" "FirefoxColor@mozilla.com")
        ];
}
