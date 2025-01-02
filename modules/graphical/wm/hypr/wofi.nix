{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hyprpaper.nix
  ];
  config = lib.mkIf config.wm.hyprland.enable {
    environment.systemPackages = with pkgs; [
      wofi
    ];
    home-manager.users.${config.user} = {
      programs.wofi.enable = true;
      programs.wofi.style = ''
        /**
         * Rofi Theme
         * Author: machaerus (https://gitlab.com/machaerus/dotfiles)
         */

        * {
           maincolor:        #b58900;
           highlight:        bold #d69f00;
           urgentcolor:      #859900;
           fgwhite:          #fdf6e3;
           blackdarkest:     #002b36;
           blackwidget:      #002b36;
           blackentry:       #002b36;
           blackselect:      #065069;
           darkgray:         #002b36;
           scrollbarcolor:   #eee8d5;
           font: "Roboto Mono 11";
           background-color: @blackdarkest;
           margin: 0px 0px 0px 0px;
           padding: 0px 0px 0px 0px;
           border: 0px 0px 0px 0px;
           spacing: 0px;
        }

        window {
           background-color: @blackdarkest;
           border: 3px;
           padding: 0px 0px 0px 0px;
           margin: 0px 0px 0px 0px;
           border-color: @maincolor;
           anchor: north;
           location: north;
           y-offset: 15%;
        }

        mainbox {
           background-color: @blackdarkest;
           spacing:0px;
           children: [inputbar, listview];
        }

        message {
           padding: 0px 0px;
           background-color:@blackwidget;
        }

        listview {
           fixed-height: false;
           dynamic: true;
           scrollbar: false;
           spacing: 0px;
           padding: 0px 0px 0px 0px;
           margin: 0px 0px 0px 0px;
           background: @blackdarkest;
        }

        element {
           padding: 5px 12px;
        }

        element normal.normal {
           padding: 0px 0px;
           background-color: @blackentry;
           text-color: @fgwhite;
        }

        element normal.urgent {
           background-color: @blackentry;
           text-color: @urgentcolor;
        }

        element normal.active {
           background-color: @blackentry;
           text-color: @maincolor;
        }

        element selected.normal {
            background-color: @blackselect;
            text-color:       @fgwhite;
        }

        element selected.urgent {
            background-color: @urgentcolor;
            text-color:       @blackdarkest;
        }

        element selected.active {
            background-color: @maincolor;
            text-color:       @blackdarkest;
        }

        element alternate.normal {
            background-color: @blackentry;
            text-color:       @fgwhite;
        }

        element alternate.urgent {
            background-color: @blackentry;
            text-color:       @urgentcolor;
        }

        element alternate.active {
            background-color: @blackentry;
            text-color:       @maincolor;
        }

        scrollbar {
           background-color: @blackwidget;
           handle-color: @darkgray;
           handle-width: 15px;
        }

        mode-switcher {
           background-color: @blackwidget;
        }

        button {
           background-color: @blackwidget;
           text-color:       @darkgray;
        }

        button selected {
            text-color:       @maincolor;
        }

        inputbar {
           children: [ textbox-prompt-colon, entry ];
           background-color: @blackdarkest;
           spacing: 0px;
        }

        prompt {
           enabled: true;
           padding: 7px 12px 6px 7px;
           /* background-color: @maincolor;*/
           text-color: @maincolor;
        }

        textbox {
           text-color: @darkgray;
           background-color: @blackwidget;
        }

        textbox-prompt-colon {
           padding: 8px 4px 7px 10px;
           /* background-color: @maincolor;*/
           text-color: @maincolor;
           expand: false;
           str: "";
           font: "feather 14";
        }

        entry {
           padding: 7px 10px;
           background-color: @blackwidget;
           text-color: @fgwhite;
        }

        case-indicator {
           padding: 6px 10px;
           text-color: @maincolor;
           background-color: @blackwidget;
        }

      '';
    };
  };
}
