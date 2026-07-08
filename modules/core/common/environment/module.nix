{ pkgs, ... }:
{
    # Locale
    time.timeZone = "Australia/Sydney";

    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_AU.UTF-8";
        LC_IDENTIFICATION = "en_AU.UTF-8";
        LC_MEASUREMENT = "en_AU.UTF-8";
        LC_MONETARY = "en_AU.UTF-8";
        LC_NAME = "en_AU.UTF-8";
        LC_NUMERIC = "en_AU.UTF-8";
        LC_PAPER = "en_AU.UTF-8";
        LC_TELEPHONE = "en_AU.UTF-8";
        LC_TIME = "en_AU.UTF-8";
    };

    console.keyMap = "us";

    # TODO: inputMethod

    environment = {
        pathsToLink = [
            "/share/applications"
            "/share/xdg-desktop-portal"
        ];

        systemPackages = with pkgs; [
            vim
            git
            wget
            fd
            psmisc
            tree
            bat
            btop
            unzip
            usbutils
            pciutils
            lm_sensors
            net-tools
            inetutils
            gcc
            gnumake
            cmake
            nixfmt

            (catppuccin-sddm.override {
                flavor = "macchiato";
                accent = "mauve";
            })
        ];
    };
}
