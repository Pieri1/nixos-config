{config, pkgs, ... }:

{
	imports = [
		./modules/shell/zsh.nix
		./modules/shell/git.nix
		./modules/shell/nvim.nix
		./modules/shell/starship.nix
	];

	home.username = "pieri";
	home.homeDirectory = "/home/pieri";
	home.stateVersion = "24.11";

	# Pacotes
	home.packages = with pkgs; [
		brave
		wget
		curl
		htop
		btop
		unzip
	];

	programs.home-manager.enable = true;
}
