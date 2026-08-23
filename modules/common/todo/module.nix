{
    pkgs,
    ...
}:
{
    fonts = {
        packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            fira-code
            fira-code-symbols
            liberation_ttf
            paratype-pt-sans
            paratype-pt-serif
            font-awesome_7
        ];

        fontconfig = {
            defaultFonts = {
                serif = [ "Liberation Serif" ];
                sansSerif = [ "Liberation Sans" ];
                monospace = [ "JetBrainsMono NF" ];
            };
        };
    };

    security.rtkit.enable = true;
    security.polkit.enable = true;
    security.soteria.enable = true;
}
