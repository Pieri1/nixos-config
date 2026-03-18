{config, pkgs, ... }:

{
	imports = [
		./modules/shell/zsh.nix
		./modules/shell/git.nix
		./modules/shell/nvim.nix
                ./modules/shell/starship.nix
                ./modules/desktop/hyprland.nix
                ./modules/desktop/kitty.nix
                ./modules/desktop/brave.nix
                ./modules/desktop/waybar.nix
                ./modules/desktop/swaync.nix
                ./modules/desktop/discord.nix
                ./modules/desktop/vscode.nix
        ];

	home.username = "pieri";
	home.homeDirectory = "/home/pieri";
        home.stateVersion = "24.11";
        
        nixpkgs.config.allowUnfree = true;

        services.swaync = {
          enable = true;
        };

	# Pacotes
        home.packages = with pkgs; [
                kitty # Terminal
                wofi # Menu de aplicativos
                waybar # Barra superior
                libnotify # Notificações
                kdePackages.dolphin # Gerenciador de arquivos
		wget
		curl
		htop
		btop
                unzip
                nerd-fonts.jetbrains-mono
                nerd-fonts.symbols-only
                noto-fonts-color-emoji
                font-awesome
                xdg-desktop-portal-hyprland
                grimblast # Para prints e captura de tela rápida
                numlockx
                nil #Servidor de linguagem pra nix
                socat #Listener de Evento

                # Som
                pavucontrol # Interface de áudio (Mixer)
                pamixer # Motor de áudio (Para atralhos de teclado)

                # Wi-Fi
                networkmanagerapplet # Interface gráfica de rede (nm-connection-editor)

                # Wallpaper
                waypaper # Interface visual para trocar wallpaper
                swww # Motor que renderiza o wallpaper"
	];

	programs.home-manager.enable = true;
}
