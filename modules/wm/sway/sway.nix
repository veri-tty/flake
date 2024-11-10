{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./waybar.nix
    ./rofi.nix
    ./cursor.nix
    ./theme.nix
  ];
  config = lib.mkIf config.sway.enable {
    environment.systemPackages = [
      pkgs.swaybg
    ];
    wayland.enable = true;
    home-manager.users.${config.user} = {
      wayland.windowManager.sway = {
        enable = true;
        xwayland = true;
        systemd.enable = true;
        wrapperFeatures = {
          base = true;
          gtk = true;
        };
        extraSessionCommands = ''
          export SDL_VIDEODRIVER=wayland
          export QT_QPA_PLATFORM=wayland
          export QT_WAYLAND_DISABLE_WINDOWDECORATIONS=1
          export _JAVA_AWT_WM_NOPARENTING=1
        '';
        config = {
          defaultWorkspace = "workspace number 1";
          ## Keyboard
          input = {
            "*" = {
              xkb_layout = config.keyboard.layout;
            };
          };
	  output = {
	    DP-1 = {
	      mode = "2560x1440@143.998Hz";   
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
          floating.border = 2;
          window.border = 0;
          window.titlebar = false;
          floating.titlebar = false;
          gaps.inner = 8;
          gaps.outer = 2;

          startup = [{command = "waybar & dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY & swaybg --image ${config.wallpaper}";}];

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
