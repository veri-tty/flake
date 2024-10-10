{ pkgs, lib, ... }:

{

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;

  
    plugins = {
      treesitter = {
        enable = true;
	settings.highlight.enable = true;
      };
    
      lsp = {
        enable = true;
      };
       
    };
  };
}
