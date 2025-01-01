{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    qbit = {
      enable = lib.mkEnableOption {
        description = "Qbit or not.";
        default = false;
      };
    };
  };
  config = lib.mkIf config.qbit.enable {
    environment.systemPackages = [
      pkgs.qbittorrent
    ];
  };
}
