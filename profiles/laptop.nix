{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ## Laptop
    machine = {
      isLaptop = lib.mkOption {
        type = lib.types.bool;
        description = "Whether the machine is a laptop";
        default = false;
      };
    };
  };
  config = lib.mkIf config.machine.isLaptop {
    ## Enabling brightnessctl
    environment.systemPackages = [pkgs.brightnessctl];

    ## Binding media keys
    home-manager.users.${config.user} = {
      wayland.windowManager.sway = {
        ## Keybindings
        extraConfig = ''
          bindsym --locked XF86MonBrightnessUp exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+
          bindsym --locked XF86MonBrightnessDown exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-
        '';
      };
    };
    ## Enabling bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    ## Enabling tray icon
    home-manager.users.${config.user} = {
      services.blueman-applet.enable = true;
    };
  };
}
