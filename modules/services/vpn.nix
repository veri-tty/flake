{ config, pkgs, lib, ... }: {
  config = {
    # Conditionally enable Tailscale
    lib.mkIf config.tailscale {
      services.tailscale.enable = true;
    };
    # Conditionally enable Mullvad VPN
    lib.mkIf config.mullvad {
      services.mullvad-vpn.enable = true;
      services.mullvad-vpn.package = pkgs.mullvad-vpn;
    };
  };
}