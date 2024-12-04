{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.theming.fonts.iosevka;
in
{
  options.modules.normal.display.theming.fonts.iosevka = {
    enable = mkEnableOption "Enable iosevka font";
  };
  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [(iosevka-bin.override { variant = "Aile"; })];
  };
}
