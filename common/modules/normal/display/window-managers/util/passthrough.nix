{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.window-managers.util.passthrough;
in
{
  options.modules.normal.display.window-managers.util.passthrough = {
    enable = mkEnableOption "Gpu is passed thru";
  };
    config = (mkMerge [
    (mkIf cfg.enable {
      services.xserver.extraConfig = ''
        Section "Device"
        Identifier "YAY"
        BusID "PCI:0:6:0"
        EndSection
      '';
    })

  ]);
}
