{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.media.android.adb;
in
{
  options.modules.normal.media.android.adb = {
    enable = mkEnableOption "Enable adb";
  };
  config = {
    programs.adb.enable = mkIf cfg.enable true;
  };
}
