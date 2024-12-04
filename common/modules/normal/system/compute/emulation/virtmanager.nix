{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.compute.emulation.virtmanager;
in
{
  options.modules.normal.system.compute.emulation.virtmanager = {
    enable = mkEnableOption "manage qemu";
  };

  config = mkIf cfg.enable {
    programs.virt-manager.enable = true;
    users.users.localhost.extraGroups = ["libvirtd"]; #TODO: Figure out current user
  };
}
