{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProProGo;
in
{
  options.teletypeOne.hardware.ProNoGo = mkEnableOption "Enable ProProGo";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/56f90ce7-643c-4379-938f-e932fee61dec";
      fsType = "btrfs";
      options = [ "subvol=NixOff" ];
    };

  boot.initrd.luks.devices."sda6_crypt".device = "/dev/disk/by-uuid/86267184-3b66-427b-bba0-76cbcfc5ee2a";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/173D-8262";
      fsType = "vfat";
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;


  };

}
