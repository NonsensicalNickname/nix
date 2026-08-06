{ lib, ... }:
let
    inherit (lib) mkMerge mkIf;
in
{
    mkIfElse =
        pred:
        { body, elseBody }:
        (mkMerge [
            (mkIf pred body)
            (mkIf (!pred) elseBody)
        ]);

    mkContainer =
        enabledContainers: { name, body }: (mkIf (builtins.elem name enabledContainers) body).content;
}
