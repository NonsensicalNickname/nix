{ config, pkgs, ... }:
{
    xdg.configFile."fish/themes/rose-pine-moon.theme".source
        = "/home/ceri/.config/nix/themes/fish/rose-pine-moon.theme";

    programs.fish = {
        enable = true;

        shellAliases = {
            v="nvim";
            m="math";

            nrs="sudo nixos-rebuild switch --flake . --impure";
            nfu="sudo nix flake update";
            nup="nfu; nrs";
            nsc="sudo nix-collect-garbage && sudo nix-collect-garbage -d";

            stopwatch= ''
                while true
                 printf '%s\r' "$(date)" 
                end
            '';
            # replace with a not-shit solution
            # umka="/home/ceri/umka/umka";
        };

        plugins = [
            { name = "z"; src = pkgs.fishPlugins.z.src; }
            { name = "done"; src = pkgs.fishPlugins.done.src; }
            { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
            { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
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
}
