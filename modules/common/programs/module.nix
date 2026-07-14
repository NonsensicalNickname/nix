{ pkgs, ... }:
{
    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
        enableSSHSupport = true;
    };

    programs.fish.enable = true;
    programs.command-not-found.enable = false;
}
