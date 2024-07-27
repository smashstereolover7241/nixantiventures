{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.Ana;
in
{
  options.teletypeOne.hardware.Ana= mkEnableOption "Enable Ana"; #X230

  config = mkIf cfg {

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "anaFS/nixos";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "anaFS/nixos/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "anaFS/nixos/nix";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9323-B9C3";
      fsType = "vfat";
    };

  boot.initrd.luks.devices = {
   root = {
     device = "/dev/disk/by-uuid/439af819-76a9-4732-8a92-f1a82d4f51e5";
     preLVM = true;
   };
  };

  swapDevices = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };

}
