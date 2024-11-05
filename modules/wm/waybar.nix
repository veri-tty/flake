{
  config,
  pkgs,
  ...
}: {
  home-manager.users.${config.user} = {
    programs.waybar.enable = true;

    programs.waybar.settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 26;
        output = [
          "eDP-1"
        ];

        modules-left = ["sway/workspaces" "sway/mode"];
        modules-right = ["clock" "battery"];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
          };
          disable-click = true;
        };

        "sway/mode" = {
          tooltip = false;
        };

        "clock" = {
          interval = 60;
          format = "{:%a %d/%m %I:%M}";
        };

        "battery" = {
          tooltip = false;
        };
      };
    };

    programs.waybar.style = ''

      * {
        border: none;
        border-radius: 0;
        padding: 0;
        margin: 0;
        font-size: 11px;
      }

      window#waybar {
        background: #29273a;
        color: #ffffff;
      }

      #custom-logo {
        font-size: 18px;
        margin: 0;
        margin-left: 7px;
        margin-right: 12px;
        padding: 0;
        font-family: NotoSans Nerd Font Mono;
      }

      #workspaces button {
        margin-right: 10px;
        color: #ffffff;
      }
      #workspaces button:hover, #workspaces button:active {
        background-color: #1e2030;
        color: #ffffff;
      }
      #workspaces button.focused {
        background-color: #ed8796;
      }


      #battery {
        margin-left: 7px;
        margin-right: 3px;
      }
    '';
  };
}
