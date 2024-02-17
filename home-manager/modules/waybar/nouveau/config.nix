_: {
  mainBar = {
    layer = "top"; # Waybar at top layer
    margin-top = 6;
    margin-bottom = 2;
    margin-right = 8;
    margin-left = 8;
    modules-left = [ "custom/launcher" "custom/media" "hyprland/workspaces" "hyprland/window" ];
    modules-center = [ ];
    /*
          "mpd#2"
      "mpd#3"
      "mpd#4"
      "mpd"
      */
#    modules-center = [ "mpd" "mpd#2" "mpd" "mpd#2" "mpd#3" "mpd#4" "custom/mpd" ];
    modules-right = [
      "tray"
      "battery"
      "cpu"
      "temperature"
      "memory"
      "backlight"
      "idle_inhibitor"
      "pulseaudio"
      "clock"
      "network"
      "custom/powermenu"
    ];

    "hyprland/workspaces" = {
/*      "persistent-workspaces" = {
        "1" = [ "DP-3" ];
        "2" = [ "DP-3" ];
        "3" = [ "DP-3" ];
        "4" = [ "DP-3" ];
      };*/
      active-only = "false";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      disable-scroll = "false";
      all-outputs = "true";
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = " ";
        "2" = "";
        "3" = " ";
        "4" = " ";
        "5" = "󰊴 ";
        "6" = " ";
        "7" = " ";
        "8" = " ";
        "9" = " ";
        "14" = " ";
      };
    };

    "custom/media" = {
      "format" = " {}";
      "max-lenght" = "40";
      "interval" = "1";
      "exec" = "playerctl metadata --format '{{ artist }} - {{ title }}'";
      "on-click" = "playerctl play-pause";
      "on-click-right" = "playerctl stop";
      "smooth-scrolling-threshold" = "4";
      "on-scroll-up" = "playerctl next";
      "on-scroll-down" = "playerctl previous";
    };

    "idle_inhibitor" = {
      format = "{icon}";
      format-icons = {
        activated = " ";
        deactivated = " ";
      };
    };

    "tray" = {
      spacing = "10";
    };

    "clock" = {
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format = " {:%H:%M}";
      format-alt = "󰃰 {:%A, %B %d, %Y}";
    };

    "cpu" = {
      format = " {usage}%";
      tooltip = "false";
    };

    "memory" = {
      format = " {}%";
      on-click = "foot -e btop";
    };

    "backlight" = {
      format = "{icon}{percent}%";
      format-icons = [ "󰃞 " "󰃟 " "󰃠 " ];
      on-scroll-up = "light -A 1";
      on-scroll-down = "light -U 1";
    };

    "battery" = {
      states = {
        warning = "30";
        critical = "15";
      };
      format = "{icon}{capacity}%";
      tooltip-format = "{timeTo} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-plugged = " ";
      format-alt = "{time} {icon}";
      format-icons = [ "  " "  " "  " "  " "  " ];
    };

    "temperature" = {
      hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
      critical-threshold = 80;
      format = " {temperatureC}°C";
    };

    "network" = {
      format = "⚠ Disabled";
      format-wifi = "󰖩 {essid} {signalStrength}%";
      # format-ethernet = "{ifname}: {ipaddr}/{cidr} 󰈀 ";
      format-ethernet = " {cidr}";
      format-linked = "{ifname} (No IP) 󰈀 ";
      format-disconnected = "󰖪  Disconnected";
      # on-click = "$HOME/.config/hypr/Scripts/wifi-menu";
      on-click = "foot -e nmtui";
      tooltip-format = "{ifname} via {gwaddr}";
    };

    "pulseaudio" = {
      format = "{icon}{volume}%";
      format-bluetooth = "{icon} {volume}%";
      format-bluetooth-muted = "   {volume}%";
      format-muted = "  {format_source}";
      format-icons = {
        headphone = " ";
        hands-free = "󰂑 ";
        headset = "󰂑 ";
        phone = " ";
        portable = " ";
        car = " ";
        default = [ " " " " " " ];
      };
      tooltip-format = "{desc} {volume}%";
      on-click = "pavucontrol";
      on-scroll-up = "pamixer -ui 2 && pamixer --get-volume > $hyprlandSOCK.wob";
      on-scroll-down = "pamixer -ud 2 && pamixer --get-volume > $hyprlandSOCK.wob";
    };

    "custom/wmname" = {
      format = " ";
      tooltip = "false";
      on-click = "$HOME/.config/rofi/launchers/type-1/launcher.sh";
      on-click-right = "$HOME/.config/hypr/Scripts/screenshot";
      on-click-middle = "$HOME/.config/hypr/Scripts/wallpaper-switch";
    };
    
    "custom/launcher" = {
      format = " ";
      on-click = "exec nwg-drawer -c 7 -is 70 -spacing 23";
      tooltip = false;
    };

    "custom/powermenu" = {
      format = " ";
      on-click = "nwgbar";
      tooltip = false;
    };

/* TODO: unfuck mpd */ 
    "mpd" = {
      tooltip = true;
      tooltip-format = "{artist} - {album} - {title} - Total Time : {totalTime:%M:%S}";
      format = " {elapsedTime:%M:%S}";
      format-disconnected = "⚠ Disconnected";
      format-stopped = " Not Playing";
      on-click = "mpc toggle";
      state-icons = {
        playing = "";
        paused = "";
      };
    };
    "mpd#2" = {
      format = "";
      format-disconnected = "";
      format-paused = "";
      format-stopped = "";
      on-click = "mpc -q pause && mpc -q prev && mpc -q start";
    };
    "mpd#3" = {
      interval = 1;
      format = "{stateIcon}";
      format-disconnected = "";
      format-paused = "{stateIcon}";
      format-stopped = "";
      state-icons = {
        paused = "";
        playing = "";
      };
    };
    "mpd#4" = {
      format = "";
      format-disconnected = "";
      format-paused = "";
      format-stopped = "";
      on-click = "mpc -q pause && mpc -q next && mpc -q start";
    };
    "custom/mpd" = {
      format = " {title} - {artist}";
      interval = 5;
      exec = "mpc current --format='\"title\":\"%title%\",\"artist\":\"%artist%\"'";
    };

  };
}
