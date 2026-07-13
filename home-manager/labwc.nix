{
  config,
  lib,
  pkgs,
  ...
}: {
  options.labwc.scale = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether or not to scale the screen";
  };

  config = {
    wayland.windowManager.labwc = {
      enable = true;

      autostart = [
        "swaybg -c '#181818' &amp;"
        "waybar >/dev/null 2>&1 &amp;"
      ] ++ lib.optionals config.labwc.scale [
        "wlr-randr --output eDP-1 --scale 1.75"
      ];

      rc = {
        theme = {
          font = {
            "@name" = "Unifont";
            "@size" = "12";
          };
        };
        keyboard = {
          default = true;
          keybind = [
            {
              "@key" = "W-d";
              action = {
                "@name" = "Execute";
                "@command" = "rofi -show drun";
              };
            }
            {
              "@key" = "W-Enter";
              action = {
                "@name" = "Execute";
                "@command" = "alacritty";
              };
            }
            {
              "@key" = "W-l";
              action = {
                "@name" = "Execute";
                "@command" = "gtklock";
              };
            }
            {
              "@key" = "W-1";
              action = {
                "@name" = "GoToDesktop";
                "@to" = "1";
              };
            }
            {
              "@key" = "W-2";
              action = {
                "@name" = "GoToDesktop";
                "@to" = "2";
              };
            }
            {
              "@key" = "W-3";
              action = {
                "@name" = "GoToDesktop";
                "@to" = "3";
              };
            }
            {
              "@key" = "W-4";
              action = {
                "@name" = "GoToDesktop";
                "@to" = "4";
              };
            }
          ];
        };
        desktops = {
          initial = "1";
          names = {
            name = [ "1" "2" "3" "4" ];
          };
        };
      };
    };

    services.swayidle = {
      enable = true;

      timeouts = [
        {
          timeout = 600;
          command = "${pkgs.gtklock}/bin/gtklock -d";
        }
        {
          timeout = 900;
          command = "${pkgs.wlopm}/bin/wlopm --off '*'";
          resumeCommand = "${pkgs.wlopm}/bin/wlopm --on '*'";
        }
        {
          timeout = 1800;
          command = "systemctl suspend";
        }
      ];

      events = {
        "before-sleep" = "${pkgs.gtklock}/bin/gtklock -d";
        "lock" = "${pkgs.gtklock}/bin/gtklock -d";
        "unlock" = "${pkgs.procps}/bin/pkill -USR1 gtklock";
      };
    };
  };
}
