{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.real.normal.monitoring.tops.iotop;
in
{
  options.real.normal.monitoring.tops.iotop = {
    enable = mkEnableOption "Enable iotop";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [iotop];
  };
}
