{ pkgs, ... }:
{
    users.users = {
        ceri = {
            isNormalUser = true;
            extraGroups = [
                "wheel"
                "input"
                "networkmanager"
            ];
        };

        postgres = {
            isSystemUser = true;
            createHome = false;
            group = "postgres";
        };
    };

    users.groups.postgres = { };

    users.defaultUserShell = pkgs.fish;
}
