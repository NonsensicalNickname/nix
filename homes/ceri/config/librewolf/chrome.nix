{ flakeroot, ... }:
{
    programs.librewolf.profiles."default" = {
        userChrome = ''
            #browser vbox#appcontent tabbrowser, 
            #content, 
            #tabbrowser-tabpanels,
            browser[type=content-primary],
            browser[type=content] > html 
            { 
                background: #222 !important; 
            }
        '';

        userContent = ''
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
}
