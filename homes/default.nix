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

    specialArgs = {
        inherit
            inputs
            self
            inputs'
            configured
            self'
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
