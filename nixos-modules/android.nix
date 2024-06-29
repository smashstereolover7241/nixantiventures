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
#      environment.systemPackages = with pkgs; [androidenv.androidPkgs_9_0.androidsdk];
    })

    (mkIf cfg.scrcpy{
      environment.systemPackages = with pkgs; [scrcpy];
    })
  ]);
}
