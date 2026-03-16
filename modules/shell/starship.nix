{ config, pkgs, ... }:

{
	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			add_newline = false;
			line_break.disabled = true;
			character = {
				sucess_symbol = "[>>](bold green)";
				error_symbol = "[>>](bold red)";
			};
			directory = {
				style = "bold blue";
			};
		};
	};
}			
