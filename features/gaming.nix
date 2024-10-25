{ config, lib, pkgs, ... }:

{
  imports = [
    ## Reverse import the wrapper feature so that the options are defined.
    ../features

    ../modules/games/steam.nix
    ../modules/games/lutris.nix
  ];

  config = {

    ## Mounting games SSD
    ## needs `sudo chown db:users -R /mnt/games'
    fileSystems."/mnt/games" = {
      device = "/dev/disk/by-label/GAMES";
      fsType = "btrfs";
    };

    ## Setting the appropriate option so other modules know it.
    features.gaming = true;

    home-manager.users.${config.user}.home.packages = with pkgs; [
      mangohud
    ];
  };
}