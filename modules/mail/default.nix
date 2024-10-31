{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    mail = {
      address = lib.mkOption {
        type = lib.types.str;
        default = "";
      };

      signature = lib.mkOption {
        type = lib.types.lines;
        description = "Primary signature";
        default = '''';
      };

      clients = {
        thunderbird = {
          enable = lib.mkEnableOption "Enable thunderbird as a mail client";
          primary = lib.mkOption {default = "";};
        };
      };
    };
  };

  imports = [
    ./mailbox.nix
    ./work.nix

    ./clients/thunderbird.nix
  ];
}
