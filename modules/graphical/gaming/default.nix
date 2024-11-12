{lib, ...}: {
  imports = [
    ./interactive-fiction.nix
    ./wine.nix
    ./steam.nix
    ./lutris.nix
  ];
  options = {
    gaming = {
      int-fic = {
        enable = lib.mkEnableOption {
          description = "Whether to enable the Gargoyle Interactive Fiction Interpreter";
          default = false;
        };
      };
      wine = {
        enable = lib.mkEnableOption {
          description = "Whether to enable the Wine compatibility layer";
          default = false;
        };
      };
      steam = {
        enable = lib.mkEnableOption {
          description = "Whether to enable Steam";
          default = false;
        };
      };
      lutris = {
        enable = lib.mkEnableOption {
          description = "Whether to enable Lutris";
          default = false;
        };
      };
    };
  };
}
