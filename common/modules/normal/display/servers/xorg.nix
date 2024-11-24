{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.real.normal.display.servers.xorg;
in
{
  options.real.normal.display.servers.xorg = {
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
