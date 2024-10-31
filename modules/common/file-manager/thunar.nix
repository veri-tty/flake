{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../file-manager
  ];

  config = {
    os.file-manager = "thunar";

    ## Enabling thunar related services
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

    ## Installing thunar with some plugins
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
