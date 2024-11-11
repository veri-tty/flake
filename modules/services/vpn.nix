{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    tailscale = {
      enable = lib.mkEnableOption {
        description = "Enable Tailscale VPN";
        default = false;
      };
    };
    mullvad = {
      enable = lib.mkEnableOption {
        description = "Enable Mullvad VPN";
        default = false;
      };
    };
  };
  config = {
    # Conditionally enable Tailscale
    services.tailscale = lib.mkIf config.tailscale.enable {
      enable = true;
    };

    # Conditionally enable Mullvad VPN
    services.mullvad-vpn = lib.mkIf config.mullvad.enable {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}
