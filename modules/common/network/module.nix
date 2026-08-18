{
    lib,
    config,
    ...
}:
let
    inherit (lib) mkIf mkMerge;
    dnsResolver = config.modules.network.dnsResolver;
    useResolved = dnsResolver == "resolved";
    useUnbound = dnsResolver == "unbound";
in
{

    networking = mkMerge [
        {
            networkmanager.enable = true;
            firewall.enable = false;
        }
        (mkIf useUnbound {
            nameservers = [ "127.0.0.1" ];
            search = [ "local" ];
            networkmanager.dns = "none";
        })
    ];

    services.resolved.enable = useResolved;

    systemd = mkIf useUnbound {
        services = {
            unbound.wants = [ "dnscrypt-proxy.service" ];
            unbound.after = [ "dnscrypt-proxy.service" ];
        };
    };

    services.avahi = mkIf useUnbound {
        enable = true;
        nssmdns4 = true;

        publish = {
            enable = true;
            addresses = true;
            domain = true;
        };
    };

    services.dnscrypt-proxy = mkIf useUnbound {
        enable = true;
        settings = {
            require_dnssec = true;
            require_nolog = true;
            require_nofilter = true;
            listen_addresses = [ "127.0.0.1:5300" ];

            sources.public-resolvers = {
                urls = [
                    "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
                    "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
                ];
                cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
                minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
            };
        };
    };

    services.unbound = mkIf useUnbound {
        enable = true;

        settings = {
            server = {
                do-not-query-localhost = false;
                interface = [ "127.0.0.1" ];
                port = 53;
                access-control = [ "127.0.0.0/32 allow" ];
                module-config = ''"validator iterator"'';
            };
            forward-zone = [
                {
                    name = ".";
                    forward-tls-upstream = true;
                    forward-addr = [
                        "127.0.0.1@5300"
                        "9.9.9.9"

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

        # resolveLocalQueries = true;
        # settings = {
        #     server = {
        #         verbosity = 1;
        #         interface = [ "127.0.0.1" ];

        #         domain-insecure = [ "\"local.\"" ];
        #         private-domain = [ "\"local.\"" ];
        #         local-zone = [ "\"local.\" refuse" ];

        #         qname-minimisation = "yes";
        #         do-ip4 = "yes";
        #         do-udp = "yes";
        #         do-tcp = "yes";
        #         root-hints = "${pkgs.dns-root-data}/root.hints";
        #     };
        # };
    };
}
