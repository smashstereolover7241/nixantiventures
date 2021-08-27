{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.hardware.ProNoBrain;
in
{
  options.teletypeOne.hardware.ProGo = mkEnableOption "Enable ProNoBrain";

  config = mkIf cfg{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "sdhci_pci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "usb-Intenso_Mobile_Line_1FF79E0A-0:0-part1";
      fsType = "ext4";
    };
  swapDevices = [ ];
  };
}
