{ pkgs, config, ... }:
{
	programs.ironbar = {
		enable = true;
		package = pkgs.ironbar;
		config = {
			monitors.DP-1 = {
				position = "bottom";
				height = 12;
				start = [
					{ type = "workspaces"; }
				];
				center = [
					{
					type = "focused";
					icon_size = 16;
					}
				];
				end = [
					{ type = "tray"; }
					{ 
					type = "sys_info"; 
					format = [ "C:{cpu_percent} M:{memory_percent}" ];
					}
					{ type = "clock"; }
				];
			};
			style = ''
				@define-color dark-primary #2a273f;
				@define-color dark-secondary #393552;
				@define-color white #e0def4;
				@define-color active #6699cc;
				@define-color urgent #8f0a0a;
				@define-color iris #c4a7e7;

				* {
					border-radius: 0;
					border: none;
					box-shadow: none;
					background-image: none;
					font-family: JetBrainsMono NF;
				}

				#bar, popover, popover contents, calendar {
					background-color: @dark-primary;
				}

				box, button, label {
					background-color: @dark-primary;
					color: @white;
				}

				button {
					padding-left: 0.5em;
					padding-right: 0.5em;
				}

				button:hover, button:active {
					background-color: @dark-secondary;
				}

				.sysinfo {
					margin-left: 1em;
					margin-right: 0.5em;
				}

				.clock {
					margin-right: 0.5em;
					font-weight: normal;
				}

				.popup-clock .calendar-clock {
					font-size: 2.0em;
				}

				.popup-clock .calendar {
					color: @white; 
					font-size: 1.0em
				}
			'';
		};
	};
}
