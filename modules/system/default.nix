{
  lib,
  config,
  ...
}: {
  imports = [
    ./boot.nix
    ./filesystem.nix
    ./networking.nix
    ./zsh.nix
  ];
}
