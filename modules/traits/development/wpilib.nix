{ lib, pkgs, ... }: {
    environment.systemPackages = [
        (
            let
                self = pkgs.stdenv.mkDerivation (finalAttrs: {
                    name = "wpilib-unwrapped";

                    src = pkgs.fetchFromGitHub {
                        owner = "wpilibsuite";
                        repo = "allwpilib";
                        rev = "817d119e835ac13b7898a1420ea8feb835e247fc";
                        hash = "sha256-tsJ/HWTZkMyNcmepoJl40fRS87n8uZ0u/rQ6Icw1idU=";
                    };

                    nativeBuildInputs = with pkgs; [
                        gradle
                        makeWrapper
                        gcc14
                        udev
                    ];

                    buildInputs = pkgs.lib.flatten [
                        (with pkgs; [
                            jdk25
                            glfw
                        ])
                        (with pkgs.xorg; [
                            libX11.dev
                            libXcursor.dev
                            libXrandr.dev
                            libXinerama.dev
                            libXi.dev
                        ])
                    ];

                    # if the package has dependencies, mitmCache must be set
                    mitmCache = pkgs.gradle.fetchDeps {
                        pkg = self;
                        data = ./deps.json;
                    };

                    # this is required for using mitm-cache on Darwin
                    # __darwinAllowLocalNetworking = true;

                    gradleFlags = [ "--build-cache" ];

                    gradleBuildTask = "build";

                    # will run the gradleCheckTask (defaults to "test")
                    doCheck = true;

                    installPhase = ''
                        mkdir -p $out/{bin,share/wpilib}
                        cp build/libs/wpilib-all.jar $out/share/wpilib

                        makeWrapper ${lib.getExe pkgs.jre} $out/bin/wpilib \
                          --add-flags "-jar $out/share/wpilib/wpilib-all.jar"
                    '';

                    meta.sourceProvenance = with lib.sourceTypes; [
                        fromSource
                        binaryBytecode # mitm cache
                    ];

                    # patchPhase = ''
                    #     echo "systemProp.http.proxyHost=proxy_host" >> gradle.properties
                    #     echo "systemProp.http.proxyPort=proxy_port" >> gradle.properties
                    # '';

                    # buildPhase = ''
                    #     ./gradlew build
                    # '';

                    # installPhase = ''
                    #     mkdir -p $out/bin
                    #     # cp foo $out/bin
                    #     touch $out/bin/result
                    #     echo "output path: $out"
                    # '';
                });
            in
            self
        )
    ];
}
