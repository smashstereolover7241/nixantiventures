{ config, lib, pkgs, ... }:
with lib;
let
  cfgName = strings.nameFromURL (__curPos.file) ".";
  cfg = config.modules.normal.gaming.launchers.generic.${cfgName};
in
{
  options.modules.normal.gaming.launchers.generic.${cfgName} = {
    enable = mkEnableOption "Enable steam";
  };
  config = {
    programs.steam.enable = cfg.enable;
  };
}
