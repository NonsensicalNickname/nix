{ ... }:
{
    programs.librewolf.profiles."default".bookmarks = {
        force = true;
        settings = [
            {
                name = "wikipedia";
                tags = [ "wiki" ];
                keyword = "wiki";
                url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
            }
            {
                name = "kernel.org";
                url = "https://www.kernel.org";
            }
            "separator"
            {
                name = "school";
                toolbar = true;
                bookmarks = [
                    {
                        name = "timetable";
                        url = "https://nixos.org/";
                    }
                    {
                        name = "wiki";
                        tags = [
                            "wiki"
                            "nix"
                        ];
                        url = "https://wiki.nixos.org/";
                    }
                ];
            }
        ];
    };
}
