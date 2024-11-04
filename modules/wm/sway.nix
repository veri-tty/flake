{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./cursor.nix
    ./theme.nix
    ./launcher/rofi.nix
    ./bar/waybar.nix
  ];

  config = {
    ## Setting appropriate options so other modules can use them.
    environment.systemPackages = [
      pkgs.swaybg
    ];

    ## Sway
    home-manager.users.${config.user} = {
      wayland.windowManager.sway = {
        enable = true;

        ## Enable XWayland
        xwayland = true;

        ## Properly expose env to DBus
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
          ## Set modifier
          modifier = "Mod4";

          ## use `--to-code' in keybindings
          bindkeysToCode = true;

          ## Keyboard
          input = {
            "*" = {
              xkb_layout = config.keyboard.layout;
              xkb_options = config.keyboard.options;
            };
          };

          ## Fonts
          fonts = {
            names = [config.os.fonts.mono.regular];
          };

          ## Terminal
          terminal = "kitty";

          ## Appearance
          floating.border = 2;
          window.border = 0;
          window.titlebar = false;
          floating.titlebar = false;
          gaps.inner = 8;
          gaps.outer = 2;

          ## Launcher
          menu = "${config.os.launcher.pkg}/bin/${config.os.launcher.name} ${config.os.launcher.args}";

          ## We'll start the bar through dbus
          bars = [
            {
              command = "waybar";
            }
          ];
          startup = [
            {
              command = "swaybg --image ${config.wallpaper}";
            }
          ];
          colors = let
            background = config.theme.colors.base00;
            inactiveBackground = config.theme.colors.base01;
            border = config.theme.colors.base01;
            inactiveBorder = config.theme.colors.base01;
            text = config.theme.colors.base07;
            inactiveText = config.theme.colors.base04;
            urgentBackground = config.theme.colors.base08;
            indicator = "#00000000";
          in {
            background = config.theme.colors.base00;
            focused = {
              inherit
                background
                indicator
                text
                border
                ;
              childBorder = background;
            };
            focusedInactive = {
              inherit indicator;
              background = inactiveBackground;
              border = inactiveBorder;
              childBorder = inactiveBackground;
              text = inactiveText;
            };
            # placeholder = { };
            unfocused = {
              inherit indicator;
              background = inactiveBackground;
              border = inactiveBorder;
              childBorder = inactiveBackground;
              text = inactiveText;
            };
            urgent = {
              inherit text indicator;
              background = urgentBackground;
              border = urgentBackground;
              childBorder = urgentBackground;
            };
          };
          ## Keybindings
          keybindings = let
            mod = config.home-manager.users.${config.user}.wayland.windowManager.sway.config.modifier;
            menu = config.home-manager.users.${config.user}.wayland.windowManager.sway.config.menu;
            passwordManager = config.os.passwordManager;
            screenshot = config.os.screenshot;
          in
            lib.mkOptionDefault {
              "${mod}+r" = "reload";
              "${mod}+c" = "exec code";
              "${mod}+w" = "exec firefox";
              "${mod}+q" = "kill";
              "${mod}+f" = "fullscreen";
              "${mod}+a" = "exec ${menu}";
              #"${mod}+Shift+p" = "exec ${passwordManager}";
              "Print" = "exec ${screenshot}/bin/screenshot";
            };
          assigns = {
            "1: terminal" = [{class = "^kitty$";}];
            "2: code" = [{class = "^code$";}];
            "3: web" = [{class = "^firefox$";}];
          };
        };
      };
    };
  };
}
