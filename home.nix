{ config, pkgs, ... }:

{
  home.username = "verity";
  home.homeDirectory = "/home/verity/";

  programs.home-manager.enable = true;
}
