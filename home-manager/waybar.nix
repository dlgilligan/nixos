{
  ...
}:
let
  ## JSON CONFIG BLOCKS
  baseConfig = {
    layer = "top";
    height = 16;
    style = "~/.config/waybar/style.css";
    "modules-left" = [
      "custom/logo"
      "ext/workspaces"
    ];
    "modules-center" = ["wlr/taskbar"];
    "modules-right" = [
      "pulseaudio"
      "bluetooth"
      "network"
      "temperature"
      "cpu"
      "memory"
      "battery"
      "clock"
    ];
  };

  logoConfig = {
    "custom/logo" = {
      format = ""; # f313
    };
  };

  workspacesConfig = {
    "ext/workspaces" = {
      format = "{name}";
      sort-by-number = true;
      on-click = "activate";
    };
  };

  taskbarConfig = {
    "wlr/taskbar" = {
      format = "{icon} {title}";
      max-length = 30;
    };
  };

  pulseaudioConfig = {
    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = " muted"; # f6a9
      format-icons = {
        headphone = "󱡒"; # f1852
	hands-free = "󱡒"; # f1852
	headset = "󱡒"; # f1852
	phone = ""; # f095
	portable = ""; # f095
	car = ""; # f1b9
	default = ["" "" ""]; #f026 - f028
      };
      on-click = "pavucontrol";
    };
  };
  
  bluetoothConfig = {
    "bluetooth" = {
      format = " {status}"; # f294
      format-disabled = ""; # f294
      format-connected = " {num_connections}"; # f293
      tooltip-format = "{controller_alias}\t{controller_address}";
      tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
      tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
    };
  };

  networkConfig = {
    "network" = {
      format = "{ifname}";
      format-wifi = " {essid} ({signalStrength}%)"; # f1eb
      format-ethernet = "󰈀 {ipaddr}/{cidr}"; # f0200
      format-disconnected = "󰤯"; # f092f
      tooltip-format = "{ifname} via {gwaddr}"; # f6ff
      tooltip-format-wifi = " {essid} ({signalStrength}%)"; # f1eb
      tooltip-format-ethernet = "󰈀 {ifname}"; # f0200
      tooltip-format-disconnected = "Disconnected";
      max-length = 50;
    };
  };

  temperatureConfig = {
    "temperature" = {
      format = " {temperatureC}°C"; # ef2b
    };
  };

  cpuConfig = {
    "cpu" = {
      format = " {usage}%"; # f4bc
      tooltip = true;
      interval = 1;
    };
  };

  memoryConfig = {
    "memory" = {
      format = " {used:0.2f}G"; # efc5
    };
  };

  batteryConfig = {
    "battery" = {
      interval = 1;
      states = {
        warning = 30;
	critical = 15;
      };
      max-length = 20;
      format = "{icon}{capacity}%";
      format-warning = "{icon}{capacity}%";
      format-critical = "{icon}{capacity}%";
      format-charging = "<span foreground='#26ff55'> {capacity}%</span>"; # f1e6
      format-plugged = "<span foreground='#26ff55'> {capacity}%</span>"; # f1e6
      format-alt = "{icon} {time}";
      format-full = "<span foreground='#26ff55'> {capacity}%</span>"; # f240
      format-icons = [ "" "" "" "" "" ]; # f244 - f240
    };
  };

  clockConfig = {
    "clock" = {
      format = "<span color='#6bfffd'> </span>{:%I:%M %p}"; # f017
      format-alt = "<span color='#ff9854'> </span>{:%a %b %d}"; # f017
      tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
    };
  };

  waybarConfig =
    baseConfig
    // logoConfig
    // workspacesConfig
    // taskbarConfig
    // pulseaudioConfig
    // bluetoothConfig
    // networkConfig
    // temperatureConfig
    // cpuConfig
    // memoryConfig
    // batteryConfig
    // clockConfig;

  ## STYLE CSS BLOCKS
  baseStyle = ''
    * {
      min-height: 0;
      font-family: "Unifont", "Symbols Nerd Font Mono";
      font-size: 11px;
      font-weight: 900;
    }

    #window {
      color: #ffffff;
    }

    window#waybar {
      transition-property: background-color;
      transition-duration: 0.5s;
      background-color: rgba(0, 0, 0, 0.3);
    }

    window#waybar.hidden {
      opacity: 0.5;
    }

    window#waybar.empty #window {
      background-color: transparent;
    }
  '';

  workspacesStyle = ''
    #workspaces {
      background: #1e1e1e;
      margin: 5px 5px;
      padding: 0px 0px;
      border-radius: 15px;
      border: 0px;
      font-style: normal;
      opacity: 0.8;
      font-size: 16px;
      color: #ffffff;
    }
    
    #workspaces button {
      padding: 1px 1px;
      margin: 3px 3px;
      border-radius: 15px;
      border: 0px;
      color: #ffffff;
      background-color: rgba(0, 0, 0, 0.2);
      transition: all 0.2s ease-in-out;
      opacity: 1;
    }
    
    #workspaces button:hover {
      color: #1e1e1e;
    }
    
    #workspaces button.active {
      color: #000;
      background: #ffffff;
      border-radius: 15px;
      min-width: 40px;
      transition: all 0.2s ease-in-out;
      opacity: 1;
    }
    
    #workspaces button.urgent {
      background-color: #ff441f;
    }
  '';

  taskbarStyle = ''
    #taskbar {
      background: #1e1e1e;
      margin: 5px 5px;
      padding: 0px 2px;
      border-radius: 15px;
      opacity: 0.8;
    }

    #taskbar button {
      padding: 1px 8px;
      margin: 3px 3px;
      border-radius: 15px;
      border: 8px;
      color: #ffffff;
      background-color: rgba(0, 0, 0, 0.2);
      transition: all 0.2s ease-in-out;
      opacity: 0.7;
    }

    #taskbar button.active {
      color: #000000;
      background: #ffffff;
      opacity: 1;
    }

    #taskbar button:hover {
      color: #1e1e1e;
      background: rgba(255, 255, 255, 0.05);
      opacity: 1;
    }
    
    #taskbar button.minimized {
      opacity: 0.5;
      font-style: italic;
    }
    
    window#waybar.empty #taskbar {
      background-color: transparent;
    }
  '';

  restStyles = ''
    #clock,
    #pulseaudio,
    #battery,
    #cpu,
    #tray,
    #memory,
    #temperature,
    #network,
    #bluetooth {
      padding: 0px 8px;
      margin: 6px 3px;
      color: #ffffff;
      border-radius: 20px;
      background-color: #1e1e1e;
    }
    
    #custom-logo {
      color: #ffffff;
      padding: 0px 10px;
      font-size: 25px;
    }
    
    #tray {
      font-size: 10px;
    }
    
    #custom-sep {
      padding: 0px;
      color: #585b70;
    }
    
    #cpu {
      color: #94e2d5;
    }
    
    #memory {
      color: #cba6f7;
    }
    
    #clock {
      color: #ffffff;
    }
    
    #clock.date {
      color: #ffffff;
    }
    
    #pulseaudio {
      color: #ffffff;
    }
    
    #pulseaudio.muted {
      color: #ff5b45;
    }
    
    #temperature.critical {
      color: #ff5b45;
    }
    
    tooltip {
      border-radius: 8px;
      background-color: #1e1e1e;
      color: #ffffff;
      padding: 10px;
      border: 1px solid #333333;
    }
  '';

  styleCss =
    baseStyle
    + taskbarStyle
    + workspacesStyle
    + restStyles;

in
{
  home.file = {
    ".config/waybar/config.jsonc".text = builtins.toJSON waybarConfig;
    ".config/waybar/style.css".text = styleCss;
  };
}
