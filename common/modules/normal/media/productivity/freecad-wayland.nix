{ config, lib, pkgs, ... }:
with lib;
let
  cfgName = strings.nameFromURL (__curPos.file) ".";
  cfg = config.modules.normal.media.productivity.${cfgName};
in
{
  options.modules.normal.media.productivity.${cfgName} = {
    enable = mkEnableOption "Enable ${cfgName}";
  };
  config = {
    environment.systemPackages = mkIf cfg.enable [ pkgs.${cfgName} ];
  };
}
