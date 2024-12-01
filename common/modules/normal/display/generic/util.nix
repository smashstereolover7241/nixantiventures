{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.generic.util;
in
{
  options.modules.normal.display.generic.util = {
    stalonetray = mkEnableOption "install stalonetray";
    dunst = mkEnableOption "Enable dunst";
    passthrough = mkEnableOption "Gpu is passed thru";
  };
    config = (mkMerge [
    (mkIf cfg.stalonetray {
      environment.systemPackages = [ pkgs.stalonetray ];
    })
    (mkIf cfg.dunst{
      environment.systemPackages = (with pkgs; [dunst]);
    })
    (mkIf cfg.passthrough {
      services.xserver.extraConfig = ''
        Section "Device"
        Identifier "YAY"
        BusID "PCI:0:6:0"
        EndSection
      '';
    })
  ]);
}
