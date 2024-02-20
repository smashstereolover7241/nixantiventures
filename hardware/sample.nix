{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.sample;
in
{
  options.teletypeOne.hardware.sample = mkEnableOption "Enable sample";

  config = mkIf cfg {

  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "ssdFS";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "ssdFS/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "ssdFS/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ländersache";
      fsType = "vfat";
    };

  swapDevices = [ ];

#  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
#  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
