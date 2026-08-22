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

            mkSystemsWithImages =
                systems:
                builtins.listToAttrs (
                    lib.flatten (
                        map (cfg: [
                            {
                                name = cfg.hostname;
                                value = mkSystem cfg;
                            }
                            {
                                name = "${cfg.hostname}-iso";
                                value =
                                    let
                                        prev_modules = if builtins.hasAttr "extraModules" cfg then cfg.extraModules else [ ];
                                        prev_traits = if builtins.hasAttr "traits" cfg then cfg.traits else [ ];
                                        prev_system = if builtins.hasAttr "system" cfg then cfg.system else "x86_64-linux";
                                    in
                                    mkSystem {
                                        inherit (cfg) hostname;
                                        system = prev_system;
                                        traits = prev_traits;
                                        extraModules = prev_modules ++ [
                                            "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
                                        ];
                                    };
                            }
                        ]) systems
                    )
                );

        in
        mkSystemsWithImages [
            {
                hostname = "andropov";
                extraModules = homes;
                traits = [
                    graphical
                    development
                ];
            }

            {
                hostname = "kochiyama";
                extraModules = homes;
                traits = [
                    graphical
                    development
                ];
            }

            {
                hostname = "knorozov";
                traits = [ headless ];
            }
        ];
}
