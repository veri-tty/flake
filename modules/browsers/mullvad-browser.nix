{ pkgs, ... }:

{ 
environment.systemPackages = [
    pkgs.mullvad-browser
  ];
}
