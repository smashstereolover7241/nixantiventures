{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProNoGo;
in
{
  options.teletypeOne.hardware.ProNoGo = mkEnableOption "Enable ProNoGo";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  services.qemuGuest.enable = true;

  fileSystems."/" =
    { device = "mainFS/root";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "mainFS/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "storeFS/nix";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7BFD-BE97";
      fsType = "vfat";
    };

  swapDevices = [ ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}

