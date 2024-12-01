{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.servers.xorg;
in
{
  options.modules.normal.display.servers.xorg = {
    enable = mkEnableOption "Enable the X window system";
  };
  config = (mkMerge [
    (mkIf cfg.enable {
      services.xserver.enable = true;
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    })
  ]);
}
