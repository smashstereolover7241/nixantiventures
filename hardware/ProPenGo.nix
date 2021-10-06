{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProPenGo;
in
{
  options.teletypeOne.hardware.ProPenGo = mkEnableOption "Enable ProPenGo";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "rtsx_pci_sdmmc" "ehci_pci" "ahci" "firewire_ohci" "sdhci_pci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "kvm-intel" ];
  boot.kernelModules = [  ];
  boot.kernelParams = [ "nohibernate" "mem_sleep_default=deep" "idle=nomwait"];
  
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
    { device = "/dev/disk/by-partuuid/b3f9c3f8-02";
      fsType = "vfat";
    };
  swapDevices = [ ];
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  };
}
