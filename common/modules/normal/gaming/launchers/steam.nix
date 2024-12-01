{ config, lib, pkgs, ... }:
with lib;
let
  cfgName = strings.nameFromURL (__curPos.file) ".";
  cfg = config.modules.normal.gaming.launchers.${cfgName};
in
{
  options.modules.normal.gaming.launchers.${cfgName} = {
    enable = mkEnableOption "Enable ${cfgName}";
  };
  config = {
    programs.steam.enable = cfg.enable;
  };
}
