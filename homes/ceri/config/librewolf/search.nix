{ pkgs, ... }:
{
    programs.librewolf.profiles."default".search = {
        force = true;
        engines = {
            nix-packages = {
                name = "Nix Packages";
                urls = [
                    {
                        template = "https://search.nixos.org/packages";
                        params = [
                            {
                                name = "type";
                                value = "packages";
                            }
                            {
                                name = "query";
                                value = "{searchTerms}";
                            }
                        ];
                    }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
            };

            nix-options = {
                name = "Nix Options";
                urls = [
                    {
                        template = "https://search.nixos.org/options";
                        params = [
                            {
                                name = "type";
                                value = "options";
                            }
                            {
                                name = "query";
                                value = "{searchTerms}";
                            }
                        ];
                    }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@no" ];
            };

            nixos-wiki = {
                name = "NixOS Wiki";
                urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nw" ];
            };

            arch-wiki = {
                name = "Arch Wiki";
                urls = [ { template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; } ];
                definedAliases = [ "@aw" ];
                iconMapObj."16" = "https://wiki.archlinux.org/favicon.ico";
            };

            man-pages = {
                name = "Man Pages";
                urls = [ { template = "https://man.archlinux.org/search?q={searchTerms}"; } ];
                definedAliases = [ "@mp" ];
                iconMapObj."16" = "https://man.archlinux.org/favicon.ico";
            };
        };
    };
}
