{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.gaming.not-emulators.wine-stable;
in
{
  options.modules.normal.gaming.not-emulators.wine-stable = {
    enable = mkEnableOption "Enable wine-stable";
  };
  config = (mkMerge [
    (mkIf cfg.enable {
        environment.systemPackages = with pkgs; [ wineWowPackages.stable ];
    })
  ]);
}
