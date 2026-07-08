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

    #env = modules.usrEnv;
    #sys = modules.system;
    #defaults = sys.programs.default;

    specialArgs = {
        inherit
            inputs
            self
            inputs'
            self' # defaults
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
