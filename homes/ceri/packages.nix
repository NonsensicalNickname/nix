{ pkgs, ... }:
{
    # TODO: Make good
    home.packages = with pkgs; [
        # CLI utils
        hyperfine
        beets
        ripgrep
        haskellPackages.hoogle
        flac
        wakatime-cli
        ffmpeg
        newsraft
        blahaj
        nmap
        fzf
        cowsay
        mpc
        hyprpicker
        file
        mpris-scrobbler
        mprisence

        wl-clipboard
        microfetch
        tealdeer
        syncthing
        nautilus
        pinentry-curses
        ascii
        file
        cloc
        # mpv
        imv
        zathura
        yt-dlp
        libnotify
        brightnessctl
        xwayland-satellite
        jq

        drawterm-wayland

        # GUI apps

        # GUI game
        quake3e
        owmods-cli
        heroic
        prismlauncher
        gale
        r2modman

        # GUI other
        angryipscanner
        chromium
        slack
        qutebrowser
        krita
        pwvucontrol
        fluffychat
        nicotine-plus
        vesktop
        keepassxc
        tageditor
        parsec-bin
        schismtracker

        # TUI apps
        wiremix
        bulletty
        presenterm
        wikiman
        gdu
        yazi
        tiny

        # PL

        factor-lang
        typst
        jdk17
        python3
        mlton
        ghc
        zig
        haskellPackages.hoogle
        haskell-language-server
        gforth

        # PL utils
        valgrind
        gdb
        glslviewer

        (mpv.override { scripts = [ mpvScripts.mpris ]; })

        # Future reference for building from a Cargo project
        # (mprisence.override {
        #     rustPlatform.buildRustPackage = (
        #         oldAttrsGen:
        #         rustPlatform.buildRustPackage (
        #             let
        #                 fs = lib.fileset;
        #                 sourceFiles = /home/ceri/Projects/rs/mprisence/.;
        #                 oldAttrs = (oldAttrsGen finalAttrs);
        #             in
        #                 oldAttrs
        #             // {
        #                 src = fs.toSource {
        #                     root = /home/ceri/Projects/rs/mprisence/.;
        #                     fileset = sourceFiles;
        #                 };
        #                 pname = "mprisence";
        #                 cargoHash = "sha256-xWd99ZGAH/7hzXSZP5NRTGjON7kPE+TrYVZ2mrfRhzc=";
        #                 nativeBuildInputs = [ pkg-config ];
        #                 buildInputs = [
        #                     dbus
        #                     openssl
        #                 ];
        #             }
        #         )
        #     );})
    ];
}
