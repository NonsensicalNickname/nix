{
    pkgs,
    lib,
    config,
    ...
}:
let
    inherit (lib.modules) mkIf;
    gameRoot = config.modules.environment.game;
    game = config.modules.environment.game.enable;
    emulation = gameRoot.emulation.enable;
in
{
    # https://discourse.nixos.org/t/niri-xwayland-satellite-black-steam-window-fix/77107
    nixpkgs.overlays = mkIf game [
        (final: prev: {
            steam = prev.steam.override {
                extraArgs = "-cef-disable-gpu-compositing";
            };
        })
    ];

    programs.steam = mkIf game {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
        (olympus.override { celesteWrapper = "steam-run"; })
    ];
}
