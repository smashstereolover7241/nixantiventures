{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.compute.emulation.qemu;
in
{
  options.modules.normal.system.compute.emulation.qemu = {
    enable = mkEnableOption "Qemu, the thing for vms (also kvm)";
  };

  config = mkIf cfg.enable {
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
  };
}
