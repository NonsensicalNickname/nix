{ config, pkgs, ... }:
{
    # TODO 
    # mini-snippets
    # fzf stuff
    # more language suppport
    programs.nvf.enable = true;
    programs.nvf.settings.vim = {
        viAlias = false;
        vimAlias = false;
        lineNumberMode = "relNumber";

        options = {
            tabstop = 4;
            shiftwidth = 4;
            autoindent = true;
            smartindent = true;
            foldmethod = "manual";
        };

        globals.mapleader = "\\";
        globals.maplocalleader = ",";

        clipboard = {
            enable = true;
            registers = "unnamedplus";
            providers.wl-copy.enable = true;
        };

        theme = {
            enable = true;
            name = "rose-pine";
            style = "moon";
        };

        lsp.enable = true;
        languages = {
            enableTreesitter = true;
            enableFormat = true;

            nix.enable = true;
            nix.lsp.servers = [ "nixd" ];
            clang.enable = true;
            # rust.enable = true;
            python.enable = true;
            assembly.enable = true;
            markdown.enable = true;
            typst.enable = true;
            typst.lsp.servers = [ "tinymist" ];
            # haskell.enable = true;
            # haskell.lsp.servers = [ "hls" ];
        };
    };
}
