{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    ## Setting up Pipewire
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    home-manager.users.${config.user} = {
      ## Enabling PulseAudio system tray
      services.pasystray.enable = true;

      home.packages = [pkgs.pulseaudioFull];

      ## Configure pavu to be floating
      wayland.windowManager.sway = {
        config.window = {
          commands = lib.mkIf config.sway.enable [
            {
              command = "floating enable, border pixel 2";
              criteria = {
                app_id = "pavucontrol";
              };
            }
          ];
        };

        ## Making media keys work
        extraConfig = ''
          bindsym --locked XF86AudioRaiseVolume \
          exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-mute @DEFAULT_SINK@ false; \
          exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%
          bindsym --locked XF86AudioLowerVolume \
          exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-mute @DEFAULT_SINK@ false; \
          exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%
          bindsym --locked XF86AudioMute exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle
          bindsym --locked XF86AudioMicMute exec ${pkgs.pulseaudioFull}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle
        '';
      };
    };
  };
}
