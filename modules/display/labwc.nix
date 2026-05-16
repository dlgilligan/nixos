{
  lib,
  config,
  pkgs,
  ...
}: {
  options.labwc.enable = lib.mkEnableOption "Enable labwc";

  config = lib.mkIf config.labwc.enable {
    users.users.daniel = {
      packages = with pkgs; [
        xwayland
        labwc
        wlrctl
        waybar
        swaybg
        rofi
        gtklock
      ];
    };

    programs.xwayland.enable = true;
    programs.labwc.enable = true;
    hardware.graphics.enable = true;

    security.pam.services.gtklock = {};
    programs.gtklock = {
      enable = true;
      config = {
        main = {
          time-format = "%H:%M";
          date-format = "%A, %B %e";
        };
      };

      style = ''
        * {
          font-family: "Unifont";
          font-size: 12pt;
        }

        window {
          background-color: #181818;
        }

        box#body {
          background-color: rgba(30, 30, 30, 0.95);
          border-radius: 8px;
          padding: 32px;
        }

        /* Password entry */
        label#input-label {
          color: #888888;
        }

        entry {
          background-color: #1e1e1e;
          color: #ffffff;
          border-color: #3a3a3a;
          caret-color: #ffffff;
        }

        entry:hover {
          border-color: #555555;
        }

        entry:focus {
          border-color: #777777;
        }

        /* Buttons */
        button {
          background-color: #1e1e1e;
          color: #ffffff;
          border-color: #3a3a3a;
        }

        button:hover {
          background-color: #2e2e2e;
          border-color: #555555;
        }

        button:active {
          background-color: #383838;
          border-color: #555555;
        }

        button:focus {
          background-color: #2e2e2e;
          border-color: #555555;
        }

        /* Clock/date labels */
        label#clock-label {
          color: #888888;
          font-size: 48pt;
        }

        label#date-label {
          color: #888888;
        }
      '';
    };

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "labwc";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "labwc";
    };

    environment.systemPackages = [ (pkgs.callPackage ./sddm-monochrome.nix {}) pkgs.unifont ];

    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "monochrome";
        package = pkgs.kdePackages.sddm;
        settings = {
          X11 = {
            KeyboardLayout = "us";
          };
        };
      };
    };
  };
}
