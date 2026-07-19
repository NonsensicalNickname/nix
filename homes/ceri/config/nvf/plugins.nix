{ config, pkgs, ... }:
{
    programs.nvf.settings.vim.mini = {
        pairs.enable = true;
        comment.enable = true;
        bracketed.enable = true;
        files.enable = true;
        jump.enable = true;
        bufremove.enable = true;
        statusline.enable = true;
        indentscope.enable = true;
        starter.enable = true;
        animate.enable = true;
        icons.enable = true;
        completion.enable = true;
        surround.enable = true;
    };

    programs.nvf.settings.vim.lazy.enable = true;

    programs.nvf.settings.vim.telescope = {
        enable = true;
        extensions = [
            {
                name = "hoogle";
                packages = [ pkgs.vimPlugins.telescope_hoogle ];
            }
            {
                name = "fzf";
                packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
                setup = {
                    fzf = {
                        fuzzy = true;
                    };
                };
            }
        ];
    };

    programs.nvf.settings.vim.extraPlugins = {
        mini-tabline = {
            package = pkgs.vimPlugins.mini-tabline;
            setup = ''
                require("mini.tabline").setup {
                show_icons = true,
                    format = function(buf_id, label)
                    local a = "a"
                    return buf_id .. MiniTabline.default_format(buf_id, label)
                    end,
                }
            '';
        };

        rustaceanvim = {
            package = pkgs.vimPlugins.rustaceanvim;
        };

        haskell-tools-nvim = {
            package = pkgs.vimPlugins.haskell-tools-nvim;
            # setup = ''
            #     vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)

            #     vim.keymap.set(
            #       "n",
            #       "K",
            #       function()
            #         vim.cmd.Haskell({'hover', 'actions'})
            #       end,
            #       { silent = true, buffer = bufnr }
            #     )
            # '';
        };

        wakatime = {
            package = pkgs.vimPlugins.vim-wakatime;
        };

        # cord = {
        #     package = pkgs.vimPlugins.cord-nvim;
        # };

        typst-preview = {
            package = pkgs.vimPlugins.typst-preview-nvim;
            setup = ''
                require("typst-preview").setup {
                    open_cmd = 'librewolf --new-window %s',
                    host = '127.0.0.1',
                    port = 0,
                }
            '';
        };
    };

    programs.nvf.settings.vim.startPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
            name = "vim-umka";
            src = pkgs.fetchFromGitHub {
                owner = "marekmaskarinec";
                repo = "vim-umka";
                rev = "8872f9f8b82f2e91e40c48174f6af85cbb36aa87";
                hash = "sha256-P0w5cXWxAV+nXKiRVBOnixeB0j4IUqPMxLb7GlH2dNY=";
            };
        })
    ];
}
