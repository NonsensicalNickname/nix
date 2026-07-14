{
    inputs',
    self',
    self,
    config,
    lib,
    ...
}:
let
    inherit (self) inputs;
    inherit (lib.attrsets) genAttrs;
    inherit (config) modules;

    configured = modules;
    flakeroot = builtins.toString ../.;

    specialArgs = {
        inherit
            inputs
            self
            inputs'
            configured
            self'
            flakeroot
            ;
    };
in
{
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = specialArgs;
        users = genAttrs config.modules.system.users (name: ./${name}/home.nix);
    };
}
