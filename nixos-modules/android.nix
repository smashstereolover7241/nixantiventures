{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.android;
in {
  options.teletypeOne.android = {
    adb = mkEnableOption "Install adb";
    scrcpy = mkEnableOption "Install scrcpy";
  };

  config = (mkMerge [
    (mkIf cfg.adb {
      programs.adb.enable = true;
    })

    (mkIf cfg.scrcpy{
      environment.systemPackages = with pkgs; [scrcpy];
    })
  ]);
}
