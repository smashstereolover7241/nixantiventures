{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.Ashley;
in
{
  options.teletypeOne.hardware.Ashley= mkEnableOption "Enable Ashley";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "tp_smapi" "new-lg4ff" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ new-lg4ff ];

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
    { device = "/dev/disk/by-uuid/5F0A-97B0";
      fsType = "vfat";
    };

  swapDevices = [ ];

#  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
#  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
