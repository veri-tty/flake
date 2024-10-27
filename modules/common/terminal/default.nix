{ config, lib, pkgs, ... }:

{
  ## Setting the appropriate option so other modules know it
  options = {
    os = {
   terminal = lib.mkOption {
        type = lib.types.path;
        default = if config.os.wayland
          then "${pkgs.kitty}/bin/kitty"
          else "${pkgs.gnome.gnome-terminal}/bin/gnome-terminal";
      };
    };
  };

  # config = {
  #   home-manager.users.${config.user}.wayland.windowManager.sway.extraConfig = lib.mkIf (config.os.wm == "sway") ''
  #     workspace 2
  #     exec ${config.os.terminal}
  #   '';
  # };
}
