{
  config,
  pkgs,
  lib,
  ...
}: {
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
