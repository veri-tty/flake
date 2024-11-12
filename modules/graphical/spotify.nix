{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    spotify = {
      enable = lib.mkEnableOption {
        description = "Spotify or not.";
        default = false;
      };
    };
  };
  config = lib.mkIf config.spotify.enable {
    environment.systemPackages = [
      pkgs.spotify
    ];
  };
}
