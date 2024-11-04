{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.i2p
  ];
}
