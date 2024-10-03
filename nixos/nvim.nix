{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.nixvim.packages.${config.system}.default
  ];

  programs.neovim = {
    enable = true;
    package = inputs.nixvim.packages.${config.system};
  };
}
