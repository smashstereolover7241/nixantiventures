{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProNoGo;
in
{
  options.teletypeOne.hardware.ProGo = mkEnableOption "Enable ProNoGo";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "zroot/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "zroot/root/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zroot/root/home";
      fsType = "zfs";
    };

  #fileSystems."/zroot" =
  #  { device = "zroot";
  #    fsType = "zfs";
  #  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/065ef8a9-521f-4f2f-822b-ef024ed05361";
      fsType = "ext2";
    };

  fileSystems."/FjordMain" =
    { device = "zroot/FjordMainCompress";
      fsType = "zfs";
    };

  swapDevices = [ ];
  };
}
