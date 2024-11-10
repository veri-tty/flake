{lib, ...}: {
  imports = [
    ./cosmic.nix
    ./plasma-6.nix
    ./sway/sway.nix
    ./hypr/hyprland.nix
  ];
  options = {
    wm = {
      sway = {
        enable = lib.mkEnableOption {
          description = "Sway or not.";
          default = false;
        };
      };
      cosmic = {
        enable = lib.mkEnableOption {
          description = "Cosmic DE (in alpha right now) or not.";
          default = false;
        };
      };
      hyprland = {
        enable = lib.mkEnableOption {
          description = "Enable HyprWM";
          default = "false";
        };
      };
      plasma-6 = {
        enable = lib.mkEnableOption {
          description = "Enable the Plasma 6 Desktop Environment";
          default = "false";
        };
      };
    };
  };
}
