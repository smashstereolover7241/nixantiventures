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

  fileSystems."/" =
    { device = "ssdFS";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "ssdFS/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "ssdFS/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ländersache";
      fsType = "vfat";
    };

  swapDevices = [ ];

  };
}
