{ config, pkgs, ... }:

{
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-margin-top = 10;
      control-center-margin-botton = 10;
      control-center-margin-right = 10;
      control-center-width = 400;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;

      widgets = [
        "buttons-grid"
        "mpris"
        "title"
        "dnd"
        "notifications"
      ];

      widget-config = {
        "title" = {
          "text" = "Notificações";
          "clear-all-button" = true;
          "button-text" = "Limpar Tudo";
        };
        "dnd" = {
          "text" = "Não pertube";
        };
        "buttons-grid" = {
          "actions" = [
            {
              "label" = "Logout";
              "command" = "wlogout";
            }
            {
              "label" = "Rede";
              "command" = "nm-connection-editor";
            }
            {
              "label" = "Audio";
              "command" = "pavucontrol";
            }
            {
              "label" = "Wallpaper";

              "command" = "waypaper";
            }
          ];
        };
      };
    };

    style = ''
      .notification-row { outline: none; }
      .notification-content {
        background: #1e1e2e;
        color: #cdd6f4;
        border: 1px solid #89b4fa;
        border-radius: 10px;
        margin: 5px;
        padding: 10px;
      }
      .control-center {
        background: rgba(30, 30, 46, 0.95);
        border: 1px solid #89b4fa;
        border-radius: 15px;
        color: #cdd6f4;
        padding: 15px;
      }
      .widget-buttons-grid button {
        background: #313244;
        border-radius: 10px;
        color: #89b4fa;
        margin: 5px;
        padding: 10px;
        font-size: 20px;
      }
      .widget-buttons-grid button:hover {
        background: #45475a;
        color: #f5c2e7:
      }
    '';
  };
}
