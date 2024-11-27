{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.real.normal.monitoring.tops.htop;
in
{
  options.real.normal.monitoring.tops.htop = {
    enable = mkEnableOption "Enable hair top";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [htop];
  };
}
