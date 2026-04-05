{config, pkgs, ... }:

{
	imports = [
		./modules/theme.nix
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

        # Dentro do seu home.nix
        xdg.configFile."swaync/style.css".text = let
                colors = config.lib.stylix.colors;
        in ''
                * {
                        font-family: "Noto Sans";
                        font-size: 10pt;
                }

                @define-color base00 #${colors.base00};
                @define-color base01 #${colors.base01};
                @define-color base02 #${colors.base02};
                @define-color base03 #${colors.base03};
                @define-color base04 #${colors.base04};
                @define-color base05 #${colors.base05};
                @define-color base06 #${colors.base06};
                @define-color base07 #${colors.base07};

                @define-color base08 #${colors.base08};
                @define-color base09 #${colors.base09};
                @define-color base0A #${colors.base0A};
                @define-color base0B #${colors.base0B};
                @define-color base0C #${colors.base0C};
                @define-color base0D #${colors.base0D};
                @define-color base0E #${colors.base0E};
                @define-color base0F #${colors.base0F};

                progress,
                progressbar,
                trough {
                        border: 1px solid @base0D;
                }

                trough {
                        background: @base01;
                }

                .notification.low {
                        border: 1px solid @base03;
                }

                .notification.low progress {
                        background: @base03;
                }

                .notification.normal {
                        border: 1px solid @base0D;
                }

                .notification.normal progress {
                        background: @base0F;
                }

                .notification.critical {
                        border: 1px solid @base08;
                }

                .notification.critical progress {
                        background: @base08;
                }

                .summary {
                        color: @base05;
                }

                .body {
                        color: @base06;
                }

                .time {
                        color: @base06;
                }

                .notification-action {
                        color: @base05;
                        background: @base01;
                }

                .notification-action:hover {
                        background: @base01;
                        color: @base05;
                }

                .notification-action:active {
                        background: @base0F;
                        color: @base05;
                }

                .close-button {
                        color: @base02;
                        background: @base08;
                }

                .close-button:hover {
                        background: lighter(@base08);
                        color: lighter(@base02);
                }

                .close-button:active {
                        background: @base08;
                        color: @base00;
                }

                .notification-content {
                        background: @base00;
                        border: 1px solid @base0D;
                        color: @base05;
                        border-radius: 10px;
                        margin: 5px;
                        padding: 10px;
                }

                .floating-notifications.background .notification-row .notification-background {
                        background: transparent;
                        color: @base05;
                }

                .notification-group .notification-group-buttons,
                .notification-group .notification-group-headers {
                        color: @base05;
                }

                .notification-group .notification-group-headers .notification-group-icon {
                        color: @base05;
                }

                .notification-group .notification-group-headers .notification-group-header {
                        color: @base05;
                }

                .notification-group.collapsed .notification-row .notification {
                        background: @base01;
                }

                .notification-group.collapsed:hover
                .notification-row:not(:only-child)
                .notification {
                        background: @base01;
                }

                .control-center {
                        background: @base00;
                        border: 1px solid @base0D;
                        border-radius: 15px;
                        color: @base05;
                        padding: 15px;
                }

                .control-center .notification-row .notification-background {
                        background: @base00;
                        color: @base05;
                }

                .control-center .notification-row .notification-background:hover {
                        background: @base00;
                        color: @base05;
                }

                .control-center .notification-row .notification-background:active {
                        background: @base0F;
                        color: @base05;
                }

                .widget-title {
                        color: @base05;
                        margin: 0.5rem;
                }

                .widget-title > button {
                        background: @base01;
                        border: 1px solid @base0D;
                        color: @base05;
                }

                .widget-title > button:hover {
                        background: @base01;
                }

                .widget-dnd {
                        color: @base05;
                }

                .widget-dnd > switch {
                        background: @base01;
                        border: 1px solid @base0D;
                }

                .widget-dnd > switch:hover {
                        background: @base01;
                }

                .widget-dnd > switch:checked {
                        background: @base0F;
                }

                .widget-dnd > switch slider {
                        background: @base06;
                }

                .widget-mpris {
                        color: @base05;
                }

                .widget-mpris .widget-mpris-player {
                        background: @base01;
                        border: 1px solid @base0D;
                }

                .widget-mpris .widget-mpris-player button:hover {
                        background: @base01;
                }

                .widget-mpris .widget-mpris-player > box > button {
                        border: 1px solid @base0D;
                }

                .widget-mpris .widget-mpris-player > box > button:hover {
                        background: @base01;
                        border: 1px solid @base0D;
                }

                .widget-buttons-grid button {
                        background: @base01;
                        border-radius: 10px;
                        color: @base0D;
                        margin: 5px;
                        padding: 10px;
                        font-size: 20px;
                }

                .widget-buttons-grid button:hover {
                        background: @base02;
                        color: @base0C;
                }

                .notification-row {
                        outline: none;
                }
        '';

        programs.direnv = {
                enable = true;
                nix-direnv.enable = true;
        };

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
                wasistlos
                

                # Som
                pavucontrol # Interface de áudio (Mixer)
                pamixer # Motor de áudio (Para atralhos de teclado)

                # Wi-Fi
                networkmanagerapplet # Interface gráfica de rede (nm-connection-editor)

                # Wallpaper
                waypaper # Interface visual para trocar wallpaper
                swww # Motor que renderiza o wallpaper"

                # Ferramentas de Verificação de Disco
                duf # Geral por disco
                ncdu # Mais lento porémm mais detalhista
	];

	programs.home-manager.enable = true;
}
