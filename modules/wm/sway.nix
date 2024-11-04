{
  config,
  lib,
  ...
}: {
  config = {
    home-manager.users.${config.user} = {
      wayland.windowManager.sway = {
        config = {
          assigns = {
            "1: web" = [{class = "^Firefox$";}];
            "9: steam" = [{class = "^Steam$";}];
          };

          workspaceAutoBackAndForth = true;

          modifier = "Mod4";
          keybindings = let
            m = "Mod4";
          in
            lib.mkOptionDefault {
              "${m}+Return" = "exec ${config.terminal}";
              "${m}+space" = "exec rofi --show drun";

              # utilities
              "${m}+q" = "kill";
              "${m}+t" = "floating toggle";

              # screenshots
              "Print" = "grim -g \"$(slurp)\" - | wl-copy -t image/png";
              "${m}+Shift+r" = "grim -g \"$(slurp)\" - | wl-copy -t image/png";
              "Alt+Print" = "grim - | wl-copy -t image/png";
              "${m}+Alt+Shift+r" = "grim - | wl-copy -t image/png";
            };

          keycodebindings = {
            "--locked --no-repeat 121" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; # mute
            "--locked 122" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%-"; # vol-
            "--locked 123" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%+"; # vol+
            "--locked 171" = "exec playerctl next"; # next song
            "--locked --no-repeat 172" = "exec playerctl play-pause"; # play/pause
            "--locked 173" = "exec playerctl previous"; # prev song
            "--locked --no-repeat 198" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; # mic mute
            "--locked 232" = "exec light -U 5"; # brightness-
            "--locked 233" = "exec light -A 5"; # brightness+
          };

          menu = "rofi";
          bars = ["waybar"];

          gaps = {
            smartBorders = "on";
            outer = 5;
            inner = 5;
          };

          startup = [{command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY && swaybg --image ${config.wallpaper}";}];

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
