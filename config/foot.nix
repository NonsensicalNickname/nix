{ pkgs, config, ... }:
{
    programs.foot = {
        enable = true;
        settings = {
            main = {
                include = "/home/ceri/.config/nix/themes/foot/rose-pine-moon";
                font = "JetBrainsMono NF:size=11";
                font-size-adjustment = "0.5";
                initial-window-mode = "windowed";
            };
            cursor.style = "block";
            cursor.blink = "no";
            mouse.hide-when-typing = "no";
            csd.size = "0";
            key-bindings = {
                clipboard-copy = "Control+Shift+c XF86Copy";
                clipboard-paste = "Control+Shift+v XF86Paste";
            };
        };
    };
}
