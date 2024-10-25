### NixOS Configuration
###
### Copyright © 2023 Demis Balbach <db@minikn.xyz>
###
### This file is not part of Nix/NixOS/Home Manager.
###
### My config is free software; you can redistribute it and/or modify it
### under the terms of the GNU General Public License as published by
### the Free Software Foundation; either version 3 of the License, or (at
### your option) any later version.
###
### My config is distributed in the hope that it will be useful, but
### WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU General Public License for more details.
###
### You should have received a copy of the GNU General Public License
### along with my config. If not, see <http://www.gnu.org/licenses/>.
###
### COMMENT:
###
### Filesystem configuration
###
### Machine-specific filesystem should be declared in their corresponding
### machine config.
###
### CODE:

{ config, lib, pkgs, ... }:

{
  # Luks-Crypt 
  boot.initrd.luks.devices."cryptroot".device = "/dev/nvme0n1p2";

  ## Main partition
  fileSystems."/" = {
    device = "/dev/vg0/root";
    fsType = "ext4";
  };

  ## Boot partition
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  ## Swap partition
  swapDevices = [
    { device = "/dev/vg0/swap"; }
  ];
}
