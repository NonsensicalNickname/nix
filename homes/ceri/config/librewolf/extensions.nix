{
    lib,
    pkgs,
    ...
}:
let
    # https://gitlab.com/rycee/nur-expressions/-/blob/master/lib/mozilla.nix
    mkExtension =
        {
            pname,
            version ? "latest",
            shortId ? pname,
            uuid,
            sha256,
            ...
        }:
        pkgs.stdenv.mkDerivation {
            name = "${pname}-${version}";

            src = builtins.fetchurl {
                url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                name = builtins.convertHash {
                    hash = sha256;
                    toHashFormat = "nix32";
                };
            };

            preferLocalBuild = true;
            allowSubstitutes = true;

            buildCommand = ''
                dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
                mkdir -p "$dst"
                install -v -m644 "$src" "$dst/${uuid}.xpi"
            '';
        };
in
{
    # From here:
    # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265/17
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then, download the XPI by filling it in to the install_url template, unzip it,
    # run `jq .browser_specific_settings.gecko.id manifest.json` or
    # `jq .applications.gecko.id manifest.json` to get the UUID
    programs.librewolf.profiles."default".extensions = {
        force = true;

        packages = [
            (mkExtension {
                pname = "ublock-origin";
                uuid = "uBlock0@raymondhill.net";
                sha256 = "sha256-QMMVsNp4cYaBVez656UKWN+gkgrr2GXgCCFJhvG3xXg=";
            })
            (mkExtension {
                pname = "desmodder-for-desmos";
                uuid = "DesModder@jared-hughes.github.io";
                sha256 = "sha256-FaXw5iOLFD0sc9yOL31KdKoMWB8DGLEX/jrFF60kLcw=";
            })
            (mkExtension {
                pname = "ruffle_rs";
                uuid = "{b5501fd1-7084-45c5-9aa6-567c2fcf5dc6}";
                sha256 = "sha256-Bt6XcOOhTyGalxxwUg+fNGAn5sqBQe+T/wIjezlbpiw=";
            })
            (mkExtension {
                pname = "firemonkey";
                uuid = "firemonkey@eros.man";
                sha256 = "sha256-1DLgI1vIhYobnsz5Un9LCZiWQw7ZFTfBm4AdEmqkdqA=";
            })
            (mkExtension {
                pname = "styl-us";
                uuid = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
                sha256 = "sha256-aVQICVK/EdrmbZ1Gz3ObqYlmxi1Sq4rl2IhNHmIMdCg=";
            })
            (mkExtension {
                pname = "firefox-color";
                uuid = "FirefoxColor@mozilla.com";
                sha256 = "sha256-t/sHtniPcjPdYiPngOGJtMe5VsJcQEk8KNcCBJMkkpI=";
            })
            (mkExtension {
                pname = "wave-accessibility-tool";
                uuid = "{9bbf6724-d709-492e-a313-bfed0415a224}";
                sha256 = "sha256-J7+t/HK3E7of6qfCV/7cUoIiGhUmn5DWohk0ijtJvzs=";
            })
        ];
    };
}
