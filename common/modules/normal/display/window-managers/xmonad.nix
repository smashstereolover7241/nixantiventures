{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.real.normal.display.window-managers.xmonad;
in
{
  options.real.normal.display.window-managers.xmonad = {
    enable = mkEnableOption "Enable xmoand";
  };
  config = (mkMerge [
    (mkIf cfg.enable {
      services = {
        xserver.windowManager = {
          xmonad.enable = true;
          xmonad.enableContribAndExtras = true;
        };
        displayManager.defaultSession = "none+xmonad";
      };
    })
  ]);
}
