{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProSlimShady;
in
{
  options.teletypeOne.hardware.ProSlimShady = mkEnableOption "Enable ProSlimShady";

  config = mkIf cfg {

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "SsdFS/root";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "SsdFS/root/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "SsdFS/root/nix";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/69a213d7-d302-46f2-bed5-360156c11e9f";
      fsType = "ext4";
    };

  swapDevices = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };

}
