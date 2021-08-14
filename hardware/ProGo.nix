{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProGo;
in
{
  options.teletypeOne.hardware.ProGo = mkEnableOption "Enable ProGoYoYo";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "sdhci_pci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-partuuid/d64a6ba7-02";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-partuuid/d64a6ba7-01";
      fsType = "ext2";
    };

  swapDevices = [ ];
  };
}
