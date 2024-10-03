{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.nixvim.nixosModules.nixvim
  ];

  programs.neovim = {
    enable = true;
    package = inputs.nixvim.nixosModules.nixvim;
  };
}
