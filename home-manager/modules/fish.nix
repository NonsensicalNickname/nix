{ pkgs, ...}:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			function fish_greeting
			set noises woof arf awruff miau mrrp nya
			set colours trans lesbian pride
			cowsay -f tux $noises[(random 1 (count $noises))] | blahaj -c $colours[(random 1 (count $colours))]
			end
			'';
		shellInit = ''
			function fish_prompt
			set -l last_status $status
			set -l display_status 
			if test $last_status -ne 0
				set stat (set_color ed8796)"[$last_status]" (set_color normal)
					end

					set -g __fish_git_prompt_showdirtystate 1
					set -g __fish_git_prompt_showcolorhints 1
					set -g __fish_git_prompt_showupstream git

					set -g __fish_git_prompt_char_stateseparator '|'
					set -g __fish_git_prompt_char_cleanstate '✔'
					set -g __fish_git_prompt_char_dirtystate '*'
					set -g __fish_git_prompt_char_invalidstate '#'
					set -g __fish_git_prompt_char_stagedstate '+'
					set -g _fish_git_prompt_char_upstream_ahead '⇡'
					set -g __fish_git_prompt_char_upstream_behind '⇣'
					set -g __fish_git_prompt_char_upstream_equal '='

					set -g __fish_git_prompt_color_upstream 7dc4e4
					set -g __fish_git_prompt_color_prefix f5a97f
					set -g __fish_git_prompt_color_suffix f5a97f
					set -g __fish_git_prompt_color_cleanstate a6da95

					echo -s (set_color c6a0f6) (whoami) (set_color normal) "❯" (set_color f5bde6) (prompt_pwd -d 3 -D 1) $stat (fish_git_prompt "[%s]") (set_color normal) "❯ "
					end
					'';
		shellAliases = {
			m = "math";
			v = "nvim";
			wm = "wikiman";
		};

		plugins = [
		{ name = "done"; src = pkgs.fishPlugins.done.src; }
#{}
#{}
#{}
		];
	};
}
