{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    os.fonts = {
      size = lib.mkOption {
        type = lib.types.int;
        default = 16;
      };

      mono = {
        regular = lib.mkOption {
          type = lib.types.str;
          description = "Default monospaced font";
          default = "Victor Mono";
        };

        light = lib.mkOption {
          type = lib.types.str;
          description = "Default monospaced font";
          default = "${config.font} Light";
        };
      };

      sans = {
        regular = lib.mkOption {
          type = lib.types.str;
          description = "Default sans font";
          default = "Iosevka Aile";
        };
      };

      sans-serif = {
        regular = lib.mkOption {
          type = lib.types.str;
          description = "Default sans-serif font";
          default = "Iosevka Etoile";
        };
      };

      emoji = {
        regular = lib.mkOption {
          type = lib.types.str;
          description = "Default emoji font";
          default = "Noto Color Emoji";
        };
      };
    };
  };

  config = {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = ["Vicotr Mono"];
          serif = ["Iosevka Etoile"];
          sansSerif = ["Iosevka Aile"];
        };
      };
      packages = with pkgs; [
        victor-mono
        (nerdfonts.override {fonts = ["Iosevka"];})
        (iosevka-bin.override {variant = "Aile";})
        (iosevka-bin.override {variant = "Etoile";})
        noto-fonts-emoji
      ];
    };
  };
}
