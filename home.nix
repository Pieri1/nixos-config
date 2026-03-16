{config, pkgs, ... }:

{
	imports = [
		./modules/shell/zsh.nix
		./modules/shell/git.nix
	];

	home.username = "pieri";
	home.homeDirectory = "/home/pieri";
	home.stateVersion = "24.11";

	# Pacotes
	home.packages = with pkgs; [
		brave
		neovim
		wget
		git
		curl
		htop
		btop
		unzip
	];

	programs.home-manager.enable = true;
}
