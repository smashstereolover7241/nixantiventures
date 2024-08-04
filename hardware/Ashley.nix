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
    { device = "storeFS/nixos";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "storeFS/nixos/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "storeFS/nixos/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3F50-EC00";
      fsType = "vfat";
    };

  swapDevices = [ ];

#  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
#  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
