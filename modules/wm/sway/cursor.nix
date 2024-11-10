{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.${config.user} = {
    ## Enabling bigger cursor
    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 14;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };
  };
}
