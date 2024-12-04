{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.servers.xorg.util.libXxf86vm;
in
{
  options.modules.normal.display.servers.xorg.util.libXxf86vm = {
    enable = mkEnableOption "Enable xwininfo";
  };
  config = (mkMerge [
    (mkIf cfg.enable {
        environment.systemPackages = with pkgs; [xorg.libXxf86vm ];
    })
  ]);
}
