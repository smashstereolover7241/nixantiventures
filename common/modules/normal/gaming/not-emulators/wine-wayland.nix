{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.gaming.not-emulators.wine-wayland;
in
{
  options.modules.normal.gaming.not-emulators.wine-wayland = {
    enable = mkEnableOption "Enable wayland for wine";
  };
  config = (mkMerge [
    (mkIf cfg.enable {
        environment.systemPackages = with pkgs; [ wineWowPackages.waylandFull ];
    })
  ]);
}
