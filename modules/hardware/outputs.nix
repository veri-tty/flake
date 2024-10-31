{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    os = {
      output = {
        primary = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "Primary output of the machine";
            default = "eDP-1";
          };
          width = lib.mkOption {
            type = lib.types.int;
            description = "Width of the primary output";
            default = 2560;
          };
          height = lib.mkOption {
            type = lib.types.int;
            description = "Height of the primary output";
            default = 1440;
          };
          hidpi = lib.mkOption {
            type = lib.types.bool;
            description = "Whether the primary output is a HiDPI display";
          };
        };

        configs = lib.mkOption {
          type = lib.types.listOf lib.types.attrs;
          description = "List of output configurations available for the current machine";
        };
      };
    };
  };

  config = {
    home-manager.users.${config.user} = {
      home = lib.mkIf (config.os.wayland == true) {
        packages = with pkgs; [
          wdisplays # GUI
        ];
      };

      ## Configure wdisplays windows to be floating
      wayland.windowManager.sway = lib.mkIf (config.os.wm == "sway") {
        extraConfig = let
          clamshell = pkgs.writeShellScriptBin "clamshell" ''
            if grep -q open /proc/acpi/button/lid/LID1/state; then
                swaymsg output ${config.os.output.primary.name} enable
                ${pkgs.libnotify}/bin/notify-send -t 5000 "Enabled primary output"
            else
                swaymsg output ${config.os.output.primary.name} disable
                ${pkgs.libnotify}/bin/notify-send -t 5000 "Disabled primary output"
            fi
          '';
        in ''
          bindswitch --reload --locked lid:on output ${config.os.output.primary.name} disable
          bindswitch --reload --locked lid:off output ${config.os.output.primary.name} enable
        '';
        config.window.commands = [
          {
            command = "floating enable, border pixel 0";
            criteria = {
              app_id = "wdisplays";
            };
          }
        ];
      };
    };
  };
}
