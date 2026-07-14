{
    pkgs,
    config,
    configured,
    ...
}:
let
    cascade = "https://raw.githubusercontent.com/cascadefox/cascade/refs/heads/main/";
in
{
    programs.librewolf = {
        enable = true;

        # toolkit.legacyUserProfileCustomizations.stylesheets = true

        profiles."default" = {
            userChrome = ''
                @import "${cascade}integrations/rose-pine/cascade-moon.css"

                @import "${cascade}chrome/includes/cascade-config.css";
                @import "${cascade}chrome/includes/cascade-layout.css";
                @import "${cascade}chrome/includes/cascade-responsive.css";
                @import "${cascade}chrome/includes/cascade-floating-panel.css";

                @import "${cascade}chrome/includes/cascade-nav-bar.css";
                @import "${cascade}chrome/includes/cascade-tabs.css";

            '';
        };
    };
}
