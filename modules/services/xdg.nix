{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    ## Setting up portals
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      configPackages = [pkgs.xdg-desktop-portal-gtk];
    };

    ## Needed so that the user dirs get exported as env vars
    environment.systemPackages = [pkgs.xdg-user-dirs];

    ## Enabling XDG
    home-manager.users.${config.user} = {
      xdg.enable = true;

      ## Setting custom cacheHome
      xdg.cacheHome = "${config.home-manager.users.${config.user}.home.homeDirectory}/.local/cache";

      ## Enable XDG mime type handling
      xdg.mime.enable = true;
      xdg.mimeApps.enable = true;

      ## Enable XDG user directories
      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        documents = "${config.home-manager.users.${config.user}.home.homeDirectory}/docs";
        download = "${config.home-manager.users.${config.user}.home.homeDirectory}/dl";
        pictures = "${config.home-manager.users.${config.user}.home.homeDirectory}/pics";

        ## Unused directories
        desktop = null;
        music = null;
        publicShare = null;
        templates = null;
        videos = null;
      };
    };
  };
}