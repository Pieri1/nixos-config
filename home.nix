{config, pkgs, ... }:

{
	home.username = "pieri";
	home.homeDirectory = "/home/pieri";
	home.stateVersion = "24.11";

	# Pacotes
	home.packages = with pkgs; [
		neovim
		wget
		git
		curl
		htop
		btop
		unzip
	];

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			sysup = "sudo nixos-rebuild switch --flake ~/nixos-config#pieri-notebook";
			conf = "nvim ~/nixos-config/flake.nix";
		};

		oh-my-zsh = {
			enable = true;
			plugins = [ "git" "docker" "sudo" ];
			theme = "robbyrussell";
		};
	};

	# Garante que o home-manager se gerencie
	programs.home-manager.enable = true;
}
