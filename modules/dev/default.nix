{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ./git.nix
    ./neovim
    #./minecraft-server.nix
    #./moonlight.nix
    #./ryujinx.nix
    #./steam.nix
  ];


  options.development.enable = lib.mkEnableOption "Enable development features.";

  config = lib.mkIf (config.development.enable) {
    environment.systemPackages  with pkgs; = [
    wget
    curl
    ];
  };
}