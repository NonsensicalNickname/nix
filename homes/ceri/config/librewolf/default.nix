{ ... }:
{
    imports = [
        ./chrome.nix
        ./extensions.nix
        ./settings.nix
        ./search.nix
    ];

    programs.librewolf = {
        enable = true;
        profiles."default".isDefault = true;
    };
}
