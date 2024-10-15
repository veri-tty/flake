{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.rustup
    pkgs.gcc
  ];
}

