{ pkgs, ... }:

{
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn; 
  services.tailscale.enable = true;
  environment.systemPackages = with pkgs; [
    mullvad-closest
  ];

}
