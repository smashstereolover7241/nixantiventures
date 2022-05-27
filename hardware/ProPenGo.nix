{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProPenGo;
in
{
  options.teletypeOne.hardware.ProPenGo = mkEnableOption "Enable ProPenGo";

  config = mkIf cfg {

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."p2_crypt".device = "/dev/disk/by-uuid/36b1cdab-ec0b-40d9-86ce-a6c6a1cac020";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/39a958cf-85ae-4a82-ad1f-9f0b5380fef7";
      fsType = "btrfs";
      options = [ "subvol=nixroot" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/03287040-9ad3-4e0c-b3fa-5dad010a3b94";
      fsType = "ext2";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/39a958cf-85ae-4a82-ad1f-9f0b5380fef7";
      fsType = "btrfs";
      options = [ "subvol=nixnix" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/39a958cf-85ae-4a82-ad1f-9f0b5380fef7";
      fsType = "btrfs";
      options = [ "subvol=nixhome" ];
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
