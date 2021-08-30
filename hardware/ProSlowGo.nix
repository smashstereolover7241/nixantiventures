{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProSlowGo;
in
{
  options.teletypeOne.hardware.ProSlowGo= mkEnableOption "Enable ProSlowGo";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "slow/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "slow/root/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "slow/root/home";
      fsType = "zfs";
    };

  #fileSystems."/slow" =
  #  { device = "slow";
  #    fsType = "zfs";
  #  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-partuuid/2e4dee3f-01";
      fsType = "ext2";
    };


  swapDevices = [ ];
  };
}
