{ config, pkgs, lib, ...}:
{
    programs.nvf.settings.vim.augroups = [
        {
            name = "BindSetup";
        }
    ];

    programs.nvf.settings.vim.autocmds = [
        {
            event = [ "BufEnter" ];
            pattern = [ "*.rs" ];
            group = "BindSetup";
            desc = "Set Rust binds";
            callback = lib.mkLuaInline ''
                function()
                    if vim.bo.filetype == 'rust' then
                        local bufnr = vim.api.nvim_get_current_buf()
                        local opts = { noremap = true, silent = true, buffer = bufnr, }

                        vim.keymap.set(
                            "n",
                            "K", 
                            function()
                                vim.cmd.RustLsp({'hover', 'actions'})
                            end,
                            { silent = true, buffer = bufnr }
                        )
                        vim.keymap.set(
                            "n",
                            "E", 
                            function()
                                vim.cmd.RustLsp({ 'renderDiagnostic', 'current' })
                            end,
                            { silent = true, buffer = bufnr }
                        )
                    end
                end
            '';
        }
        {
            event = [ "BufEnter" ];
            pattern = [ "*.hs" ];
            group = "BindSetup";
            desc = "Set Haskell binds";
            callback = lib.mkLuaInline ''
                function()
                    if vim.bo.filetype == 'haskell' then
                        local ht = require('haskell-tools')
                        local bufnr = vim.api.nvim_get_current_buf()
                        local opts = { noremap = true, silent = true, buffer = bufnr, }

                        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)

                        vim.keymap.set(
                            "n",
                            "K", 
                            function()
                                vim.cmd.Haskell({'hover', 'actions'})
                            end,
                            { silent = true, buffer = bufnr }
                        )
                    end
                end
                '';
        }
    ];
}
