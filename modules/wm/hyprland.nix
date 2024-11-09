{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    #./hyprland-environment.nix
    ./waybar.nix
    ./rofi.nix
    ./cursor.nix
    ./theme.nix
  ];
  config = lib.mkIf config.hyprland.enable {
    environment.systemPackages = with pkgs; [
      #waybar
      #swaybg
    ];
    wayland.enable = true;
    home-manager.users.${config.user} = {
      home = {
        sessionVariables = {
          EDITOR = "
          vim";
          BROWSER = "firefox";
          TERMINAL = "kitty";
          GBM_BACKEND = "nvidia-drm";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          LIBVA_DRIVER_NAME = "nvidia"; # hardware acceleration
          __GL_VRR_ALLOWED = "1";
          WLR_NO_HARDWARE_CURSORS = "1";
          WLR_RENDERER_ALLOW_SOFTWARE = "1";
          CLUTTER_BACKEND = "wayland";
          #WLR_RENDERER = "vulkan";
          XDG_CURRENT_DESKTOP = "Hyprland";
          XDG_SESSION_DESKTOP = "Hyprland";
          XDG_SESSION_TYPE = "wayland";
        };
      };
      #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        extraConfig = ''

          # Monitor
          monitor = DP-1, 2560x1440@144, 0x0, 1.6

          # Autostart
          #exec-once = waybar & swaybg --image ${config.wallpaper}


          # Input config
          input {
              kb_layout = de
              kb_variant =
              kb_model =
              kb_options =
              kb_rules =

              follow_mouse = 1

              touchpad {
                  natural_scroll = true
              }

              sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
          }

          general {

              gaps_in = 5
              gaps_out = 20
              border_size = 2
              layout = dwindle
          }

          decoration {

              rounding = 0
              drop_shadow = true
              shadow_range = 4
              shadow_render_power = 3
              col.shadow = rgba(1a1a1aee)
          }

          animations {
              enabled = no
          }

          dwindle {
              pseudotile = yes
              preserve_split = yes
          }

          gestures {
              workspace_swipe = false
          }


          $mainMod = SUPER
          bind = $mainMod, G, fullscreen,


          #bind = $mainMod, RETURN, exec, cool-retro-term-zsh
          bind = $mainMod, Return, exec, kitty
          bind = $mainMod, B, exec, opera --no-sandbox
          bind = $mainMod, W, exec, firefox
          bind = $mainMod, Q, killactive,
          bind = $mainMod, M, exit,
          bind = $mainMod, C, exec, code
          bind = $mainMod, F, exec, nautilus
          bind = $mainMod, V, togglefloating,
          bind = $mainMod, w, exec, wofi --show drun
          bind = $mainMod, R, exec, rofiWindow
          bind = $mainMod, P, pseudo, # dwindle
          bind = $mainMod, J, togglesplit, # dwindle


          bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
          bind = SHIFT, Print, exec, grim -g "$(slurp)"

          # Functional keybinds
          bind =,XF86AudioMicMute,exec,pamixer --default-source -t
          bind =,XF86MonBrightnessDown,exec,light -U 20
          bind =,XF86MonBrightnessUp,exec,light -A 20
          bind =,XF86AudioMute,exec,pamixer -t
          bind =,XF86AudioLowerVolume,exec,pamixer -d 10
          bind =,XF86AudioRaiseVolume,exec,pamixer -i 10
          bind =,XF86AudioPlay,exec,playerctl play-pause
          bind =,XF86AudioPause,exec,playerctl play-pause

          # to switch between windows in a floating workspace
          bind = SUPER,Tab,cyclenext,
          bind = SUPER,Tab,bringactivetotop,

          # Move focus with mainMod + arrow keys
          bind = $mainMod, left, movefocus, h
          bind = $mainMod, right, movefocus, j
          bind = $mainMod, up, movefocus, k
          bind = $mainMod, down, movefocus, l

          # Switch workspaces with mainMod + [0-9]
          bind = $mainMod, 1, workspace, 1
          bind = $mainMod, 2, workspace, 2
          bind = $mainMod, 3, workspace, 3
          bind = $mainMod, 4, workspace, 4
          bind = $mainMod, 5, workspace, 5
          bind = $mainMod, 6, workspace, 6
          bind = $mainMod, 7, workspace, 7
          bind = $mainMod, 8, workspace, 8
          bind = $mainMod, 9, workspace, 9
          bind = $mainMod, 0, workspace, 10

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          bind = $mainMod SHIFT, 1, movetoworkspace, 1
          bind = $mainMod SHIFT, 2, movetoworkspace, 2
          bind = $mainMod SHIFT, 3, movetoworkspace, 3
          bind = $mainMod SHIFT, 4, movetoworkspace, 4
          bind = $mainMod SHIFT, 5, movetoworkspace, 5
          bind = $mainMod SHIFT, 6, movetoworkspace, 6
          bind = $mainMod SHIFT, 7, movetoworkspace, 7
          bind = $mainMod SHIFT, 8, movetoworkspace, 8
          bind = $mainMod SHIFT, 9, movetoworkspace, 9
          bind = $mainMod SHIFT, 0, movetoworkspace, 10

          # Scroll through existing workspaces with mainMod + scroll
          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1
        '';
      };
    };
  };
}
