{
  lib,
  config,
  ...
}: {
  imports = [
    ./terminal.nix
    ./theme.nix
    ./thunderbird.nix
  ];
  options = {
    terminal = lib.mkOption {
      type = lib.types.str;
      description = "Default terminal emulator";
      default = "kitty";
    };
    thunderbird = {
      enable = lib.mkEnableOption {
        description = "Enable Thunderbird";
        default = false;
      };
    };
  };
}
