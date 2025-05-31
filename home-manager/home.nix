{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ceri";
  home.homeDirectory = "/home/ceri";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.neovim

    pkgs.mako
    pkgs.swww
    pkgs.ironbar
    pkgs.fuzzel
    pkgs.waytrogen
    pkgs.niri
    pkgs.alacritty
    pkgs.kitty

    pkgs.fastfetch
    pkgs.hyfetch
    pkgs.blahaj
    pkgs.cowsay

    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ceri/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
  	enable = true;
	userEmail = "nonsensical_nickname@protonmail.com";
	userName = "ceridwen15";
  };

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
	  plugins = [
	  	{ name = "done"; src = pkgs.fishPlugins.done.src; }
	  	#{}
	  	#{}
	  	#{}
	  ];
  };



################
### GREETING ###
################


#alias m="math"
#
#alias v="nvim"
#
#alias wm="wikiman"
#
#alias lsh="ls -A -I'*'"

}
