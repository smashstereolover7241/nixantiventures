{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.emulation;
in {
  options.teletypeOne.emulation = {
    enabled = mkEnableOption "Install qemu";
    kvm = mkEnableOption "Install virtmanager";
    virtmanager = mkEnableOption "Install virt-manager";
  };

  config = (mkMerge [
    (mkIf (cfg.enabled) {
      environment.systemPackages = with pkgs; [qemu];
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [(pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd];
          };
        };
      };
    })

    (mkIf (cfg.virtmanager) {
      programs.virt-manager.enable = true;
      users.users.localhost.extraGroups = ["libvirtd"];
      })
  ]);
}
