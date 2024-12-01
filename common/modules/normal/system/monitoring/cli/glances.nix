{ config, lib, pkgs, ... }:
with lib;
let
  cfgName = strings.nameFromURL (__curPos.file) ".";
  cfg = config.modules.normal.system.monitoring.cli.${cfgName};
in
{
  options.modules.normal.system.monitoring.cli.${cfgName} = {
    enable = mkEnableOption "Enable ${cfgName}";
  };
  config = {
    environment.systemPackages = mkIf cfg.enable [ pkgs.${cfgName} ];
  };
}
