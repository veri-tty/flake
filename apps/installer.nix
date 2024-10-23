{ pkgs, ... }:
{

  # Inspired by https://github.com/cleverca22/nix-tests/blob/master/kexec/justdoit.nix
  # This script will partition and format drives; use at your own risk!

  type = "app";

  program = builtins.toString (
    pkgs.writeShellScript "installer" ''
      set -e

      DISK=$1
      FLAKE=$2
      PARTITION_PREFIX=""

      if [ -z "$DISK" ] || [ -z "$FLAKE" ]; then
          ${pkgs.gum}/bin/gum style --width 50 --margin "1 2" --padding "2 4" \
              --foreground "#fb4934" \
              "Missing required parameter." \
              "Usage: installer -- <disk> <host>" \
              "Example: installer -- nvme0n1 tempest" \
              "Flake example: nix run github:nmasur/dotfiles#installer -- nvme0n1 tempest"
          echo "(exiting)"
          exit 1
      fi

      case "$DISK" in nvme*)
          PARTITION_PREFIX="p"
      esac

      ${pkgs.gum}/bin/gum confirm \
          "This will ERASE ALL DATA on the disk /dev/''${DISK}. Are you sure you want to continue?" \
          --default=false

      ${pkgs.parted}/bin/parted /dev/''${DISK} -- mklabel gpt
      ${pkgs.parted}/bin/parted /dev/''${DISK} -- mkpart primary 512MiB 100%
      ${pkgs.parted}/bin/parted /dev/''${DISK} -- mkpart ESP fat32 1MiB 512MiB
      ${pkgs.parted}/bin/parted /dev/''${DISK} -- set 3 esp on

      # Set up LUKS encryption
      cryptsetup luksFormat /dev/''${DISK}''${PARTITION_PREFIX}1
      cryptsetup open /dev/''${DISK}''${PARTITION_PREFIX}1 cryptroot

      # Set up LVM inside the LUKS container
      pvcreate /dev/mapper/cryptroot
      vgcreate vg0 /dev/mapper/cryptroot
      lvcreate -L 8G vg0 -n swap
      lvcreate -l 100%FREE vg0 -n root

      # Format the LVM partitions
      mkfs.ext4 /dev/vg0/root
      mkfs.fat -F 32 -n boot /dev/''${DISK}''${PARTITION_PREFIX}2
      mkswap /dev/vg0/swap

      # Mount the filesystems
      mount /dev/vg0/root /mnt
      mkdir --parents /mnt/boot
      mount /dev/disk/by-label/boot /mnt/boot
      swapon /dev/vg0/swap

      ${pkgs.nixos-install-tools}/bin/nixos-install --flake github:nmasur/dotfiles#''${FLAKE}
    ''
  );
}
