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
    { device = "MainFS/nixroot";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "MainFS/nixroot/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "MainFS/nixroot/nix";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ecc1fd7a-d2f4-4d89-a53b-f7db38e73203";
      fsType = "ext4";
    };

  swapDevices = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };

}
