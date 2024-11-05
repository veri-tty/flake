{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = ["Victor Mono"];
        };
      };
      packages = with pkgs; [
        victor-mono
        noto-fonts-emoji
      ];
    };
  };
}
