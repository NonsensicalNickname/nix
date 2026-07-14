{
    flakeroot,
    configured,
    ...
}:
let
    palette = configured.style.colourscheme.palette;
in
{
    programs.schizofox = {
        enable = true;

        settings = {
            "browser.newtabpage.enabled" = false;
            "browser.tabs.closeWindowWithLastTab" = false;

            # restore tabs
            "browser.startup.page" = 3;

            # possibly needed for google docs copy paste
            "dom.event.clipboardevents.enabled" = true;
            "dom.event.contextmenu.enabled" = true;

            "privacy.resistFingerprinting" = false;
        };

        theme = {
            colors = with palette; {
                background-darker = base00;
                background = base01;
                foreground = base02;
                primary = base0D;
            };

            font = "Liberation";

            extraUserChrome = ''
                #browser vbox#appcontent tabbrowser, 
                #content, 
                #tabbrowser-tabpanels,
                browser[type=content-primary],
                browser[type=content] > html 
                { 
                    background: #222 !important; 
                }

                @-moz-document url(about:home), url(about:newtab), url(about:privatebrowsing) {
                    .click-target-container *, .top-sites-list * {
                        color: #fff !important ;
                        text-shadow: 2px 2px 2px #222 !important ;
                    }

                    body::before {
                        content: "" ;
                        z-index: -1 ;
                        position: fixed ;
                        top: 0 ;
                        left: 0 ;
                        background: #f9a no-repeat url(${flakeroot}/res/walls/rpm-lines.png) center ;
                        background-size: cover ;
                        width: 100vw ;
                        height: 100vh ;
                    }
                }

                @-moz-document url(about:blank), url(about:newtab) {
                    #newtab-window, html:not(#ublock0-epicker) {
                        background: #222 !important;
                    }
                }
            '';
        };

        search = {
            defaultSearchEngine = "Brave";
            removeEngines = [
                "Google"
                "Bing"
                "Amazon.com"
                "eBay"
                "Twitter"
            ];
            searxUrl = "https://searx.be";
            searxQuery = "https://searx.be/search?q={searchTerms}&categories=general";
            addEngines = [
                {
                    name = "Nix Packages";
                    Alias = "@np";
                    Method = "GET";
                    URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                }

                {
                    name = "Nix Options";
                    Alias = "@no";
                    Method = "GET";
                    URLTemplate = "https://search.nixos.org/options?type=options&query={searchTerms}";
                }

                {
                    name = "NixOS Wiki";
                    Alias = "@nw";
                    Method = "GET";
                    URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                }
            ];
        };

        security = {
            sanitizeOnShutdown.enable = true;
            sandbox.enable = true;
            userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
        };

        misc = {
            drmFix = true;
            disableWebgl = false;
            # startPageURL = "file://${builtins.readFile ./startpage.html}";
            contextMenu.enable = true;
        };

        extensions = {
            darkreader.enable = false;
            simplefox.enable = false;

            extraExtensions = {
                "webextension@metamask.io".install_url =
                    "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
            };
        };

        bookmarks = [
            {
                Title = "Example";
                URL = "https://example.com";
                Favicon = "https://example.com/favicon.ico";
                Placement = "toolbar";
                Folder = "FolderName";
            }
        ];
    };
}
