{ config, lib, pkgs, ... }:
with lib;
let
  cfgName = strings.nameFromURL (__curPos.file) ".";
  cfg = config.modules.normal.system.terminals.${cfgName};
in
{
  options.modules.normal.system.terminals.${cfgName} = {
    enable = mkEnableOption "Enable ${cfgName}";
  };
  config = {
    environment.systemPackages = mkIf cfg.enable [ pkgs.${cfgName} ];
  };
}
