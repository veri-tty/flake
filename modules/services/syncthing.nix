{
  pkgs,
  globals,
  lib,
  config,
  ...
}: {
  options = {
    syncthing = {
      enable = lib.mkEnableOption {
        description = "Enable Syncthing Service";
        default = false;
      };
    };
  };
  config = {
    services = lib.mkIf config.syncthing.enable {
      syncthing = {
        enable = true;
        user = "ml";
        dataDir = "/home/ml";
        configDir = "/home/ml/.config/syncthing";
        overrideDevices = true; # overrides any devices added or deleted through the WebUI
        overrideFolders = true; # overrides any folders added or deleted through the WebUI
        settings = {
          devices = {
            "root" = {id = "KSXCPVB-3TXMB22-XN227QU-UCHBCQ6-MAVFCUT-ASUMEJ7-UMKVA2O-IULF7QO";};
          };
        };
      };
    };
  };
}
