{ config, pkgs, ... }:

let
  nixvim = pkgs.nixvim;
in
{
  environment.systemPackages = [
    nixvim
  ];

  programs.neovim = {
    enable = true;
    package = nixvim;
  };
}
