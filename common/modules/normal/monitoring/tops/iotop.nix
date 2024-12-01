{ config, lib, pkgs, ... }:
with lib;
let
  cfgName = strings.nameFromURL (__curPos.file) ".";
  cfg = modules.normal.monitoring.tops.${cfgName};
in
{
  options.modules.normal.monitoring.tops.${cfgName} = {
    enable = mkEnableOption "Enable ${cfgName}";
  };
  config = {
    environment.systemPackages = [ pkgs.${cfgName} ];
  };
}
