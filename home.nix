{ config, pkgs, ... }:

{
  imports = [
  ./home/shell/fish/default.nix
  ];

  home.username = "verity";
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
