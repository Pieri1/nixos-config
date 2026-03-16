{ config, pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			sysup = "sudo nixos-rebuild switch --flake ~/nixos-config#pieri-notebook";
		};

		oh-my-zsh = {
			enable = true;
			plugins = [ "git" "docker" "sudo" ];
			theme = "robbyrussell";
		};
	};
}
