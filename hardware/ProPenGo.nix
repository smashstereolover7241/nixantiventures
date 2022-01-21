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
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "acpi_rev_override=5" "i915.enable_guc=2" ];
  
  boot.extraModulePackages = [ ];

  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/39a958cf-85ae-4a82-ad1f-9f0b5380fef7";
      fsType = "btrfs";
      options = [ "subvol=Anixos" ];
    };

#  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/36b1cdab-ec0b-40d9-86ce-a6c6a1cac020";

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/36b1cdab-ec0b-40d9-86ce-a6c6a1cac020";
      preLVM = true;
      fallbackToPassword = true;
    };
  };
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/39a958cf-85ae-4a82-ad1f-9f0b5380fef7";
      fsType = "btrfs";
      options = [ "subvol=AnixHome" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/39a958cf-85ae-4a82-ad1f-9f0b5380fef7";
      fsType = "btrfs";
      options = [ "subvol=AnixNix" ];
    };

  swapDevices = [ ];
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
