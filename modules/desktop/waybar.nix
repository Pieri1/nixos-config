{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        modules-left = [ "hyprland/workspaces"];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "custom/wallpaper" "pulseaudio" "network" "battery" "clock" "custom/settings" ];

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{name}";
          active-only = false;
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>/n<tt><small>{calendar}</small></tt>";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [ "Bateria:" ];
        };

        "network" = {
          format-wifi = "WiFi {essid}";
          format-disconnected = "WiFi Desconectado";
          on-click = "nm-connection-editor";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-icons = {
            default = [ "Som: "];
          };
          on-click = "pavucontrol";
        };

        "custom/wallpaper" = {
          format = "Wallpaper";
          on-click = "waypaper";
          tooltip = false;
        };

        "custom/settings" = {
          format = "Configurações";
          on-click = "swaync-client -t -sw";
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        border: none;
        border-radius: 0;
      }
      window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
        border-bottom: 2px solid #89b4fa;
      }
      #workspaces button {
        padding: 0 5px;
        color: #89b4fa;
      }
      #workspaces button.active {
        color: #f5c2e7;
        background-color: #313244;
      }
      #clock, #baterry, #network, #pulseaudio, #custom-wallpaper, #custom-settings{
        padding: 0 10px;
      }
    '';
  };
}
