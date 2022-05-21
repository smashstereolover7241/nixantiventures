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
    { device = "/dev/disk/by-uuid/d96d630c-38cb-483f-83e2-2ecd0980c003";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  boot.initrd.luks.devices."sda3_crypt".device = "/dev/disk/by-uuid/95f43cb6-ce30-496a-abf3-b850d206a31a";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/93BF-1420";
      fsType = "vfat";
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;


  };

}
