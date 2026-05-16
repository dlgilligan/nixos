{
  config,
  ...
}: 
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    font = "Unifont 11";
    modes = [ "drun" "ssh" ];
    terminal = "alacritty";

    extraConfig = {
      kb-element-next = "";
      kb-row-down = "Down";
      kb-row-up = "Up";
      kb-mode-next = "Tab";
      kb-mode-previous = "shift+Tab";
      show-icons = true;
      drun-display-format = "{name}";
      hide-scrollbar = true;
      matching = "fuzzy";
      sort = true;
      window-format = "{w}  {c}  {t}";
      click-to-exit = true;
      fixed-num-lines = true;
      show-match = true;
    };

    theme = {
      "*" = {
          background-color = mkLiteral "#181818";
          border-color = mkLiteral "#ffffff";
          text-color = mkLiteral "#ffffff";
          spacing = 2;
          width = 600;
          font = "Unifont 11";
      };
      
      "window" = {
          background-color = mkLiteral "#181818";
          border = 2;
          border-color = mkLiteral "#ffffff";
          border-radius = 15;
          padding = 8;
      };
      
      "mainbox" = {
          border = 0;
          padding = 0;
          background-color = mkLiteral "transparent";
      };
      
      "message" = {
          border = 0;
          border-color = mkLiteral "#ffffff";
          padding = 8;
          background-color = mkLiteral "transparent";
      };
      
      "textbox" = {
          text-color = mkLiteral "#ffffff";
          background-color = mkLiteral "transparent";
      };
      
      "listview" = {
          fixed-height = 0;
          border = 0;
          border-color = mkLiteral "#ffffff";
          spacing = 4;
          scrollbar = false;
          padding = 8;
          lines = 12;
          background-color = mkLiteral "transparent";
      };
      
      "element" = {
          border = 0;
          padding = 8;
          border-radius = 15;
          background-color = mkLiteral "rgba(0, 0, 0, 0.2)";
          margin = 2;
      };
      
      "element normal.normal" = {
          background-color = mkLiteral "rgba(0, 0, 0, 0.2)";
          text-color = mkLiteral "#ffffff";
      };
      
      "element selected.normal" = {
          background-color = mkLiteral "#ffffff";
          text-color = mkLiteral "#000000";
          border-color = mkLiteral "#ffffff";
          border = 0;
      };
      
      "element-text" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          padding = 0;
      };
      
      "element-icon" = {
          background-color = mkLiteral "transparent";
          size = 20;
          padding = mkLiteral "0 8 0 0";
      };
      
      "inputbar" = {
          spacing = 0;
          text-color = mkLiteral "#ffffff";
          padding = 12;
          background-color = mkLiteral "#1e1e1e";
          border = mkLiteral "0 0 0 0";
          border-color = mkLiteral "#ffffff";
          border-radius = 15;
          margin = mkLiteral "0 0 8 0";
          children = map mkLiteral [ "prompt" "textbox-prompt-colon" "entry" ];
      };
      
      "prompt" = {
          spacing = 0;
          text-color = mkLiteral "#ffffff";
          padding = mkLiteral "0 8 0 8";
          background-color = mkLiteral "transparent";
      };
      
      "textbox-prompt-colon" = {
          expand = false;
          str = ":";
          margin = 0;
          width = mkLiteral "1ch";
          text-color = mkLiteral "#ffffff";
          background-color = mkLiteral "transparent";
      };
      
      "entry" = {
          spacing = 0;
          text-color = mkLiteral "#ffffff";
          expand = true;
          horizontal-align = 0;
          cursor = mkLiteral "text";
          background-color = mkLiteral "transparent";
      };
    };
  };
}
