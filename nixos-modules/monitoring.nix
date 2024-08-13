{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.monitoring;
in {
  options.teletypeOne.monitoring = {
    htop = mkEnableOption "Install htop";
    iotop = mkEnableOption "Install iotop";
    btop = mkEnableOption "Install glances";
    glances = mkEnableOption "Install glances";
    nvtop = mkEnableOption "Install nvtop";
    missioncenter = mkEnableOption "Install mission-center";
  };
  config = (mkMerge [

    (mkIf cfg.htop {
      environment.systemPackages = with pkgs; [htop];
    })

    (mkIf cfg.iotop{
      environment.systemPackages = with pkgs; [iotop];
    })

    (mkIf cfg.btop {
      environment.systemPackages = with pkgs; [btop];
    })

    (mkIf cfg.glances {
      environment.systemPackages = with pkgs; [glances];
    })

    (mkIf cfg.nvtop {
      environment.systemPackages = with pkgs; [nvtopPackages.full];
    })

    (mkIf cfg.missioncenter {
      environment.systemPackages = with pkgs; [mission-center];
    })
  ]);
}
