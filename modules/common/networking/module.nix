{
    pkgs,
    ...
}:
{
    networking = {
        nameservers = [ "127.0.0.1" ];
        search = [ "local" ];
    };

    services.avahi = {
        enable = true;
        nssmdns4 = true;

        publish = {
            enable = true;
            addresses = true;
            domain = true;
        };
    };

    services.unbound = {
        enable = true;
        resolveLocalQueries = true;
        settings = {
            server = {
                verbosity = 1;
                interface = [ "127.0.0.1" ];
                access-control = [ "127.0.0.1/32 allow" ];

                domain-insecure = [ "\"local.\"" ];
                private-domain = [ "\"local.\"" ];
                local-zone = [ "\"local.\" refuse" ];

                qname-minimisation = "yes";
                do-ip4 = "yes";
                do-udp = "yes";
                do-tcp = "yes";
                root-hints = "${pkgs.dns-root-data}/root.hints";
            };

            forward-zone = [
                {
                    name = ".";
                    forward-tls-upstream = true;
                    forward-addr = [
                        "1.1.1.1@853#cloudflare-dns.com"
                        "2606:4700:4700::1111@853#cloudflare-dns.com"
                        "1.0.0.1@853#cloudflare-dns.com"
                        "2606:4700:4700::1001@853#cloudflare-dns.com"
                        "8.8.8.8@853#dns.google"
                        "2001:4860:4860::8888@853#dns.google"
                        "8.8.4.4@853#dns.google"
                        "2001:4860:4860::8844@853#dns.google"
                    ];
                }
            ];
        };
    };
}
