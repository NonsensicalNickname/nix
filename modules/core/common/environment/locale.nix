{ pkgs, ... }:
{
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

    # TODO: sitilen pona
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
            ignoreUserConfig = true;
            waylandFrontend = true;
            addons = with pkgs; [
                fcitx5-rose-pine
            ];
        };
    };

    i18n.inputMethod.fcitx5.settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
            Name = "Default";
            "Default Layout" = "au";
            DefaultIM = "keyboard-ru-phonetic";
        };
        "Groups/0/Items/0".Name = "keyboard-au";
        "Groups/0/Items/1".Name = "keyboard-ru-phonetic";
    };
}
