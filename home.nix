{config, pkgs, ... }:

{
	imports = [
		./modules/shell/zsh.nix
		./modules/shell/git.nix
		./modules/shell/nvim.nix
                ./modules/shell/starship.nix
                ./modules/desktop/hyprland.nix
	];

	home.username = "pieri";
	home.homeDirectory = "/home/pieri";
	home.stateVersion = "24.11";

	# Pacotes
        home.packages = with pkgs; [
                kitty # Terminal
                wofi # Menu de aplicativos
                waybar # Barra superior
                swww # Papel de parede
                libnotify # Notificações
                mako # Servidor de notificações
		brave
		wget
		curl
		htop
		btop
		unzip
	];

	programs.home-manager.enable = true;
}
