{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    ## Extra libraries and packges
    environment = {
      systemPackages = with pkgs; [
        (lutris.override {
          extraLibraries = pkgs: [
            # List library dependencies here
          ];
          extraPkgs = pkgs: [
            # List package dependencies here
          ];
        })
      ];
    };

    home-manager.users.${config.user}.home.packages = with pkgs; [
      lutris
    ];
  };
}
