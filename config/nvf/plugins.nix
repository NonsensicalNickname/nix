{ config, pkgs, ...}:
{
    programs.nvf.settings.vim.mini = {
        pairs.enable = true;
        align.enable = true;
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
        cord = {
            package = pkgs.vimPlugins.cord-nvim;
        };
        rustaceanvim = {
            package = pkgs.vimPlugins.rustaceanvim;
        };
        haskell-tools = {
            package = pkgs.vimPlugins.haskell-tools-nvim;
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
