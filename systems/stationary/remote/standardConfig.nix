{ config, lib, pkgs, ... }:

{
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";

    networking.hostId = "5457b35a"; # probably should put this somewhere else, this file is supposed to be easily overwritable
}
