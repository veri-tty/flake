{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs;
    lib.mkIf config.obsidian [
      obsidian
    ];
}
