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
        modules-right = [ "idle_inhibitor" "backlight" "pulseaudio" "network" "battery" "clock#date" "clock#time" "custom/wallpaper" "custom/settings" "custom/lock" "custom/power" ];

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{name}";
          active-only = false;
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "clock#date" = {
          format = "  {:%d/%m/%Y}";
          tooltip-format = "<big>{:%A, %d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          on-click = "sh -lc 'gtk-launch org.gnome.Calendar || gnome-calendar'";
        };

        "clock#time" = {
          format = "  {:%H:%M}";
          tooltip-format = "<big>{:%H:%M:%S}</big>";
          on-click = "sh -lc 'gtk-launch org.gnome.Calendar || gnome-calendar'";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "󱐋 {time}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        "network" = {
          format-wifi = "   {signalStrength}%";
          format-ethernet = "󰈀   {ifname}";
          format-linked = "󰈀   sem IP";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{essid}  ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}  via cabo";
          tooltip-format-disconnected = "Sem rede";
          on-click = "nm-connection-editor";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
          tooltip = true;
        };

        "backlight" = {
          "format" = "{icon}  {percent}%";
          "format-icons" = [ "󰃞" "󰃟" "󰃠" ];
          "on-scroll-up" = "brightnessctl set 1%+";
          "on-scroll-down" = "brightnessctl set 1%-";
        };

        "pulseaudio" = {
          format = "{icon}   {volume}%";
          format-muted = "󰖁";
          format-icons = {
            default = [ "" "" "" ];
            headphone = "󰋋";
            headset = "󰋎";
            hands-free = "󰋎";
            phone = "";
            portable = "󰏰";
            car = "";
          };
          on-click = "pavucontrol";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
        };

        "custom/wallpaper" = {
          format = "󰸉 ";
          on-click = "waypaper";
          tooltip-format = "Wallpaper";
          tooltip = true;
        };

        "custom/settings" = {
          format = " ";
          on-click = "swaync-client -t -sw";
          tooltip-format = "Configurações";
          tooltip = true;
        };

        "custom/lock" = {
          format = "󰌾 ";
          on-click = "hyprlock";
          tooltip-format = "Bloquear sessão";
          tooltip = true;
        };

        "custom/power" = {
          format = " ";
          on-click = "wlogout --buttons-per-row 3 --css ~/.config/wlogout/style.css --layout ~/.config/wlogout/layout";
          tooltip-format = "Menu de energia";
          tooltip = true;
        };
      };
    };
  };
}
