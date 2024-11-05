{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./waybar.nix
    ./rofi.nix
  ];
  config = {
    environment.systemPackages = [
      pkgs.swaybg
    ];
    home-manager.users.${config.user} = {
      wayland.windowManager.sway = {
        enable = true;
        xwayland = true;
        config = {
          ## Keyboard
          input = {
            "*" = {
              xkb_layout = config.keyboard.layout;
            };
          };

          workspaceAutoBackAndForth = true;

          modifier = "Mod4";
          keybindings = let
            m = "Mod4";
          in
            lib.mkOptionDefault {
              "${m}+Return" = "exec ${config.terminal}";
              "${m}+c" = "exec code";
              "${m}+w" = "exec firefox";
              "${m}+space" = "exec rofi -show drun";

              # utilities
              "${m}+q" = "kill";
              "${m}+t" = "floating toggle";
            };

          menu = "rofi --show drun";
          bars = [];

          gaps = {
            smartBorders = "on";
            outer = 5;
            inner = 5;
          };

          startup = [{command = "waybar && dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY && swaybg --image ${config.wallpaper}";}];

          input = {
            "type:pointer" = {
              accel_profile = "flat";
              pointer_accel = "0";
            };
            "type:touchpad" = {
              middle_emulation = "enabled";
              natural_scroll = "enabled";
              tap = "enabled";
            };
          };
        };
      };
    };
  };
}
