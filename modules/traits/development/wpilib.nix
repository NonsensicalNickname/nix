{ pkgs, inputs, ... }: {
    nixpkgs.overlays = [
        inputs.frc-nix.overlays.default
    ];

    environment.systemPackages =
        with pkgs;
        with wpilib;
        [
            datalogtool
            glass
            outlineviewer
            roborioteamnumbersetter
            robotbuilder
            shuffleboard
            smartdashboard
            sysid
            wpical
            wpilib-utility

            advantagescope
            choreo
            elastic-dashboard
        ];

    programs.vscode = {
        enable = true;
        package = pkgs.vscodium-fhs;
        extensions = with pkgs.vscode-extensions; [
            wpilibsuite.vscode-wpilib
            vscodevim.vim
            vscjava.vscode-java-pack
            ms-vscode.cpptools
            mvllow.rose-pine
        ];
    };
}
