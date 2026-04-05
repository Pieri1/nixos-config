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
          "columns" = 4;
          "actions" = [
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
            {
              "label" = "󰐥";
              "command" = "systemctl poweroff";
            }
            {
              "label" = "󰜉";
              "command" = "systemctl reboot";
            }
            {
              "label" = "󰍃";
              "command" = "hyprctl dispatch exit";
            }
            {
              "label" = "󰒲";
              "command" = "systemctl suspend";
            }
          ];
        };
      };
    };

  };
}
