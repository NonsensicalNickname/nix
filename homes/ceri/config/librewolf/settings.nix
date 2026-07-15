{ ... }:
{
    programs.librewolf.profiles."default".settings = {
        force = true;

        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.enabled" = false;
        "browser.startup.page" = 3;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "extensions.autoDisableScopes" = 0;

        # possibly needed for google docs copy paste
        "dom.event.clipboardevents.enabled" = true;
        "dom.event.contextmenu.enabled" = true;

        "privacy.resistFingerprinting" = false;
    };
}
