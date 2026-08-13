{ pkgs, ... }:
{
    networking.networkmanager.enable = true;

    fonts = {
        packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            fira-code
            fira-code-symbols
            liberation_ttf
            paratype-pt-sans
            paratype-pt-serif
            font-awesome_7
        ];

        fontconfig = {
            defaultFonts = {
                serif = [ "Liberation Serif" ];
                sansSerif = [ "Liberation Sans" ];
                monospace = [ "JetBrainsMono NF" ];
            };
        };
    };

    security.rtkit.enable = true;
    security.polkit.enable = true;
    security.soteria.enable = true;

    networking.firewall.enable = false;

    environment.systemPackages = [
        (pkgs.stdenv.mkDerivation {
            pname = "xroar";
            version = "1.12";

            src = pkgs.fetchgit {
                url = "https://www.6809.org.uk/git/xroar.git";
                rev = "190788e71ae63a4ca44f4e6e66f907852aaf26bb";
                hash = "sha256-GMOh7EQT7u4JeRnIHaSIZqgTTWK4s/3jXtNscGuOm5w=";
            };

            nativeBuildInputs = with pkgs; [
                wrapGAppsHook3
                gobject-introspection

                wget

                texinfo
                pkg-config
                autoconf
                automake
                autogen
                copyDesktopItems
            ];

            buildInputs = with pkgs; [
                pulseaudio
                libpng
                microfetch
                dconf

                gtk3
                glib
                gdk-pixbuf
                gsettings-desktop-schemas
                adwaita-icon-theme
            ];

            desktopItems = [
                (pkgs.makeDesktopItem {
                    desktopName = "XRoar";
                    name = "xroar";
                    exec = "xroar";
                    icon = builtins.fetchurl "https://www.6809.org.uk/dragon/images/tinydragon.png";
                    categories = [
                        "Utility"
                        "Emulator"
                    ];
                })
            ];

            configurePhase = ''
                ./autogen.sh
                ./configure --prefix=$out
            '';

            buildPhase = ''
                make
            '';

            installPhase = ''
                make install 
            '';

            meta = {
                description = "Emulator for the Dragon 32/64; Tandy Colour Computers 1, 2 and 3; the Tandy MC-10; and others";
                license = pkgs.lib.licenses.gpl3Plus;
                maintainers = with pkgs.lib.maintainers; [
                    # TODO
                ];
                platforms = pkgs.lib.platforms.linux;
                homepage = "https://www.6809.org.uk/xroar/";
            };
        })
    ];
}
