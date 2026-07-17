lib: config:
let
    inherit (lib) mkIf;

    cfg = config.modules.containers;
in
{
    mkContainer = { name, body }: (mkIf (builtins.elem name cfg.enabledContainers) body).content;
}
