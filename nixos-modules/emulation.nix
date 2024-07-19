{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.emulation;
in {
  options.teletypeOne.emulation = {
    enabled = mkEnableOption "Install qemu";
    virtmanager = mkEnableOption "Install virt-manager";
  };

  config = (mkMerge [
    (mkIf (cfg.enabled) {
      environment.systemPackages = with pkgs; [qemu];
      virtualisation.libvirtd.enable = true;
    })
    (mkIf (cfg.virtmanager) {
      programs.virt-manager.enable = true;
      users.users.localhost.extraGroups = ["libvirtd"];
      })
  ]);
}
