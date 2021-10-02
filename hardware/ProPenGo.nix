{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProPenGo;
in
{
  options.teletypeOne.hardware.ProPenGo = mkEnableOption "Enable ProPenGo";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "kvm-intel" ];
  boot.kernelModules = [ ];
  boot.kernelParams = [ ];
  
  boot.extraModulePackages = [ ];
  #boot.zfs.devNodes = "/dev/disk/by-label";
  boot.initrd.supportedFilesystems = [ "zfs"];
  boot.supportedFilesystems = [ "zfs" ];
  fileSystems."/" =
    { device = "ssdRoot/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "ssdRoot/root/nix";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/home" =
    { device = "ssdRoot/root/home";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-partuuid/c6657c07-f2af-4e41-b9c7-cdc7b245c84a";
      fsType = "vfat";
    };
  swapDevices = [ ];
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  };
}
