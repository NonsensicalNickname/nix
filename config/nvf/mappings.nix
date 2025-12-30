{ config, pkgs, ...}:
{
    programs.nvf.settings.vim.keymaps = [
    {
      key = "<C-n>";
      mode = "n";
      silent = true;
      action = ":noh<CR>";
    }
    {
      key = "<S-e>";
      mode = "n";
      silent = true;
      action = ":lua vim.diagonstic.open_float()<CR>";
    }
    {
      key = "<leader>t";
      mode = "n";
      silent = true;
      action = ":lua MiniFiles.open()<CR>";
    }
    {
      key = "<leader>o";
      mode = "n";
      silent = true;
      action = ":Checkbox<CR>";
    }
    {
      key = "<leader>]";
      mode = "n";
      silent = true;
      action = ":Heading increase<CR>";
    }
    {
      key = "<leader>[";
      mode = "n";
      silent = true;
      action = ":Heading decrease<CR>";
    }
    {
      key = "<A-]>";
      mode = "n";
      silent = true;
      action = "<Cmd>bnext<CR>";
    }
    {
      key = "<A-[>";
      mode = "n";
      silent = true;
      action = "<Cmd>bprevious<CR>";
    }
    {
      key = "<A-q>";
      mode = "n";
      silent = true;
      action = ":lua MiniBufremove.wipeout()<CR>";
    }
    {
      key = "<A-1>";
      mode = "n";
      silent = true;
      action = "<Cmd>buffer 1<CR>";
    }
    {
      key = "<A-2>";
      mode = "n";
      silent = true;
      action = "<Cmd>buffer 2<CR>";
    }
    {
      key = "<A-3>";
      mode = "n";
      silent = true;
      action = "<Cmd>buffer 3<CR>";
    }
    {
      key = "<A-4>";
      mode = "n";
      silent = true;
      action = "<Cmd>buffer 4<CR>";
    }
    {
      key = "<A-5>";
      mode = "n";
      silent = true;
      action = "<Cmd>buffer 5<CR>";
    }
    {
      key = "<A-6>";
      mode = "n";
      silent = true;
      action = "<Cmd>buffer 6<CR>";
    }
    {
      key = "<A-7>";
      mode = "n";
      silent = true;
      action = "<Cmd>buffer 7<CR>";
    }
    {
      key = "<A-8>";
      mode = "n";
      silent = true;
      action = "<Cmd>buffer 8<CR>";
    }
    {
      key = "<A-9>";
      mode = "n";
      silent = true;
      action = "<Cmd>buffer 9<CR>";
    }
    ];
}
