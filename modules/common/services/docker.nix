{ config, lib, pkgs, ... }:

{
  config = {

    virtualisation.docker = {
      enable = true;
    };
    
    users.users.${config.user}.extraGroups = [ "docker" ];

  };
}

