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
            pathweaver
            roborioteamnumbersetter
            robotbuilder
            shuffleboard
            smartdashboard
            sysid
            wpical
            wpilib-utility

            vscode-wpilib
            advantagescope
            choreo
            elastic-dashboard
        ];
}
