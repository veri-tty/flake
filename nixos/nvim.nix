{ pkgs, lib, ... }:

{

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;

  
    plugins = {
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          rust
          nix
          bash
          fish
          toml
          yaml
          lua
          vimdoc
        ];
      };
    
      lsp = {
        enable = true;
      };
       
    };
  };
}
