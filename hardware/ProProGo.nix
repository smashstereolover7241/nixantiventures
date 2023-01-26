{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProProGo;
in
{
  options.teletypeOne.hardware.ProProGo = mkEnableOption "Enable ProProGo";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "tp_smapi"];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "mainFS/nixroot";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "mainFS/nixroot/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "mainFS/nixroot/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EE53-CA2C";
      fsType = "vfat";
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };

}
