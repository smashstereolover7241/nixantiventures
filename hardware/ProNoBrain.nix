{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProNoBrain;
in
{
  options.teletypeOne.hardware.ProNoBrain = mkEnableOption "Enable ProNoBrain";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "sdhci_pci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "zsRoot/root";
      fsType = "zfs";
    };

  fileSystems."/nix " =
    { device = "zsRoot/root/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zsRoot/root/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-partuuid/1a89f7eb-8865-5843-a672-b2a50e6d2359";
      fsType = "ext2";
    };
  swapDevices = [ ];
  };
}
