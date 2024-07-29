{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.android;
in {
  options.teletypeOne.android = {
    adb = mkEnableOption "Install adb";
    scrcpy = mkEnableOption "Install scrcpy";
    ass = mkEnableOption "Install anstudio";
  };

  config = (mkMerge [
    (mkIf cfg.adb {
      programs.adb.enable = true;
    })

    (mkIf cfg.ass{
      environment.systemPackages = with pkgs; [android-studio];
    })

    (mkIf cfg.scrcpy{
      environment.systemPackages = with pkgs; [scrcpy];
    })
  ]);
}
