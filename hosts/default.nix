{ inputs, ... }:
let
    lib = inputs.nixpkgs.lib;
in
{
    flake.nixosConfigurations =
        let
            inherit (lib.lists)
                concatLists
                flatten
                singleton
                filter
                elem
                ;
            inherit (lib.strings) hasSuffix;
            inherit (lib.filesystem) listFilesRecursive;

            hm = inputs.home-manager.nixosModules.home-manager;

            # Modules
            root = ../modules;
            common = root + /common;
            containers = root + /containers;
            options = root + /options;

            # Traits
            traits = root + /traits;
            graphical = traits + /graphical;
            development = traits + /development;
            headless = traits + /headless;

            homes = [
                hm
                ../homes
            ];

            mkModuleTree =
                {
                    path,
                    ignoredPaths ? [ ],
                }:
                (filter (path: hasSuffix "module.nix" path) (
                    map toString (filter (path: !elem path ignoredPaths) (listFilesRecursive path))
                ));

            mkModulesFor =
                hostname:
                {
                    traits ? [ ],
                    extraModules ? [ ],
                }:
                flatten (concatLists [
                    extraModules
                    [ ./${hostname}/host.nix ]
                    (map (path: mkModuleTree { inherit path; }) (
                        traits
                        ++ [
                            options
                            common
                            containers
                        ]
                    ))
                ]);

            mkSystem =
                let
                    inherit (inputs) self;
                in
                {
                    hostname,
                    system ? "x86_64-linux",
                    traits ? [ ],
                    extraModules ? [ ],
                }:
                lib.nixosSystem {
                    specialArgs = {
                        inherit inputs self;
                    };
                    system = system;
                    modules =
                        mkModulesFor hostname {
                            extraModules = extraModules;
                            traits = traits;
                        }
                        ++ [
                            inputs.agenix.nixosModules.default
                            { networking.hostName = hostname; }
                        ];
                };

        in
        {
            andropov = mkSystem {
                hostname = "andropov";
                extraModules = homes;
                traits = [
                    graphical
                    development
                ];
            };

            kochiyama = mkSystem {
                hostname = "kochiyama";
                extraModules = homes;
                traits = [
                    graphical
                    development
                ];
            };

            knorozov = mkSystem {
                hostname = "knorozov";
                traits = [ headless ];
            };
        };
}
