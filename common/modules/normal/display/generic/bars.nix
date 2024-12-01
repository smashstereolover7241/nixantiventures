{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.generic.bars;
in
{
  options.modules.normal.display.generic.bars = {
    waybar = mkEnableOption "Install waybar";
    xmobar = mkEnableOption "Install xmobar";
  };

  config = (mkMerge [
     { environment.systemPackages = mkIf cfg.waybar (with pkgs; [waybar]); }
     { environment.systemPackages = mkIf cfg.xmobar (with pkgs; [xmobar]); }
  ]);
}
