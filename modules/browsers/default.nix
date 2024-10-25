{ config, lib, pkgs, ... }:

{
 options = {
    chromium = {
      enable = lib.mkEnableOption {
        description = "Enable Chromium.";
        default = false;
      };
    };
  };

config = lib.mkIf (config.gui.enable && config.chromium.enable) {
  home-manager.users.${config.user}.programs.chromium = {
    enable = true;

    commandLineArgs = lib.mkIf (config.os.wayland) [
      "--enable-features=UseOzonePlatform"
      "--enable-features=WebRTCPipeWireCapturer"
      "--disable-features=WaylandWindowDecorations"
      "--ozone-platform=wayland"
    ];

    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # stylus
    ];
  };
}
