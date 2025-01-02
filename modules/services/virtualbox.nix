{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    virtualbox = {
      enable = lib.mkEnableOption {
        description = "Enable Virtualbox VM Service";
        default = false;
      };
    };
  };
  config = {
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    users.users.${config.user} = {
      extraGroups = ["vboxusers"];
    };
  };
}
