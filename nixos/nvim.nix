{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      inputs.nixvim.packages.${system}.default
    ];
  };

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
  };
}
