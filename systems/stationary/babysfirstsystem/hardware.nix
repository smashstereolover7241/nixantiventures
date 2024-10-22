{ config, lib, pkgs, ... }:

{

boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

fileSystems."/" =
    { device = "/dev/disk/by-uuid/noU";
      fsType = "ext4";
    };

      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

  swapDevices = [ ];
}
