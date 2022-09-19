{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProVerySlowGo;
in
{
  options.teletypeOne.hardware.ProVerySlowGo= mkEnableOption "Enable ProVerySlowGo";

  config = mkIf cfg{


  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ata_piix" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "slow/root";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "slow/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "slow/root/nix";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/c84cd6b3-143b-4db8-9a53-2a48fd1199ea";
      fsType = "ext4";
    };

  swapDevices = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;

  };
}
