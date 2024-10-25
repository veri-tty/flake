{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ./dwarf-fortress.nix
    #./lutris.nix
    #./minecraft-server.nix
    #./moonlight.nix
    #./ryujinx.nix
    #./steam.nix
  ];

  options.gaming.enable = lib.mkEnableOption "Enable gaming features.";

  config = lib.mkIf (config.gaming.enable) {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    programs.gamemode.enable = true;
  };
}