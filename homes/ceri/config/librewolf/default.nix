{ ... }:
{
    imports = [
        ./chrome.nix
        ./extensions.nix
        ./settings.nix
        ./search.nix
    ];

    xdg.configFile."/home/ceri/.librewolf/profiles.ini".force = true;

    # TODO: Extension permissions
    programs.librewolf = {
        enable = true;
        profiles."default".isDefault = true;
    };
}
