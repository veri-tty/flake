{ pkgs, nixvim, ... }: 


  inputs.nixvim.nixosModules.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
  }
