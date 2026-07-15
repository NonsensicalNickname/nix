{ ... }:
{
    imports = [
        ./chrome.nix
        ./extensions.nix
        ./settings.nix
        ./search.nix
        # ./bookmarks.nix
    ];

    # TODO: Extension permissions
    programs.librewolf = {
        enable = true;
        profiles."default".isDefault = true;
    };
}
