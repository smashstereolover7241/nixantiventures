{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.theming.fonts.nerdfonts;
in
{
  options.modules.normal.display.theming.fonts.nerdfonts = {
    enable = mkEnableOption "Enable some nerdfonts thingys idk";
  };
  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "FiraMono" "JetBrainsMono" ]; })];
  };
}
