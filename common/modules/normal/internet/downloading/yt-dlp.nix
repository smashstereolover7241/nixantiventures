{ config, lib, pkgs, ... }:
with lib;
let
  cfgName = strings.nameFromURL (__curPos.file) ".";
  cfg = config.modules.normal.internet.downloading.${cfgName};
in
{
  options.modules.normal.internet.downloading.${cfgName} = {
    enable = mkEnableOption "Enable ${cfgName}";
  };
  config = {
    environment.systemPackages = mkIf cfg.enable [ pkgs.${cfgName} ];
  };
}
