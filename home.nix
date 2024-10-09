{ config, pkgs, ... }:

{
  home.username = "verity";
  home.homeDirectory = "/home/verity/";

  programs.home-manager.enable = true;
  home-manager.users.verity.home.stateVersion = "24.05"
}
