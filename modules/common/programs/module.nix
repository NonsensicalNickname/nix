{
    lib,
    pkgs,
    config,
    ...
}:
let
    inherit (lib) mkIf;
    shell = config.modules.environment;
in
{
    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
        enableSSHSupport = true;
    };
}
