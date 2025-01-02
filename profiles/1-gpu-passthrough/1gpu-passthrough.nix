{
  pkgs,
  config,
  lib,
  ...
}: let
  VIRSH_GPU_VIDEO = "pci_0000_26_00_0";
  VIRSH_GPU_AUDIO = "pci_0000_26_00_1";
  vfioStartup = pkgs.writers.writeBashBin "vfio-startup" ''
    # Helpful to read output when debugging
    set -x
    echo "startup: start"

    # Load the config file with our environmental variables
    #source "/etc/libvirt/hooks/kvm.conf"

    # Stop your display manager. If youre on kde it ll be sddm.service. Gnome users should use killall gdm-x-session instead
    pkill Hyprland
    #pulse_pid=$(pgrep -u YOURUSERNAME pulseaudio)
    #pipewire_pid=$(pgrep -u YOURUSERNAME pipewire-media)
    #kill $pulse_pid
    #kill $pipewire_pid

    # Unbind VTconsoles
    echo 0 > /sys/class/vtconsole/vtcon0/bind
    echo 0 > /sys/class/vtconsole/vtcon1/bind


    # Avoid a race condition by waiting a couple of seconds. This can be calibrated to be shorter or longer if required for your system
    sleep 4

    # Unload all Radeon drivers

    modprobe -r nvida
    modprobe -r nvida_drm
    #modprobe -r snd_hda_intel
    #modprobe -r drm_kms_helper
    #modprobe -r i2c_algo_bit
    #modprobe -r drm
    modprobe -r snd_hda_intel

    # Unbind the GPU from display driver
    virsh nodedev-detach ${VIRSH_GPU_VIDEO}
    virsh nodedev-detach ${VIRSH_GPU_AUDIO}

    # Load VFIO kernel module
    modprobe vfio
    modprobe vfio_pci
    modprobe vfio_iommu_type1
    echo "startup: end"
  '';

  vfioTeardown = pkgs.writers.writeBashBin "vfio-teardown" ''
    # Helpful to read output when debugging
    set -x
    echo "teardown: start"

    # Load the config file with our environmental variables
    #source "/etc/libvirt/hooks/kvm.conf"

    # Unload all the vfio modules
    modprobe -r vfio_pci
    modprobe -r vfio_iommu_type1
    modprobe -r vfio

    # Reattach the gpu
    virsh nodedev-reattach ${VIRSH_GPU_VIDEO}
    virsh nodedev-reattach ${VIRSH_GPU_AUDIO}

    # Load all Radeon drivers

    modprobe nvida
    modprobe nvida_drm
    modprobe snd_hda_intel

    #Start you display manager
    Hyprland
    echo "teardown: end"
  '';

  qemuHook = pkgs.writers.writeBashBin "qemu" ''
    OBJECT="$1"
    OPERATION="$2"

    if [[ $OBJECT == *"-gpu" ]]; then
        case "$OPERATION" in
                "prepare")
                    ${vfioStartup}/bin/vfio-startup 2>&1 | tee -a /var/log/libvirt/custom_hooks.log
                    ;;

                    "release")
                    ${vfioTeardown}/bin/vfio-teardown 2>&1 | tee -a /var/log/libvirt/custom_hooks.log
                    ;;
        esac
    fi
  '';

  hookInstaller = pkgs.writers.writeBashBin "installer" ''
    hookPath="/var/lib/libvirt/hooks/qemu"
    hookSource="${qemuHook}/bin/qemu"

    mkdir -p $(dirname "$hookPath")

    if [ "$hookSource" != "$(realpath $hookPath)" ]; then
      ln -svf "$hookSource" "$hookPath"
    fi

    exit 0
  '';
in {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
  };

  programs.virt-manager.enable = true;

  boot.kernelParams = ["kvm_amd.nested=0" "iommu=pt"];
  boot.kernelModules = ["kvm-amd" "vfio-pci"];
  users.users.ml = {
    extraGroups = ["libvirtd"];
  };

  systemd.services.libvirtd = {
    preStart = "${hookInstaller}/bin/installer";
    path = with pkgs; [
      kmod
      util-linux
      systemd
      libvirt
    ];
  };
}
