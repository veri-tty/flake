{
  config,
  lib,
  pkgs,
  ...
}: {
  ## DHCP needs to be enable on a per-interface basis.
  ## This is part of the machine-specific configuration.
  networking.useDHCP = false;

  ## Enable network manager
  networking.networkmanager.enable = true;

  ## Enabling appropriate groups
  users.users.${config.user} = {
    extraGroups = ["networkmanager"];
  };

  ## Configuring nm app windows to be floating
  home-manager.users.${config.user} = {
    home.packages = [pkgs.networkmanagerapplet];
    wayland.windowManager.sway = lib.mkIf (config.os.wm == "sway") {
      config.window = {
        commands = [
          {
            command = "floating enable, border pixel 2";
            criteria = {
              app_id = "nm-.*";
            };
          }
        ];
      };

      ## Enabling nm-applet via config.programs.nm-applet will not show icon
      ## Need to do it through sway
      extraConfig = ''
        exec nm-applet --indicator
      '';
    };
  };
}
