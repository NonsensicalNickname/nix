{
    config,
    lib,
    ...
}:
let
    shell = config.modules.environment.shell;
    mainUser = config.modules.system.mainUser;

    allUsers = config.modules.system.users;
    otherUsers = lib.remove mainUser allUsers;
in
{
    users.users = {
        ${mainUser} = {
            isNormalUser = true;
            extraGroups = [
                "wheel"
                "input"
                "networkmanager"
                "tty"
                "dialout"
                "uucp"
            ];
        };

        postgres = {
            isSystemUser = true;
            createHome = false;
            group = "postgres";
        };
    }
    // builtins.listToAttrs (
        map (user: {
            name = user;
            value = {
                group = user;
                isNormalUser = true;
            };
        }) otherUsers
    );

    users.groups =
        builtins.listToAttrs (
            map (user: {
                name = user;
                value = { };
            }) otherUsers
        )
        // {
            postgres = { };
        };

    users.defaultUserShell = shell.package;
}
