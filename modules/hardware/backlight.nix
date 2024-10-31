{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.os.machine.isLaptop {

    ## Enabling brightnessctl
    environment.systemPackages = [ pkgs.brightnessctl ];

    ## Binding media keys
    home-manager.users.${config.user} = {
      wayland.windowManager.sway = {
          ## Keybindings
          extraConfig = ''
            bindsym --locked XF86MonBrightnessUp exec ${pkgs.brightnessctl}/bin/brightnessctl set +10%
            bindsym --locked XF86MonBrightnessDown exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-
          '';
      };
    };
  };
}

