{config, pkgs, ... }:

{
	imports = [
		./modules/shell/zsh.nix
		./modules/shell/git.nix
		./modules/shell/nvim.nix
                ./modules/shell/starship.nix
                ./modules/desktop/hyprland.nix
                ./modules/desktop/mako.nix
                ./modules/desktop/kitty.nix
                ./modules/desktop/brave.nix
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
                kdePackages.dolphin # Gerenciador de arquivos
		wget
		curl
		htop
		btop
		unzip
	];

	programs.home-manager.enable = true;
}
