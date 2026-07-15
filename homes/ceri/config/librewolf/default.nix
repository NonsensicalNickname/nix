{ ... }:
{
    imports = [
        ./chrome.nix
        ./extensions.nix
        ./settings.nix
        ./search.nix
    ];

    # TODO: Extension permissions
    programs.librewolf = {
        enable = true;
        profiles."default".isDefault = true;
    };
}
