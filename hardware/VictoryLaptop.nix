{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.VictoryLaptop;
in
{
  options.teletypeOne.hardware.VictoryLaptop = mkEnableOption "Enable VictoryLaptop";

  config = mkIf cfg {

  boot.initrd.availableKernelModules = [ "ahci" "ohci_pci" "ehci_pci" "pata_atiixp" "usb_storage" "ums_realtek" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "HjoenkHjoenk/nixroot";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "HjoenkHjoenk/nixroot/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "HjoenkHjoenk/nixroot/nix";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/587a8b00-594e-486e-907d-2c1e86ad9eb3";
      fsType = "ext4";
    };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  swapDevices = [ ];
  };
}

