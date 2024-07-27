{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.Luna;
in
{
  options.teletypeOne.hardware.Luna= mkEnableOption "Enable Luna";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "ssdFS";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "ssdFS/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "ssdFS/nix";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/732c1ff9-d271-42ec-af66-226e4c1c3064";
      fsType = "ext4";
    };

  swapDevices = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
