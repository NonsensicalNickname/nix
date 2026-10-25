{
    configured,
    pkgs,
    lib,
    ...
}:
let
    inherit (lib) mkIf;
    shell = configured.environment.shell;
in
{
    programs.fish = mkIf (shell.name == "fish") {
        enable = true;

        shellAliases = {
            v = "nvim";
            m = "math";
            now = "cal && echo && date";

            nrs = "nh os switch --impure";
            nfu = "sudo nix flake update";
            nup = "nfu; nrs";
            nsc = "sudo nix-collect-garbage && sudo nix-collect-garbage -d";

            stopwatch = ''
                while true
                 printf '%s\r' "$(date)" 
                end
            '';
            # replace with a not-shit solution
            # umka="/home/ceri/umka/umka";
        };

        plugins = [
            {
                name = "z";
                src = pkgs.fishPlugins.z.src;
            }
            {
                name = "done";
                src = pkgs.fishPlugins.done.src;
            }
            {
                name = "autopair";
                src = pkgs.fishPlugins.autopair.src;
            }
            {
                name = "fzf-fish";
                src = pkgs.fishPlugins.fzf-fish.src;
            }
        ];

        # TODO: write greeting
        interactiveShellInit = ''
            fish_config theme choose "rose-pine-moon"
            function fish_greeting
            end
        '';

        # TODO: rewrite old prompt
        # shellInit = ''
        # 	function fish_prompt
        # 	set -l last_status $status
        # 	set -l display_status
        #     if test $last_status -ne 0
        #         set stat (set_color ed8796)"[$last_status]" (set_color normal)
        #             end

        #             set -g __fish_git_prompt_showdirtystate 1
        #             set -g __fish_git_prompt_showcolorhints 1
        #             set -g __fish_git_prompt_showupstream git

        #             set -g __fish_git_prompt_char_stateseparator '|'
        #             set -g __fish_git_prompt_char_cleanstate '✔'
        #             set -g __fish_git_prompt_char_dirtystate '*'
        #             set -g __fish_git_prompt_char_invalidstate '#'
        #             set -g __fish_git_prompt_char_stagedstate '+'
        #             set -g _fish_git_prompt_char_upstream_ahead '⇡'
        #             set -g __fish_git_prompt_char_upstream_behind '⇣'
        #             set -g __fish_git_prompt_char_upstream_equal '='

        #             set -g __fish_git_prompt_color_upstream 7dc4e4
        #             set -g __fish_git_prompt_color_prefix f5a97f
        #             set -g __fish_git_prompt_color_suffix f5a97f
        #             set -g __fish_git_prompt_color_cleanstate a6da95

        #             echo -s (set_color c6a0f6) (whoami) (set_color normal) "❯" (set_color f5bde6) (prompt_pwd -d 3 -D 1) $stat (fish_git_prompt "[%s]") (set_color normal) "❯ "
        #             end
        # '';
    };

    xdg.configFile."fish/themes/rose-pine-moon.theme" = {
        enable = true;
        text = ''
            # syntax highlighting variables
            # https://fishshell.com/docs/current/interactive.html#syntax-highlighting-variables
            fish_color_normal e0def4
            fish_color_command c4a7e7
            fish_color_keyword 9ccfd8
            fish_color_quote f6c177
            fish_color_redirection 3e8fb0
            fish_color_end 908caa
            fish_color_error eb6f92
            fish_color_param ea9a97
            fish_color_comment 908caa
            # fish_color_match --background=brblue
            fish_color_selection --reverse
            # fish_color_history_current --bold
            fish_color_operator e0def4
            fish_color_escape 3e8fb0
            fish_color_autosuggestion 908caa
            fish_color_cwd ea9a97
            # fish_color_cwd_root red
            fish_color_user f6c177
            fish_color_host 9ccfd8
            fish_color_host_remote c4a7e7
            fish_color_cancel e0def4
            fish_color_search_match --background=232136
            fish_color_valid_path

            # pager color variables
            # https://fishshell.com/docs/current/interactive.html#pager-color-variables
            fish_pager_color_progress ea9a97
            fish_pager_color_background --background=2a273f
            fish_pager_color_prefix 9ccfd8
            fish_pager_color_completion 908caa
            fish_pager_color_description 908caa
            fish_pager_color_secondary_background
            fish_pager_color_secondary_prefix
            fish_pager_color_secondary_completion
            fish_pager_color_secondary_description
            fish_pager_color_selected_background --background=393552
            fish_pager_color_selected_prefix 9ccfd8
            fish_pager_color_selected_completion e0def4
            fish_pager_color_selected_description e0def4

            # custom color variables
            fish_color_subtle 908caa
            fish_color_text e0def4
            fish_color_love eb6f92
            fish_color_gold f6c177
            fish_color_rose ea9a97
            fish_color_pine 3e8fb0
            fish_color_foam 9ccfd8
            fish_color_iris c4a7e7
        '';
    };
}
