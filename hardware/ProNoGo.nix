{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProNoGo;
in
{
  options.teletypeOne.hardware.ProNoGo = mkEnableOption "Enable ProNoGo";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  services.qemuGuest.enable = true;

  fileSystems."/" =
    { device = "sonicFS/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "sonicFS/root/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "sonicFS/root/home";
      fsType = "zfs";
    };

  #fileSystems."/zroot" =
  #  { device = "zroot";
  #    fsType = "zfs";
  #  };

#  fileSystems."/boot" =
#    { device = "/dev/disk/by-uuid/993a732c-9fe7-4b2b-b24c-59d4a3cb0960";
#      fsType = "ext4";
#    };


  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A176-D6ED";
      fsType = "vfat";
    };


  swapDevices = [ ];
  };
}

