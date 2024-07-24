{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.remote;
in
{
  options.teletypeOne.hardware.remote = mkEnableOption "Enable remote";

  config = mkIf cfg {

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" "virtio_net" "virtio_mmio" "virtio_blk" "virtio_scsi" "9p" "9pnet_virtio" ];
  boot.initrd.kernelModules = [ "virtio_balloon" "virtio_console" "virtio_rng" "virtio_gpu" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  boot.supportedFilesystems = [ "zfs" ];

  fileSystems."/" =
    { device = "srvZFS/root";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ADD8-5916";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/home" =
    { device = "srvZFS/root/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "srvZFS/root/nix";
      fsType = "zfs";
    };

  boot.initrd.luks.devices = {
   root = {
     device = "/dev/disk/by-uuid/3f441467-5cb1-4378-9f6c-7a241e24c156";
     preLVM = true;
   };
  };

  swapDevices = [ ];

  };
}
