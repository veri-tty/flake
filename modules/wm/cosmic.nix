{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];
  services = lib.mkIf config.cosmic.enable {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1
}
